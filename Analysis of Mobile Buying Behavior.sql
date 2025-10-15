--Q1
SELECT
      FORMAT_DATE('%Y %m', PARSE_DATE('%Y %m %d', DatePurchase)) AS month,
      COUNT(DISTINCT TransactionID) AS so_don_hang
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 1;



--Q2
SELECT 
      FORMAT_DATE('%Y %m', PARSE_DATE('%Y %m %d', DatePurchase)) AS month,
      COUNT(DISTINCT CustomerCode) AS so_khach_hang
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 1;



--Q3
WITH raw_data AS ( --lấy số lượng bán theo từng giới tính, từng hãng
  SELECT
        SexType,
        ProductBrand,
        COUNT(TransactionID) AS so_luong
  FROM `ancient-voltage-472014-q9.1.Phone_Sales`
  GROUP BY 1, 2
  ORDER BY 1, 2, 3
),

ranking_so_luong AS (
  SELECT
        SexType,
        ProductBrand,
        so_luong,
        DENSE_RANK() OVER(PARTITION BY SexType ORDER BY so_luong DESC) AS rk
  FROM raw_data
  ORDER BY 1, 4
)

SELECT
      SexType,
      ProductBrand,
      so_luong,
      rk
FROM ranking_so_luong
WHERE rk <= 3
ORDER BY 1, 4;




--Q4
SELECT 
      YearOldRange,
      COUNT(TransactionID) AS so_luong,
      SUM(SalesValue) AS doanh_thu
FROM `ancient-voltage-472014-q9.1.Phone_Sales` 
GROUP BY YearOldRange
ORDER BY doanh_thu DESC,so_luong DESC



--Q5
WITH raw_data AS (
  SELECT
        FORMAT_DATE('%Y %m', PARSE_DATE('%Y %m %d', DatePurchase)) AS month,
        ProductName,
        SUM(SalesValue) AS doanh_thu
  FROM `ancient-voltage-472014-q9.1.Phone_Sales`
  GROUP BY 1, 2
  ORDER BY 1, 3 DESC
),

--ranking nhóm lại theo tháng
ranking_doanhthu AS (
  SELECT
        month,
        ProductName,
        doanh_thu,
        DENSE_RANK() OVER(PARTITION BY month ORDER BY doanh_thu DESC) AS rk
  FROM raw_data
)

SELECT *
FROM ranking_doanhthu
WHERE rk <= 3
ORDER BY month, rk;



--Q6
WITH raw_data AS (
  SELECT
        YearOldRange,
        ProductBrand,
        COUNT(TransactionID) AS so_luong
  FROM `ancient-voltage-472014-q9.1.Phone_Sales`
  WHERE YearOldRange = '26-30'
  GROUP BY 1, 2
  ORDER BY 3 DESC
)

SELECT
      YearOldRange,
      ProductBrand,
      so_luong,
  DENSE_RANK() OVER(ORDER BY so_luong DESC) AS rk
FROM raw_data
ORDER BY rk;


--Q7
WITH raw_data AS (
  SELECT
        sales.TransactionID,
        sales.YearOldRange,
        sales.ProductName,
        access.Accessories_name,
        access.Accessories_subname,
        access.SalesValue
  FROM `ancient-voltage-472014-q9.1.Phone_Sales`AS sales
  LEFT JOIN `ancient-voltage-472014-q9.1.Accessories_Sales` AS access
  USING (TransactionID)
  ORDER BY 1
)

-- Sau đó đếm số Accessories_name / total để ra được tỉ lệ khách mua phụ kiện
SELECT
      YearOldRange,
      COUNT(Accessories_name) AS accessories_sale,
      COUNT(*) AS total,
      ROUND(COUNT(Accessories_name) / COUNT(*) ,4) AS ti_le_mua_phu_kien
FROM raw_data
GROUP BY 1
ORDER BY 1;



--Q8
WITH raw_data AS (
  SELECT
        sales.TransactionID,
        sales.YearOldRange,
        sales.ProductName,
        sales.ProductBrand,
        access.Accessories_name,
        access.Accessories_subname,
        access.SalesValue
  FROM `ancient-voltage-472014-q9.1.Phone_Sales` AS sales
  LEFT JOIN `ancient-voltage-472014-q9.1.Accessories_Sales` AS access
  USING (TransactionID)
  ORDER BY 1
)

SELECT
      ProductBrand,
      COUNT(Accessories_name) AS accessories_sale,
      COUNT(*) AS total,
      COUNT(Accessories_name) / COUNT(*) AS ti_le_mua_phu_kien
FROM raw_data
GROUP BY 1
ORDER BY 1;



--Q9
SELECT
      YearOldRange,
      COUNT(Bank) AS tra_gop,
      COUNT(*) AS total_orders,
      ROUND(COUNT(Bank) / COUNT(*),4)AS ti_le_tra_gop
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 4 DESC;


--Q10
SELECT
      ProductBrand,
      COUNT(Bank) AS tra_gop,
      COUNT(*) AS total_orders,
      ROUND(COUNT(Bank) / COUNT(*),4) AS ti_le_tra_gop
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 4 DESC;