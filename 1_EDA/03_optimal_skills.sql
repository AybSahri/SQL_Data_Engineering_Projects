/*
 Question: What are the most optimal skills for data engineers—balancing both demand and salary?
 - Create a ranking column that combines demand count and median salary to identify the most valuable skills.
 - Focus only on remote Data Engineer positions with specified annual salaries.
 - Why?
 - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
 - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
 */
SELECT sd.skills,
    round(Median(jpf.salary_year_avg), 0) as median_salary,
    --count(jpf.*) as demand_count,
    ROUND(LN(count(jpf.*)), 1) as ln_demand_count,
    ROUND(
        (Median(jpf.salary_year_avg) * LN(count(jpf.*))) / 1_000_000,
        2
    ) as optimal_score
FROM skills_dim as sd
    INNER JOIN skills_job_dim as sjd ON sd.skill_id = sjd.skill_id
    INNER JOIN job_postings_fact as jpf ON sjd.job_id = jpf.job_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg is not null
GROUP BY sd.skills
HAVING count(jpf.*) > 100
ORDER BY optimal_score DESC
LIMIT 25;
/*
 ┌────────────┬───────────────┬─────────────────┬───────────────┐
 │   skills   │ median_salary │ ln_demand_count │ optimal_score │
 │  varchar   │    double     │     double      │    double     │
 ├────────────┼───────────────┼─────────────────┼───────────────┤
 │ terraform  │      184000.0 │             5.3 │          0.97 │
 │ python     │      135000.0 │             7.0 │          0.95 │
 │ aws        │      137320.0 │             6.7 │          0.91 │
 │ sql        │      130000.0 │             7.0 │          0.91 │
 │ airflow    │      150000.0 │             6.0 │          0.89 │
 │ spark      │      140000.0 │             6.2 │          0.87 │
 │ snowflake  │      135500.0 │             6.1 │          0.82 │
 │ kafka      │      145000.0 │             5.7 │          0.82 │
 │ azure      │      128000.0 │             6.2 │          0.79 │
 │ java       │      135000.0 │             5.7 │          0.77 │
 │ scala      │      137290.0 │             5.5 │          0.76 │
 │ git        │      140000.0 │             5.3 │          0.75 │
 │ kubernetes │      150500.0 │             5.0 │          0.75 │
 │ databricks │      132750.0 │             5.6 │          0.74 │
 │ redshift   │      130000.0 │             5.6 │          0.73 │
 │ gcp        │      136000.0 │             5.3 │          0.72 │
 │ nosql      │      134415.0 │             5.3 │          0.71 │
 │ hadoop     │      135000.0 │             5.3 │          0.71 │
 │ pyspark    │      140000.0 │             5.0 │           0.7 │
 │ mongodb    │      135750.0 │             4.9 │          0.67 │
 │ docker     │      135000.0 │             5.0 │          0.67 │
 │ r          │      134775.0 │             4.9 │          0.66 │
 │ go         │      140000.0 │             4.7 │          0.66 │
 │ github     │      135000.0 │             4.8 │          0.65 │
 │ bigquery   │      135000.0 │             4.8 │          0.65 │
 └────────────┴───────────────┴─────────────────┴───────────────┘
 25 rows                                            4 columns
 
 */