create view dbo.SKUPrice 
as
select 
	SKU.ID
	,SKU.Code
	,SKU.Name
	,dbo.udf_GetSKUPrice(SKU.ID) as UnitPrice
from dbo.SKU;