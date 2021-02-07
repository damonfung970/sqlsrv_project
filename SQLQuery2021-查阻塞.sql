-- SQL Server 查阻塞
WITH CTE_SID ( bsid, sid, sql_handle )
          AS ( SELECT   blocking_session_id ,
                        session_id ,
                        sql_handle
               FROM     sys.dm_exec_requests
               WHERE    blocking_session_id <> 0
               UNION ALL
               SELECT   A.blocking_session_id ,
                        A.session_id ,
                        A.sql_handle
               FROM     sys.dm_exec_requests A
                        JOIN CTE_SID B ON A.session_id = B.bsid
             )
    SELECT  C.bsid as blk,
            C.sid ,
            S.login_name ,
            S.host_name ,
            S.status ,
            S.cpu_time ,
            S.memory_usage ,
            S.last_request_start_time ,
            S.last_request_end_time ,
            S.logical_reads ,
            S.row_count ,
            Q.text
   FROM    CTE_SID C
            JOIN sys.dm_exec_sessions S ON C.sid = S.session_id
            CROSS APPLY sys.dm_exec_sql_text(C.sql_handle) Q
    ORDER BY C.sid

 --  SQL Server 查阻塞
    WITH CTE_SID ( bsid, sid, sql_handle )
          AS ( SELECT   blocking_session_id ,
                        session_id ,
                        sql_handle
               FROM     sys.dm_exec_requests
               WHERE    blocking_session_id <> 0
               UNION ALL
               SELECT   A.blocking_session_id ,
                        A.session_id ,
                        A.sql_handle
               FROM     sys.dm_exec_requests A
                        JOIN CTE_SID B ON A.session_id = B.bsid
             )
    SELECT  C.bsid as 阻塞者,
            C.sid as 进程号,
            S.login_name as 登录名,
            S.host_name as 主机名,
            S.status as 状态,
            S.cpu_time as 处理器时间,
            S.memory_usage as 内存使用量,
            S.last_request_start_time as 最后请求开始时间,
            S.last_request_end_time as 最后请求结束时间,
            S.logical_reads as 逻辑读,
            S.row_count as 行计数,
            Q.text as 执行的文本
   FROM    CTE_SID C
            JOIN sys.dm_exec_sessions S ON C.sid = S.session_id
            CROSS APPLY sys.dm_exec_sql_text(C.sql_handle) Q
    ORDER BY C.sid



SELECT  blocking_session_id ,
        session_id ,
        sql_handle
FROM    sys.dm_exec_requests 
WHERE   blocking_session_id <> 0
UNION ALL
SELECT  A.blocking_session_id ,
        A.session_id ,
        A.sql_handle
FROM    sys.dm_exec_requests A
JOIN    sys.dm_exec_requests B 
    ON  A.blocking_session_id = B.session_id


select      C.blocking_session_id as 阻塞者,
            C.session_id as 进程号,
            S.login_name as 登录名,
            S.host_name as 主机名,
            S.status as 状态,
            S.cpu_time as 处理器时间,
            S.memory_usage as 内存使用量,
            S.last_request_start_time as 最后请求开始时间,
            S.last_request_end_time as 最后请求结束时间,
            S.logical_reads as 逻辑读,
            S.row_count as 行计数,
            Q.text as 执行的文本
from        sys.dm_exec_requests A