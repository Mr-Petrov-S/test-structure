create or alter trigger dbo.TR_Basket_insert_update
on dbo.Basket
alter insert, update 
as
begin
	set nocount on
	
	-- таблица для хранения кол-ва записей по каждому ID_SKU
	declare 
		@Counts table (ID_SKU INT, CountSKU INT, Value DECIMAL(18, 2))
	
	-- собираем количество и последнее значение Value для каждого ID_SKU
	insert into @Counts (ID_SKU, CountSKU, Value)
	select 
		ID_SKU
		,count(*)
		,max(i.Value)
	from interested as i
	group by 
		ID_SKU
		
	-- обновляем DiscountValue 
	update b
	set DiscountValue = case
							when c.CountSKU >= 2 
								then c.Value * 0.05
							else 0
						end
	from dbo.Basket as b
	inner join @counts as c on c.ID_SKU = b.ID_SKU
	where b.ID in (select ID from inserted)
end;
	
	
	
	