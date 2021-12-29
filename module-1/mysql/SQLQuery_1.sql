SELECT TOP 20 pc.Name as CategoryName,p.name as ProductName
FROM SalesLT.ProductCategory pc
JOIN SalesLT.Product p
ON pc.productcategoryid = p.productcategoryid
ORDER BY CategoryName;


SELECT TOP 20 pc.FirstName + ' ' + pc.LastName AS [Customer Fullname], p.SalesOrderID as 'Sales ID', pr.Name as 'Products'
FROM SalesLT.Customer as pc
    INNER JOIN SalesLT.SalesOrderHeader as p ON pc.CustomerID = p.CustomerID
    INNER JOIN SalesLT.SalesOrderDetail as s ON p.SalesOrderID = s.SalesOrderID
    INNER JOIN SalesLT.Product as pr ON s.ProductID = pr.ProductID
ORDER BY [Customer Fullname];


SELECT TOP 20 pm.Name as [Product Model], pd.Description as [Description]
FROM SalesLT.ProductModel as pm
    INNER JOIN SalesLT.ProductModelProductDescription as pmpd ON pm.ProductModelID = pmpd.ProductModelID
    INNER JOIN SalesLt.ProductDescription as pd ON pmpd.ProductDescriptionID = pd.ProductDescriptionID
    INNER JOIN SalesLT.Product AS p ON p.ProductModelID = pm.ProductModelID
WHERE pmpd.Culture = 'ar' AND p.ProductID = 710


SELECT   p.name, COUNT(*) AS 'Total Orders'
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
GROUP BY  p.Name
HAVING COUNT(*) > 5 
ORDER BY 'Total Orders' DESC


SELECT   p.name, COUNT(DISTINCT sod.SalesOrderDetailID) AS 'Total Orders'
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
GROUP BY  p.Name
HAVING COUNT(*) > 5 
ORDER BY 2 DESC

SELECT pc.Name as [Category], p.name AS [Product], SUM(sod.OrderQty) AS 'Total QTY'
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
    INNER JOIN SalesLT.ProductCategory as pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY  p.Name, pc.Name 
ORDER BY 1,2

SELECT pc.Name as [Category], p.name AS [Product], SUM(sod.OrderQty) AS 'Total QTY'
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
    INNER JOIN SalesLT.ProductCategory as pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY  GROUPING SETS ((pc.Name), (pc.Name, p.Name)) 
-- This return us a table first grouped by the firs set (that is onlt for category) and then by the second set
-- The result is that for example we can see 22 total Bottom Brackets sold (Product Null) that matches the sum of all Category-product sets possible with the same category
-- That is: Bottom bracket HL bottom bracket + Bottom bracket + LL bottom bracket. 
ORDER BY 1,2

-- Filtered by number of tiquets.
SELECT pc.Name as [Category], p.name AS [Product], SUM(sod.OrderQty) AS 'Total QTY'
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
    INNER JOIN SalesLT.ProductCategory as pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY  GROUPING SETS ((pc.Name), (pc.Name, p.Name)) 
HAVING SUM(sod.OrderQty) > 8
ORDER BY 1,2

SELECT p.ProductID, pc.Name AS 'Category', p.Name AS 'Product', p.[Size]
    , ROW_NUMBER() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Row Number Per Category & Size'
    , RANK() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Rank Per Category & Size'
    , DENSE_RANK() OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Size) AS 'Dense Rank Per Category & Size'
    , NTILE(2) OVER (PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'NTile Per Category & Name'
    , SUM(p.StandardCost) OVER() AS 'Standard Cost Grand Total'
    , SUM(p.StandardCost) OVER(PARTITION BY p.ProductCategoryID) AS 'Standard Cost Per Category'
    , LAG(p.Name, 1, '-- NOT FOUND --') OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Previous Product Per Category'
    , LEAD(p.Name, 1, '-- NOT FOUND --') OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Next Product Per Category'
    , FIRST_VALUE(p.Name) OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'First Product Per Category'
    , LAST_VALUE(p.Name) OVER(PARTITION BY p.ProductCategoryID ORDER BY p.Name) AS 'Last Product Per Category'
FROM SalesLT.Product AS p
    INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
ORDER BY pc.Name, p.Name