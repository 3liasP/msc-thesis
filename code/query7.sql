-- 7. Token usage and cost summary (OpenAI only)
-- Using gpt-5-nano pricing as of 2025-11-21:
-- \$0.05 per 1M input tokens
-- \$0.40 per 1M output tokens
-- OpenAI (gpt-5-nano): messageids 315-402
SELECT
    COUNT(*) AS queries,
    SUM((message -> 'usage_metadata' ->> 'input_tokens')
        ::NUMERIC) AS in_tokens,
    SUM((message -> 'usage_metadata' ->> 'output_tokens')
        ::NUMERIC) AS out_tokens,
    SUM((message -> 'usage_metadata' ->> 'total_tokens')
        ::NUMERIC) AS all_tokens,
    ROUND(SUM((message -> 'usage_metadata' ->> 'input_tokens')
        ::NUMERIC) / 1000000.0 * 0.05, 4) AS in_cost,
    ROUND(SUM((message -> 'usage_metadata' ->> 'output_tokens')
        ::NUMERIC) / 1000000.0 * 0.40, 4) AS out_cost,
    ROUND(SUM((message -> 'usage_metadata' ->> 'input_tokens')
        ::NUMERIC) / 1000000.0 * 0.05 +
          SUM((message -> 'usage_metadata' ->> 'output_tokens')
            ::NUMERIC) / 1000000.0 * 0.40, 4) AS tot_cost
FROM public.AIChatHistory
WHERE message ->> 'type' = 'ai'
    AND message -> 'usage_metadata' IS NOT NULL
    AND messageid BETWEEN 315 AND 402;
