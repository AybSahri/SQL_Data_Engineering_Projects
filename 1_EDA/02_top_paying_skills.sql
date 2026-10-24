/*
 Question: What are the highest-paying skills for data engineers?
 - Calculate the median salary for each skill required in data engineer positions
 - Focus on remote positions with specified salaries
 - Include skill frequency to identify both salary and demand
 - Why? Helps identify which skills command the highest compensation while also showing 
 how common those skills are, providing a more complete picture for skill development priorities
 */
DESCRIBE job_postings_fact;
DESCRIBE skills_job_dim;
DESCRIBE skills_dim;
SELECT sd.skills,
    round(Median(jpf.salary_year_avg), 0) as median_salary,
    count(jpf.*) as demand_count
FROM skills_dim as sd
    INNER JOIN skills_job_dim as sjd ON sd.skill_id = sjd.skill_id
    INNER JOIN job_postings_fact as jpf ON sjd.job_id = jpf.job_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY sd.skills
HAVING demand_count > 100
ORDER BY Median(jpf.salary_year_avg) DESC
LIMIT 25;
/*
 Here are the top 10 highest-paying skills for remote Data Engineer positions, ranked by median annual salary.
 
 ┌────────────┬────────────┬──────────────┐
 │   skills   │ avg_salary │ demand_count │
 │  varchar   │   double   │    int64     │
 ├────────────┼────────────┼──────────────┤
 │ rust       │   210000.0 │          232 │
 │ terraform  │   184000.0 │         3248 │
 │ golang     │   184000.0 │          912 │
 │ spring     │   175500.0 │          364 │
 │ neo4j      │   170000.0 │          277 │
 │ gdpr       │   169616.0 │          582 │
 │ zoom       │   168438.0 │          127 │
 │ graphql    │   167500.0 │          445 │
 │ mongo      │   162250.0 │          265 │
 │ fastapi    │   157500.0 │          204 │
 │ bitbucket  │   155000.0 │          478 │
 │ django     │   155000.0 │          265 │
 │ crystal    │   154224.0 │          129 │
 │ c          │   151500.0 │          444 │
 │ atlassian  │   151500.0 │          249 │
 │ typescript │   151000.0 │          388 │
 │ kubernetes │   150500.0 │         4202 │
 │ ruby       │   150000.0 │          736 │
 │ airflow    │   150000.0 │         9996 │
 │ node       │   150000.0 │          179 │
 │ css        │   150000.0 │          262 │
 │ redis      │   149000.0 │          605 │
 │ vmware     │   148798.0 │          136 │
 │ ansible    │   148798.0 │          475 │
 │ jupyter    │   147500.0 │          400 │
 └────────────┴────────────┴──────────────┘
 
 Key insights
 Rust has the highest median salary at $210,000, but appears in only 232 qualifying job postings.
 Terraform stands out because it combines a high median salary ($184,000) with significantly greater demand (3,248 postings).
 Golang also has a median salary of $184,000, with 912 postings.
 For your Data Engineering career, Terraform looks particularly interesting because of its combination of compensation and demand.
 One important distinction: these salaries describe jobs that mention each skill, not the salary increase caused by learning that skill. Other factors, including seniority, location, and company, influence compensation.
 */