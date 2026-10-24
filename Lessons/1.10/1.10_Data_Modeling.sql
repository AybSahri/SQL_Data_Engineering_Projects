SELECT *
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs';
PRAGMA SHOW_TABLES;
DESCRIBE job_postings_fact;