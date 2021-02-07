select * from sys.databases

select request_id, session_id, status, command, reads, writes, logical_reads, wait_type, wait_resource, wait_time, sql_handle, plan_handle, start_time, database_id, user_id, connection_id, transaction_id, context_info, percent_complete,  last_wait_type,  * from sys.dm_exec_requests


WITH CTE AS 
	(
	select request_id, session_id
	from sys.dm_exec_requests 
--    where request_id>0 
	),
	CTE2 AS 
	(
	select * from sys.dm_exec_connections c 
	),
	CTE3 AS
	(
	select * from sys.dm_exec_sessions s
	)
select * from CTE2 join CTE on CTE2.session_id =  CTE.session_id left join CTE3 on  CTE2.session_id =  CTE3.session_id 


select * from sys.dm_exec_connections c join sys.dm_exec_requests r on c.session_id = r.session_id left join sys.dm_exec_sessions s on c.session_id=s.session_id


where CTE2.session_id in (select CTE.session_id from CTE)

select * from sys.dm_exec_connections c where c.session_id in (select session_id from  CTE)

select c.*, '|' as 'c|r', r.*, 'r|s', s.* from sys.dm_exec_connections c join sys.dm_exec_requests r on c.session_id = r.session_id left join sys.dm_exec_sessions s on c.session_id=s.session_id

select * from sys.dm_exec_connections c where c.session_id in (select s.session_id from sys.dm_exec_requests s)

select count(*) from sys.dm_exec_connections 
select count(*) from sys.dm_exec_sessions

with cr as (select CountryRegionCode from person.CountryRegion where Name like'C%')

Select * from person.CountryRegion

select * from person.StateProvince where CountryRegionCode in (select * from cr)

--查询自有连接有关信息

SELECT   
    c.session_id, c.net_transport, c.encrypt_option,   
    c.auth_scheme, s.host_name, s.program_name,   
    s.client_interface_name, s.login_name, s.nt_domain,   
    s.nt_user_name, s.original_login_name, c.connect_time,   
    s.login_time   
FROM sys.dm_exec_connections AS c  
JOIN sys.dm_exec_sessions AS s  
    ON c.session_id = s.session_id  
WHERE c.session_id = @@SPID;
---

use THIS4
go

select * from czryk

---

select * from sys.dm_exec_connections 连接
select * from sys.dm_exec_sessions 会话
exec xp_readerrorlog 1,1,NULL,NULL,'desc' 错误日志
dbcc inputbuffer(1588) 输入
select isnull(max(xh),0) from BQ_CQYZK(nolock)
sp_who active 活动进程


--查询当前阻塞的全部请求
SELECT session_id ,status ,blocking_session_id  
    ,wait_type ,wait_time ,wait_resource
    ,transaction_id
FROM sys.dm_exec_requests
WHERE status = N'suspended';  
GO

--按CPU时间对请求排序
SELECT 
   req.session_id
   , req.start_time
   , cpu_time 'cpu_time_ms'
   , object_name(st.objectid,st.dbid) 'ObjectName' 
   , substring
      (REPLACE
        (REPLACE
          (SUBSTRING
            (st.text
            , (req.statement_start_offset/2) + 1
            , (
               (CASE statement_end_offset
                  WHEN -1
                  THEN DATALENGTH(st.text)  
                  ELSE req.statement_end_offset
                  END
                    - req.statement_start_offset)/2) + 1)
       , CHAR(10), ' '), CHAR(13), ' '), 1, 512)  AS statement_text  
FROM sys.dm_exec_requests AS req  
   CROSS APPLY sys.dm_exec_sql_text(req.sql_handle) as st
   ORDER BY cpu_time desc;
GO
--

--按平均 CPU 时间获取有关前五个查询的信息
SELECT TOP 5 total_worker_time/execution_count AS [Avg CPU Time],  
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1,   
        ((CASE qs.statement_end_offset  
          WHEN -1 THEN DATALENGTH(st.text)  
         ELSE qs.statement_end_offset  
         END - qs.statement_start_offset)/2) + 1) AS statement_text  
FROM sys.dm_exec_query_stats AS qs  
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st  
ORDER BY total_worker_time/execution_count DESC;

--提供批处理执行统计信息
SELECT s2.dbid,   
    s1.sql_handle,    
    (SELECT TOP 1 SUBSTRING(s2.text,statement_start_offset / 2+1 ,   
      ( (CASE WHEN statement_end_offset = -1   
         THEN (LEN(CONVERT(nvarchar(max),s2.text)) * 2)   
         ELSE statement_end_offset END)  - statement_start_offset) / 2+1))  AS sql_statement,  
    execution_count,   
    plan_generation_num,   
    last_execution_time,     
    total_worker_time,   
    last_worker_time,   
    min_worker_time,   
    max_worker_time,  
    total_physical_reads,   
    last_physical_reads,   
    min_physical_reads,    
    max_physical_reads,    
    total_logical_writes,   
    last_logical_writes,   
    min_logical_writes,   
    max_logical_writes    
FROM sys.dm_exec_query_stats AS s1   
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2    
WHERE s2.objectid is null   
ORDER BY s1.sql_handle, s1.statement_start_offset, s1.statement_end_offset;

