-- 1. Overall latency distribution (mean, median, percentiles)
SELECT
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
    MAX(total) AS max_total_ms,
    AVG(embedding) AS mean_embedding_ms,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY
            embedding
    ) AS median_embedding_ms,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
        ORDER BY
            embedding
    ) AS p95_embedding_ms,
    AVG(search) AS mean_search_ms,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY
            search
    ) AS median_search_ms,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
        ORDER BY
            search
    ) AS p95_search_ms,
    AVG(response) AS mean_response_ms,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY
            response
    ) AS median_response_ms,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
        ORDER BY
            response
    ) AS p95_response_ms
FROM
    public.AIChatPerformance;
