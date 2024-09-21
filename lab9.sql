--Упражнение 1
CREATE FUNCTION Sales.GetMaximumDiscountForCategory
(
    @Category NVARCHAR(50)
)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @MaxDiscount DECIMAL(5, 2);

    SELECT @MaxDiscount = MAX(DiscountPct)
    FROM Sales.SpecialOffer
    WHERE Category = @Category AND GETDATE() BETWEEN StartDate AND EndDate;

    RETURN @MaxDiscount
END

SELECT Sales.GetMaximumDiscountForCategory('Reseller')

--Упражнение 2
CREATE FUNCTION Sales.GetDiscountsForDate (
    @DateToCheck DATETIME
)
RETURNS TABLE
AS
RETURN (
    SELECT Description,
           DiscountPct,
           Type,
           Category,
           StartDate,
           EndDate,
           MinQty,
           MaxQty
    FROM Sales.SpecialOffer
    WHERE @DateToCheck BETWEEN StartDate AND EndDate
    )

SELECT *
FROM Sales.GetDiscountsForDate(GETDATE())
ORDER BY DiscountPct DESC

EXEC sp_help 'Sales.SpecialOffer'


--Упражнение 3
CREATE FUNCTION Sales.GetDiscountedProducts (
    @IncludeHistory BIT
)
RETURNS @ResultTable TABLE (
    ProductID INT,
    Name NAME,
    ListPrice MONEY,
    Description NVARCHAR(255),
    DiscountPct SMALLMONEY,
    FirstCalc SMALLMONEY,
    SecondCalc SMALLMONEY
)
AS
BEGIN
    INSERT INTO @ResultTable
    SELECT p.ProductID,
           p.Name,
           p.ListPrice,
           so.Description,
           so.DiscountPct,
           p.ListPrice * so.DiscountPct AS FirstCalc,
           p.ListPrice - (p.ListPrice * so.DiscountPct) AS SecondPrice
    FROM Production.Product p
        INNER JOIN Sales.SpecialOfferProduct sop ON sop.ProductID = p.ProductID
        INNER JOIN Sales.SpecialOffer so ON so.SpecialOfferID = sop.SpecialOfferID
    WHERE @IncludeHistory = 0 OR so.DiscountPct != 0
    RETURN
END

SELECT *
FROM Sales.GetDiscountedProducts(0)
SELECT *
FROM Sales.GetDiscountedProducts(1)


--Упражнение 4
--Нужна бд AdventureWorksDW, но в мудле её нет