-- 3. Embedding throughput per minute (chunks + documents)
WITH
    doc_perf AS (
        SELECT
            DATE_TRUNC('minute', created) AS time_bucket,
            sourceid,
            embedding
        FROM
            public.AIDocPerformance
    ),
    chunk_counts AS (
        SELECT
            sourceid,
            COUNT(*) AS chunk_count
        FROM
            public.AIDocChunks
        GROUP BY
            sourceid
    )
SELECT
    dp.time_bucket,
    SUM(cc.chunk_count) AS chunks_per_min,
    COUNT(DISTINCT dp.sourceid) AS docs_per_min,
    AVG(dp.embedding) AS mean_embedding_ms
FROM
    doc_perf dp
    JOIN chunk_counts cc ON dp.sourceid = cc.sourceid
GROUP BY
    dp.time_bucket
ORDER BY
    dp.time_bucket;