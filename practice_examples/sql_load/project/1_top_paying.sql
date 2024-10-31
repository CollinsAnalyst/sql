--Using a CTE to ascertain total_job counts per company

with company_job_count AS
(SELECT company_id,count(*) as total_jobs
FROM job_postings_fact 
GROUP BY company_id)
SELECT name,
company_job_count.total_jobs
FROM company_dim 
LEFT JOIN company_job_count
on company_dim.company_id=company_job_count.company_id
/*quiz: what are the top paying data_analyst jobs
identify the top 10 data analyst roles that are available remotely
focus on job_posting with specified salaries(remove null values)
identify the top paying opportunities in data analysis...
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
limit 10