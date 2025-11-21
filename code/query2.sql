-- 2. Stage contribution to total chat latency (percent share)
WITH
    chat AS (
        SELECT
            total,
            embedding,
            search,
            response
        FROM
            public.AIChatPerformance
    )
SELECT
    AVG(embedding / NULLIF(total, 0) * 100) AS embedding_pct,
    AVG(search / NULLIF(total, 0) * 100) AS search_pct,
    AVG(response / NULLIF(total, 0) * 100) AS response_pct
FROM
    chat;