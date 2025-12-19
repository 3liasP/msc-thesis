-- 2. Stage contribution to total chat latency by provider (percent share)
-- OpenAI (gpt-5-nano): messageids 315-402
-- Ollama (gpt-oss-20b): messageids 412-501
WITH
    chat AS (
        SELECT
            CASE
                WHEN messageid BETWEEN 315 AND 402 THEN 'OpenAI (gpt-5-nano)'
                WHEN messageid BETWEEN 412 AND 501 THEN 'Ollama (gpt-oss-20b)'
            END AS provider,
            total,
            tools,
            embedding,
            llm,
            (metrics -> 'custom' -> 'vector_search' ->> 'total')
                ::NUMERIC AS vector_search,
            (metrics -> 'custom' -> 'bm25_reranking' ->> 'total')
                ::NUMERIC AS bm25_rerank,
            (metrics -> 'custom' -> 'hybrid_reranking' ->> 'total')
                ::NUMERIC AS hybrid_rerank,
            (metrics -> 'custom' -> 'chunk_grouping' ->> 'total')
                ::NUMERIC AS chunk_group
        FROM
            public.AIChatPerformance
        WHERE
            messageid BETWEEN 315 AND 402
            OR messageid BETWEEN 412 AND 501
    )
SELECT
    provider,
    AVG(tools / NULLIF(total, 0) * 100) AS tools_pct,
    AVG(embedding / NULLIF(total, 0) * 100) AS embedding_pct,
    AVG(llm / NULLIF(total, 0) * 100) AS llm_pct,
    AVG(vector_search / NULLIF(total, 0) * 100) AS vector_search_pct,
    AVG((bm25_rerank + hybrid_rerank) / NULLIF(total, 0) * 100) AS reranking_pct,
    AVG(chunk_group / NULLIF(total, 0) * 100) AS chunk_grouping_pct,
    AVG((total - tools - embedding - llm) / NULLIF(total, 0) * 100) AS overhead_pct
FROM
    chat
GROUP BY
    provider
ORDER BY
    provider;