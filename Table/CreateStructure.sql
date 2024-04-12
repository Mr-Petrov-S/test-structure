-- Проверяем наличие объекта и создаем таблицу
if object_id('dbo.SKU', 'U') is null
begin
	create table dbo.SKU (
		ID int not null identity,
		Code as 's' + cast(ID as varchar(255)) unique,
		Name varchar(255) not null
	)
end;

-- Проверяем наличие объекта и создаем таблицу
if object_id('dbo.Family', 'U') is null
begin
	create table dbo.Family (
		ID int not null identity,
		SurName varchar(255) not null,
		BudgetValue DECIMAL(18, 2) not null
	)
end;

-- Проверяем наличие объекта и создаем таблицу
if object_id('dbo.Basket', 'U') is null
begin
	create table dbo.Basket (
		ID int not null identity,
		ID_SKU int references dbo.SKU(ID),
		ID_Family int references dbo.Family(ID),
		Quantity int check(Quantity > 0),
		Value int check(Value > 0),
		PurchaseDate datetime default (getdate()),
		DiscountValue DECIMAL(18, 2)
	)
end;


	
	
	
	
	
	
	


