/* 
question: Whata are the most in-demand skills for data analysts?
-join job postings to inner join table similar to query 2
-identify the top 5 in-demand skills for the data-analyst 
-focus on all job postings
-retrieve the top 5 skills with the highest demand in the job market  */
select 
    skills,
    count(s.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim s
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
WHERE job_title_short='Data Analyst' and 
job_country like 'United%'
GROUP BY skills
order by demand_count desc
limit 5