/* what are the top skills based on salary
-look at the average salary associated with each skill for data analyst
-focuses on roles with specified salaries,regardless of location
-how different skills impact salary levels for Data Analyst
*/
select 
    skills,
    ROUND(AVG(salary_year_avg),0 ) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim s
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
WHERE job_title_short='Data Analyst'
AND salary_year_avg is not null 
-- job_country like 'United%'
GROUP BY skills
order by avg_salary desc
limit 25