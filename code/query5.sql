-- 5. Vector database chunk size distribution
WITH
    chunk_lengths AS (
        SELECT
            sourceid,
            LENGTH(content) AS chunk_len
        FROM
            public.AIDocChunks
    )
SELECT
    COUNT(*) AS total_chunks,
    COUNT(DISTINCT sourceid) AS total_documents,
    AVG(chunk_len) AS mean_chunk_length,
    MIN(chunk_len) AS min_chunk_length,
    MAX(chunk_len) AS max_chunk_length,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY
            chunk_len
    ) AS median_chunk_length
FROM
    chunk_lengths;