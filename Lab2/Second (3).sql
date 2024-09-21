SELECT ProductID, SpecialOfferID, AVG(UnitPrice) AS AveragePrice, SUM(LineTotal) AS TotalSum
FROM Sales.SalesOrderDetail
GROUP BY ProductID, SpecialOfferID
ORDER BY ProductID, SpecialOfferID