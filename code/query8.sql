-- 8. Latency SLA compliance per threshold by provider
-- OpenAI (gpt-5-nano): messageids 315-402
-- Ollama (gpt-oss-20b): messageids 412-501
WITH
    chat AS (
        SELECT
            CASE
                WHEN messageid BETWEEN 315 AND 402 THEN 'OpenAI (gpt-5-nano)'
                WHEN messageid BETWEEN 412 AND 501 THEN 'Ollama (gpt-oss-20b)'
            END AS provider,
            total
        FROM
            public.AIChatPerformance
        WHERE
            messageid BETWEEN 315 AND 402
            OR messageid BETWEEN 412 AND 501
    ),
    thresholds AS (
        SELECT
            *
        FROM
            (
                VALUES
                    (10000),
                    (15000),
                    (20000),
                    (30000),
                    (40000),
                    (50000)
            ) AS t (threshold_ms)
    )
SELECT
    provider,
    threshold_ms,
    COUNT(*) FILTER (
        WHERE
            total < threshold_ms
    ) AS queries_under,
    ROUND(
        COUNT(*) FILTER (
            WHERE
                total < threshold_ms
        )::NUMERIC / NULLIF(COUNT(*) OVER (PARTITION BY provider), 0) * 100,
        2
    ) AS compliance_pct
FROM
    chat
    CROSS JOIN thresholds
GROUP BY
    provider,
    threshold_ms
ORDER BY
    provider,
    threshold_ms;