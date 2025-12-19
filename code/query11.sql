-- 11. LLM call patterns by provider (initial decision + final response)
-- OpenAI (gpt-5-nano): messageids 315-402
-- Ollama (gpt-oss-20b): messageids 412-501
WITH
    llm_stats AS (
        SELECT
            CASE
                WHEN messageid BETWEEN 315 AND 402 THEN 'OpenAI (gpt-5-nano)'
                WHEN messageid BETWEEN 412 AND 501 THEN 'Ollama (gpt-oss-20b)'
            END AS provider,
            (metrics -> 'modelCalls' ->> 'count')
                ::INTEGER AS llm_call_count,
            (metrics -> 'modelCalls' -> 'individual' -> 0)
                ::NUMERIC AS first_call_ms,
            (metrics -> 'modelCalls' -> 'individual' -> 1)
                ::NUMERIC AS second_call_ms,
            llm AS total_llm_ms
        FROM
            public.AIChatPerformance
        WHERE
            messageid BETWEEN 315 AND 402
            OR messageid BETWEEN 412 AND 501
    )
SELECT
    provider,
    AVG(llm_call_count) AS avg_llm_calls,
    AVG(first_call_ms) AS mean_first_call_ms,
    AVG(second_call_ms) AS mean_second_call_ms,
    AVG(second_call_ms / NULLIF(first_call_ms, 0)) AS second_to_first_ratio,
    AVG(total_llm_ms) AS mean_total_llm_ms
FROM
    llm_stats
GROUP BY
    provider
ORDER BY
    provider;
