/*
 Question: What are the most in-demand skills for data engineers?
 - Join job postings to inner join table similar to query 2
 - Identify the top 10 in-demand skills for data engineers
 - Focus on remote job postings
 - Why? Retrieves the top 10 skills with the highest demand in the remote job market,
 providing insights into the most valuable skills for data engineers seeking remote work
 */
SELECT sd.skills,
    count(sjd.skill_id) as demand_count
FROM skills_dim as sd
    INNER JOIN skills_job_dim as sjd ON sd.skill_id = sjd.skill_id
    INNER JOIN job_postings_fact as jpf ON sjd.job_id = jpf.job_id
WHERE jpf.job_title_short LIKE 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY sd.skills
ORDER BY count(sjd.skill_id) DESC
LIMIT 10;
/*
 Here's the breakdown of the most demanded skills for data engineers:
 SQL and Python are by far the most in-demand skills, with around 29,000 job postings each - nearly double the next closest skill.
 Cloud platforms round out the top skills, with AWS leading at ~18,000 postings, followed by Azure at ~14,000.
 Apache Spark completes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing skills.
 
 Key takeaways:
 - SQL and Python remain the foundational skills for data engineers
 - Cloud platforms (AWS, Azure) are critical for modern data engineering
 - Big data tools like Spark continue to be highly valued
 - Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
 - Java and GCP round out the top 10 most requested skills
 
 ┌────────────┬──────────────┐
 │   skills   │ demand_count │
 │  varchar   │    int64     │
 ├────────────┼──────────────┤
 │ sql        │        29221 │
 │ python     │        28776 │
 │ aws        │        17823 │
 │ azure      │        14143 │
 │ spark      │        12799 │
 │ airflow    │         9996 │
 │ snowflake  │         8639 │
 │ databricks │         8183 │
 │ java       │         7267 │
 │ gcp        │         6446 │
 ├────────────┴──────────────┤
 │ 10 rows         2 columns │
 └───────────────────────────┘
 */