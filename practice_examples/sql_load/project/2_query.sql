/*quiz: What skills are required for the top paying
data analyst role in the industries in the data provided*/
WITH top_paying_jobs as(
    SELECT 
        job_id,
        job_title,
        job_location,
        salary_year_avg,
        name as company_name
    FROM
        job_postings_fact
    LEFT JOIN 
        company_dim
    USING (company_id)
    WHERE
        job_title_short='Data Analyst' AND
        job_location='Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    limit 10)
SELECT t.*,skills
FROM top_paying_jobs t
INNER JOIN skills_job_dim 
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
order by salary_year_avg