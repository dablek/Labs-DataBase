--Упражнение 1
CREATE PROCEDURE Sales.GetDiscounts
AS
BEGIN
    SELECT Description,
           DiscountPct,
           Type,
           Category,
           StartDate,
           EndDate,
           MinQty,
           MaxQty
    FROM Sales.SpecialOffer
    ORDER BY StartDate, EndDate
END

EXEC Sales.GetDiscounts

--Упражнение 2
CREATE PROCEDURE Sales.GetDiscountsForCategory
    @Category NVARCHAR(50)
AS
BEGIN
    SELECT Description,
           DiscountPct,
           Type,
           Category,
           StartDate,
           EndDate,
           MinQty,
           MaxQty
    FROM Sales.SpecialOffer
    WHERE Category = @Category
    ORDER BY StartDate, EndDate
END

EXEC Sales.GetDiscountsForCategory 'Reseller'

--Упражнение 3
CREATE PROCEDURE Sales.GetDiscountsForCategoryAndDate
    @Category NVARCHAR(50),
    @DateToCheck DATETIME = NULL
AS
BEGIN
    IF @DateToCheck IS NULL
    SET @DateToCheck = GETDATE()



    SELECT Description,
           DiscountPct,
           Type,
           Category,
           StartDate,
           EndDate,
           MinQty,
           MaxQty
    FROM Sales.SpecialOffer
    WHERE Category = @Category AND @DateToCheck BETWEEN StartDate AND EndDate
    ORDER BY StartDate, EndDate
END

DECLARE @DateToCheck DATETIME
SET @DateToCheck = DATEADD(month, 1, GETDATE())
EXEC Sales.GetDiscountsForCategoryAndDate 'Reseller', @DateToCheck

--Упражнение 4
CREATE PROCEDURE Sales.AddDiscount
    @Description NVARCHAR(255),
    @DiscountPct SMALLMONEY,
    @Type NVARCHAR(50),
    @Category NVARCHAR(50),
    @StartDate DATETIME,
    @EndDate DATETIME,
    @MinQty INT,
    @MaxQty INT,
    @NewProductID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Sales.SpecialOffer (Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty)
        SELECT @Description,
           @DiscountPct,
           @Type,
           @Category,
           @StartDate,
           @EndDate,
           @MinQty,
           @MaxQty
        SET @NewProductID = SCOPE_IDENTITY()
        RETURN 0
    END TRY
    BEGIN CATCH
        INSERT INTO dbo.ErrorLog (ErrorTime, UserName, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
        SELECT GETDATE(),
               USER_NAME(),
               ERROR_NUMBER(),
               ERROR_SEVERITY(),
               ERROR_STATE(),
               ERROR_PROCEDURE(),
               ERROR_LINE(),
               ERROR_MESSAGE()
        RETURN 1
    END CATCH
END

DECLARE @StartDate DATETIME,
        @EndDate DATETIME
SET @StartDate = GETDATE()
SET @EndDate = DATEADD(month, 1, GETDATE())
DECLARE @NewId INT
EXEC Sales.AddDiscount
    'Half price off everything',
    0.5,
    'Seasonal Discount',
    'Customer',
    @StartDate,
    @EndDate,
    0,
    20,
    @NewId OUTPUT
SELECT @NewId

DECLARE @StartDate DATETIME,
        @EndDate DATETIME
SET @StartDate = GETDATE()
SET @EndDate = DATEADD(month, 1, GETDATE())
DECLARE @NewId INT, @ReturnValue INT
EXEC @ReturnValue = Sales.AddDiscount
    'Half price off everything',
    -0.5,
    'Seasonal Discount',
    'Customer',
    @StartDate,
    @EndDate,
    0,
    20,
    @NewId OUTPUT
IF(@ReturnValue = 0)
SELECT @NewId
ELSE
SELECT TOP 1 * FROM dbo.ErrorLog ORDER BY ErrorTime DESC

