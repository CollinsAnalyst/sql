/*what are the most optimal skills to learn
-Identify skills in high and associated with high average salary
-concentrate on remote positions with specified salaries
Target skills that offer job_security*/
WITH skills_demand as
(
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim 
USING(job_id)
INNER JOIN
    skills_dim 
USING(skill_id)
WHERE job_title_short='Data Analyst'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home= True
GROUP BY skills_dim.skill_id
),average_salary as(
select 
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0 ) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
WHERE job_title_short='Data Analyst'
AND salary_year_avg is not null 
and job_work_from_home= True
GROUP BY skills_job_dim.skill_id
)
select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
inner join average_salary
using(skill_id)
WHERE demand_count>10
ORDER BY avg_salary DESC,demand_count DESC
LIMIT 20