# Write your MySQL query statement below
select t1.teacher_id, 
count(distinct subject_id) as cnt 
from teacher t1 
group by teacher_id;