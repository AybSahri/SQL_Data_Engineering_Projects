EXPLAIN
SELECT cd.name as name,
    COUNT(jpf.job_id) AS total_jobs
FROM company_dim as cd
    LEFT JOIN job_postings_fact as jpf ON cd.company_id = jpf.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.*) > 3000
ORDER BY (total_jobs) DESC;
EXPLAIN ANALYZE
SELECT cd.name as name,
    COUNT(jpf.job_id) AS total_jobs
FROM company_dim as cd
    LEFT JOIN job_postings_fact as jpf ON cd.company_id = jpf.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.*) > 3000
ORDER BY (total_jobs) DESC;
select (*)
from company_dim
limit 3;
select (job_country)
from job_postings_fact
limit 3;