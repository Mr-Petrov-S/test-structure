create or alter function dbo.udf_GetSKUPrice(
	@ID_SKU int
)
returns decimal(18, 2)
as
begin
	declare 
		@Price decimal(18, 2)
	
	select @Price = sum(Value) / nullif(sum(Quantity), 0)
	from dbo.Basket
	where ID_SKU = @ID_SKU
	group by ID_SKU
	
	return isnull(@Price, 0)
end;