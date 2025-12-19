-- 1. Overall latency distribution for agentic tool-calling RAG by provider (mean, median, percentiles)
-- OpenAI (gpt-5-nano): messageids 315-402
-- Ollama (gpt-oss-20b): messageids 412-501
WITH
    provider_data AS (
        SELECT
            CASE
                WHEN messageid BETWEEN 315 AND 402 THEN 'OpenAI (gpt-5-nano)'
                WHEN messageid BETWEEN 412 AND 501 THEN 'Ollama (gpt-oss-20b)'
            END AS provider,
            total,
            tools,
            embedding,
            llm,
            (metrics -> 'toolCalls' ->> 'count')::NUMERIC AS tool_calls,
            (metrics -> 'modelCalls' ->> 'count')::NUMERIC AS llm_calls
        FROM
            public.AIChatPerformance
        WHERE
            messageid BETWEEN 315 AND 402
            OR messageid BETWEEN 412 AND 501
    )
SELECT
    provider,
    COUNT(*) AS total_queries,
    AVG(total) AS mean_total_ms,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY
            total
    ) AS median_total_ms,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
        ORDER BY
            total
    ) AS p95_total_ms,
    AVG(tools) AS mean_tools_ms,
    AVG(embedding) AS mean_embedding_ms,
    AVG(llm) AS mean_llm_ms,
    AVG(tool_calls) AS avg_tool_calls,
    AVG(llm_calls) AS avg_llm_calls
FROM
    provider_data
GROUP BY
    provider
ORDER BY
    provider;
