-- read Learning.json with sql server
-- Download Learning.json, put it in a Temp folder on C disk (path has to be the same as is in line 16)

select 
	json_value(b.value, '$.source') as [source]
	,convert(date, json_value(b.value, '$.purchase_date')) as [purchase_date]
	,json_value(b.value, '$.title') as [title]
	,json_query(b.value, '$.author') as [author]
	,json_value(b.value, '$.notes') as [notes]
	,json_query(b.value, '$.tags') as [tags]
	,convert(float, json_value(b.value, '$.price')) as [price]
	,json_value(b.value, '$.link') as link
from 
	openrowset(bulk 'C:\Temp\Learning.json', single_clob) as a 
	cross apply
	openjson(BulkColumn) as b
order by convert(date, json_value(b.value, '$.purchase_date'))
