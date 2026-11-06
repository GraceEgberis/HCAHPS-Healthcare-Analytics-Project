SELECT TOP (1000) [Release_Period]
      ,[Measure_ID]
      ,[Bottom_box_Percentage]
      ,[Middle_box_Percentage]
      ,[Top_box_Percentage]
  FROM [HCAHPS].[dbo].[national_results]

 
 Select distinct [Release_Period]
  from national_results
  order by [Release_Period];

  select distinct [Measure_ID]
  FROM [HCAHPS].[dbo].[national_results]
  order by [Measure_ID];

  --check for duplicate in responses
  select COUNT(*) as Total_Rows,
  COUNT([Bottom_box_Percentage]) as Bottom_Values,
  count([Middle_box_Percentage]) as Middle_Values,
  COUNT([Top_box_Percentage]) as Top_Values
  from [HCAHPS].[dbo].
  [national_results]; 

  --check for duplicate
  select 
  [Release_Period],
  [Measure_ID],
  COUNT (*) as Duplicate_Count
  from [dbo].[national_results]
  group by 
  [Release_Period],
  [Measure_ID]
  Having count (*) >1;

--check for values above 100
select *
from [dbo].national_results
where [Bottom_box_Percentage]>100
or [Middle_box_Percentage]>100
OR [Top_box_Percentage]>100;

--check data types
select column_name,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'national_results';


--Question Table: check data types
select column_name,
data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'questions';

--validate question_num values
select [Question_Num]
from [dbo].questions
where TRY_CAST([Question_Num] as int) is NULL
and [Question_Num] IS NOT NULL;

--question 16 &17 use yes/no responses so null value is intentional
--check for missing values
select * 
from [dbo].questions
where [Question_Num] IS NULL
or [Measure_ID] IS NULL
OR[Question] IS NULL
OR[Bottom_box_Answer] is null
or[Middle_box_Answer] IS NULL
OR[Top_box_Answer] is null;

--CHECK FOR DUPLICATE question numbers
select[Question_Num],
count (*) as Duplicate_count
from [dbo].questions
group by [Question_Num]
Having COUNT(*)>1;

--check for duplicate question text
select [Question],
count(*) as duplicate_count
from [dbo].questions
group by [Question]
HAVING COUNT (*) >1;

--CHECK for missing Measure_id
select * 
from [dbo].questions
where[Measure_ID] IS Null;

--table 4: reports
--report Table: check data types
select column_name,
data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'reports';


--check for missing values
select * 
from [dbo].reports
where [Release_Period] IS NULL
or [Start_Date] IS NULL
OR[End_Date] IS NULL;

--check for duplicate Release period
select [Release_Period],
count(*) as duplicate_count
from [dbo].reports
group by [Release_Period]
HAVING COUNT (*) >1;

--change start and end date to date only
alter table [dbo].[reports]
alter column [Start_Date] date;

alter table [dbo].[reports]
alter column [End_Date] date;

--table 5 : responses
--responses Table: check data types
select column_name,
data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'responses';

--check for missing values
select * 
from [dbo].responses
where [Release_Period] IS NULL
or [State] IS NULL
OR[Facility_ID] IS NULL
or [Completed_Surveys] is null
or [Response_Rate] is null;

--check for duplicate responses
select [Release_Period],
[Facility_ID],
count(*) as duplicate_count
from [dbo].responses
group by [Release_Period],
[Facility_ID]
HAVING COUNT (*) >1;

--check facility id with alphabehs
select distinct [Facility_ID]
FROM [DBO].responses
WHERE [Facility_ID] LIKE'%[A-Za-z]%';

--table 6: state results
-- check data types
select column_name,
data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'state_results';

--check for duplicates
select
[Release_Period],
[Measure_ID],
[Bottom_box_Percentage],
[Middle_box_Percentage],
[Top_box_Percentage],
count (*) as duplicate_count
from state_results
group by
[Release_Period],
[State],
[Measure_ID],
[Bottom_box_Percentage],
[Middle_box_Percentage],
[Top_box_Percentage]
having count (*) > 1;

--check for null values
  select *
  from state_results
  where State is NULL;

  --Table 7: states
  -- check data types
select column_name,
data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'states';

--check for duplicate responses
select [State],
[State_Name],
[Region],
count(*) as duplicate_count
from [dbo].states
group by [State],
[State_Name],
[Region]
HAVING COUNT (*) >1;



