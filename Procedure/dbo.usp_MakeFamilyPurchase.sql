create or alter procedure dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as 
begin
	set nocount on
	-- Проверка что такая семья есть
	if not exists (select 1 from dbo.Family where SurName = @FamilySurName)
	begin
		raiserror('Такой семьи нет.', 16, 1)
		return
	end
	
	-- Вычисление суммы покупок
	declare
		@TotalPurchase decimal(18, 2)
		
	select @TotalPurchase = sum(Value)
	from dbo.Basket
	where ID_Family in (select ID from dbo.Family where SurName = @FamilySurName)
	
	-- Обновление таблицы Family
	update dbo.Family
	set BudgetValue = BudgetValue - isnull(@TotalPurchase, 0)
	where SurName = @FamilySurName
end;
	