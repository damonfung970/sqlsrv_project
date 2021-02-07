use tempdb
go

create table ##dept (
 id int,
 dept_name varchar(200)
)

insert into ##dept values (1, '办公室')
insert into ##dept values (2, '人事科')

create table ##empl (
 id int,
 detp_id int,
 empl_name varchar(200)
)

insert into ##empl values (1, 3,  '杨红')
insert into ##empl values (1, 1,  '宋琳')
insert into ##empl values (1, 2,  '杨茵')
insert into ##empl values (1, 4,  '慧雯')
insert into ##empl values (2, 1,  '崔艳玲')
insert into ##empl values (2, 2,  '钟林峰')


begin tran
  select * from #empl (holdlock)
  sleep 
  
  rollback