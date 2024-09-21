SELECT SalesQuota, SUM(SalesYTD) AS TotalSalesYTD, GROUPING(SalesQuota) AS Grouping
FROM Sales.SalesPerson
GROUP BY SalesQuota WITH ROLLUP