-- 10. Tool calling patterns and multi-turn behavior by provider
-- OpenAI (gpt-5-nano): messageids 315-402
-- Ollama (gpt-oss-20b): messageids 412-501
WITH
    tool_stats AS (
        SELECT
            CASE
                WHEN messageid BETWEEN 315 AND 402 THEN 'OpenAI (gpt-5-nano)'
                WHEN messageid BETWEEN 412 AND 501 THEN 'Ollama (gpt-oss-20b)'
            END AS provider,
            (metrics -> 'toolCalls' ->> 'count')
                ::INTEGER AS tool_count,
            (metrics -> 'toolCalls' ->> 'total')
                ::NUMERIC AS tool_duration_ms,
            tools AS tool_duration_direct_ms
        FROM
            public.AIChatPerformance
        WHERE
            messageid BETWEEN 315 AND 402
            OR messageid BETWEEN 412 AND 501
    )
SELECT
    provider,
    MIN(tool_count) AS min_tools,
    MAX(tool_count) AS max_tools,
    AVG(tool_count) AS avg_tools,
    COUNT(*) FILTER (
        WHERE
            tool_count = 1
    ) AS single_tool_queries,
    COUNT(*) FILTER (
        WHERE
            tool_count > 1
    ) AS multi_tool_queries,
    ROUND(
        COUNT(*) FILTER (
            WHERE
                tool_count > 1
        )::NUMERIC / NULLIF(COUNT(*), 0) * 100,
        2
    ) AS multi_tool_pct
FROM
    tool_stats
GROUP BY
    provider
ORDER BY
    provider;
