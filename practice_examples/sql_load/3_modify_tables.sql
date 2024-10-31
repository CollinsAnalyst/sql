with company_job_count AS
(SELECT company_id,count(*) as total_jobs
FROM job_postings_fact 
GROUP BY company_id)
SELECT name,
company_job_count.total_jobs
FROM company_dim 
LEFT JOIN company_job_count
on company_dim.company_id=company_job_count.company_id