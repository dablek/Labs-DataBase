SELECT ProductID, SUM(OrderQty) AS SumOrders
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) >= 2000
ORDER BY SumOrders
