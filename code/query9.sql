-- 9. Retrieval pipeline stage breakdown by provider (vector search, reranking, grouping)
-- OpenAI (gpt-5-nano): messageids 315-402
-- Ollama (gpt-oss-20b): messageids 412-501
WITH
    stages AS (
        SELECT
            CASE
                WHEN messageid BETWEEN 315 AND 402 THEN 'OpenAI (gpt-5-nano)'
                WHEN messageid BETWEEN 412 AND 501 THEN 'Ollama (gpt-oss-20b)'
            END AS provider,
            (metrics -> 'custom' -> 'vector_search' ->> 'total')
                ::NUMERIC AS vector_search_ms,
            (metrics -> 'custom' -> 'bm25_reranking' ->> 'total')
                ::NUMERIC AS bm25_rerank_ms,
            (metrics -> 'custom' -> 'hybrid_reranking' ->> 'total')
                ::NUMERIC AS hybrid_rerank_ms,
            (metrics -> 'custom' -> 'chunk_grouping' ->> 'total')
                ::NUMERIC AS chunk_group_ms,
            (metrics -> 'custom' -> 'retriever_total' ->> 'total')
                ::NUMERIC AS retriever_total_ms
        FROM
            public.AIChatPerformance
        WHERE
            messageid BETWEEN 315 AND 402
            OR messageid BETWEEN 412 AND 501
    )
SELECT
    provider,
    AVG(vector_search_ms) AS mean_vector_search_ms,
    AVG(bm25_rerank_ms) AS mean_bm25_rerank_ms,
    AVG(hybrid_rerank_ms) AS mean_hybrid_rerank_ms,
    AVG(chunk_group_ms) AS mean_chunk_group_ms,
    AVG(retriever_total_ms) AS mean_retriever_total_ms
FROM
    stages
GROUP BY
    provider
ORDER BY
    provider;
