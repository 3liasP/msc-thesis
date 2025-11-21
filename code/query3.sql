-- 3. Embedding throughput per minute (chunks + documents)
WITH
    doc_perf AS (
        SELECT
            DATE_TRUNC('minute', created) AS time_bucket,
            sourceid,
            embedding
        FROM
            public.AIDocPerformance
    )
SELECT
    time_bucket,
    COUNT(*) AS chunks_per_min,
    COUNT(DISTINCT sourceid) AS docs_per_min,
    AVG(embedding) AS mean_embedding_ms
FROM
    doc_perf
GROUP BY
    time_bucket
ORDER BY
    time_bucket;