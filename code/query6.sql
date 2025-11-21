-- 6. Document inventory per source type
SELECT
    sourcetype,
    COUNT(*) AS document_count
FROM
    public.AIDocSources
GROUP BY
    sourcetype
ORDER BY
    document_count DESC;