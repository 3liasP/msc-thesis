-- 8. Latency SLA compliance per threshold
WITH
    chat AS (
        SELECT
            total
        FROM
            public.AIChatPerformance
    ),
    thresholds AS (
        SELECT
            *
        FROM
            (
                VALUES
                    (10000),
                    (15000),
                    (20000)
            ) AS t (threshold_ms)
    )
SELECT
    threshold_ms,
    COUNT(*) FILTER (
        WHERE
            total < threshold_ms
    ) AS queries_under_threshold,
    ROUND(
        COUNT(*) FILTER (
            WHERE
                total < threshold_ms
        )::NUMERIC / NULLIF(COUNT(*) OVER (), 0) * 100,
        2
    ) AS compliance_pct
FROM
    chat
    CROSS JOIN thresholds
GROUP BY
    threshold_ms
ORDER BY
    threshold_ms;