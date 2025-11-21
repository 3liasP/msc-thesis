-- 4. Extraction vs. embedding bottleneck per source type
WITH
    doc_perf AS (
        SELECT
            sourcetype,
            extraction,
            embedding,
            total
        FROM
            public.AIDocPerformance
    )
SELECT
    sourcetype,
    AVG(extraction / NULLIF(total, 0) * 100) AS extraction_pct,
    AVG(embedding / NULLIF(total, 0) * 100) AS embedding_pct,
    CASE
        WHEN AVG(extraction) > AVG(embedding) THEN 'Extraction'
        ELSE 'Embedding'
    END AS bottleneck
FROM
    doc_perf
GROUP BY
    sourcetype
ORDER BY
    sourcetype;