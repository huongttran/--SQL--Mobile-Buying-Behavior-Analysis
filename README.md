# [SQL] Mobile Buying Behavior Analysis
## 📕 Mục lục
- 📊 [Giới thiệu](#-giới-thiệu)
- 📂 [Bộ dữ liệu](#-bộ-dữ-liệu)
- 🎯 [Câu hỏi tình huống](#-câu-hỏi-tình-huống)
- 💯 [Giải pháp](#-giải-pháp)
- 💡 [Nhận xét](#-nhận-xét)

## 📊 Giới thiệu
> Khi thị trường điện thoại bùng nổ, nhóm phân tích nhận ra rằng dữ liệu giao dịch ẩn chứa vô số câu chuyện thú vị: ai đang mua, họ mua gì, ở đâu và vì sao lại chọn hình thức trả góp hay mua thêm phụ kiện.
> 
> Vì vậy, Hương đã khởi động một project mới – “Phone Data Insight” – nhằm khai phá dữ liệu bán hàng và giúp doanh nghiệp hiểu rõ khách hàng hơn bao giờ hết.
>
> Mục tiêu của dự án là theo dõi xu hướng mua sắm, đo lường doanh thu và phát hiện những hành vi tiềm năng để từ đó giúp doanh nghiệp dự báo nhu cầu, tối ưu chiến lược bán hàng và phát triển bền vững trong tương lai.
## 📂 Bộ dữ liệu
Hương chia sẻ với bạn 2 tập dữ liệu chính sử dụng trong nghiên cứu này:
### `Phone Sale`
<details>
<summary>Hiển thị </summary>

Bảng  `Phone Sale` ghi lại toàn bộ các giao dịch mua điện thoại của khách hàng, bao gồm cả những đơn hàng chỉ mua điện thoại và những đơn có mua kèm phụ kiện hoặc bảo hiểm. Từ đó đưa để phân tích hành vi tiêu dùng, so sánh xu hướng mua sắm giữa các nhóm khách hàng. Dưới đây là mẫu hiển thị 10 giao dịch đầu tiên của bảng dữ liệu.
  
| TransactionID | CustomerCode     | ProductName                     | ProductBrand  | DatePurchase | GeographicalAre     | Payment_meth | Bank | Color  | Carrier     | SexType | YearOldRange | Unitprice | SalesValue | Unit |
|----------------|------------------|----------------------------------|---------------|---------------|----------------------|---------------|------|--------|-------------|---------|---------------|------------|-------------|------|
| P100000        | 0107AH000000043  | LUMIA 610 WHITE                 | NOKIA         | 2015 01 03    | Ho Chi Minh City     | Tiền mặt      | -    | WHITE  | Mobifone    | NAM     | 21-25         | 2999000    | 4579000     | 1    |
| P100001        | 0107CH000001261  | I8160 (Galaxy Ace2) Onyx Black  | SAMSUNG       | 2015 01 14    | Ho Chi Minh City     | Tiền mặt      | -    | BLACK  | Viettel     | NAM     | 26-30         | 3999000    | 6399000     | 1    |
| P100002        | 0108AH000005780  | Galaxy S Duos S7562 Pure White  | SAMSUNG       | 2015 02 07    | Ho Chi Minh City     | Tiền mặt      | -    | WHITE  | Mobifone    | NAM     | 26-30         | 3999000    | 6199000     | 1    |
| P100003        | 0108AH000006825  | S5360 (Toroto) Pure White       | SAMSUNG       | 2015 01 31    | Ho Chi Minh City     | Tiền mặt      | -    | WHITE  | Mobifone    | NU      | 21-25         | 1190000    | 2389000     | 1    |
| P100004        | 0108BH000001358  | S5360 (Toroto) Pure White       | SAMSUNG       | 2015 02 02    | Ho Chi Minh City     | Tiền mặt      | -    | WHITE  | NU          | NU      | 21-25         | 1190000    | 2389000     | 1    |
| P100005        | 0108GH000000031  | S20 Black                       | SAMSUNG       | 2015 01 06    | Ho Chi Minh City     | Tiền mặt      | -    | BLACK  | Vietnammobile| NAM     | 26-30         | 1260000    | 2689000     | 1    |
| P100006        | 0108GH000001074  | IPHONE 4S 16GB BLACK            | APPLE IPHONE  | 2015 05 31    | Ho Chi Minh City     | Tiền mặt      | -    | BLACK  | Mobifone    | NAM     | 31-35         | 13890000   | 14390000    | 1    |
| P100007        | 0108HH000000089  | S5830i WHITE                    | SAMSUNG       | 2015 05 16    | Ho Chi Minh City     | Tiền mặt      | -    | WHITE  | Mobifone    | NU      | 26-30         | 3090000    | 3389000     | 1    |
| P100008        | 0108HH000007264  | P5100 (Galaxy Tab 2) Titanium Silver | SAMSUNG   | 2015 03 10    | Ho Chi Minh City     | Tiền mặt      | -    | SILVER | Vinaphone   | NU      | 26-30         | 2450000    | 3089000     | 1    |
| P100009        | 0108HH000001581  | S6102 (Torino) Pure White       | SAMSUNG       | 2015 02 15    | Ho Chi Minh City     | Tiền mặt      | -    | WHITE  | Mobifone    | NU      | 26-30         | 2450000    | 3089000     | 1    |
| P100010        | 0108KH000000998  | S5830i WHITE                    | SAMSUNG       | 2015 03 10    | Southeast            | Tiền mặt      | -    | WHITE  | Viettel     | NAM     | 26-30         | 3090000    | 4199000     | 1    |

  </details>
  
### `Accessories Sales`
<details>
<summary>Hiện thị </summary>

Bảng dữ liệu ghi lại các giao dịch mà khách hàng mua điện thoại và mua thêm bảo hiểm hoặc phụ kiện (ốp lưng điện thoại, kính cường lực, bộ sạc,...). Mỗi hàng tương ứng với một giao dịch, dưới đây hiện thị 10 giao dịch đầu tiên của bảng `Accessories Sales`
| TransactionID | CustomerCode      | Accessories_name   | Accessories_subname   | Unitprice | Unit | SalesValue |
|----------------|------------------|--------------------|------------------------|------------|------|-------------|
| P100005        | 0108GH000000031  | Ốp lưng cao cấp    | Ốp lưng/ Cường lực    | 200000     | 1    | 200000      |
| P100006        | 0108GH000001074  | Ốp lưng chính hãng | Ốp lưng/ Cường lực    | 490000     | 1    | 490000      |
| P100098        | 0109$H000003125  | Dán màn hình cao cấp | Ốp lưng/ Cường lực    | 99000      | 1    | 99000       |
| P100101        | 0109AH000007034  | Củ sạc nhanh       | Củ sạc/ Cáp sạc       | 450000     | 1    | 450000      |
| P100122        | 0108AH000003441  | Bảo hiểm rơi vỡ    | Bảo hiểm              | 789000     | 1    | 789000      |
| P100160        | 0108IH00000922   | Ốp lưng cao cấp    | Ốp lưng/ Cường lực    | 200000     | 1    | 200000      |
| P100223        | 0108BH000004264  | Ốp lưng chính hãng | Ốp lưng/ Cường lực    | 490000     | 1    | 490000      |
| P100225        | 0108KH00001622   | Dán màn hình cao cấp | Ốp lưng/ Cường lực    | 99000      | 1    | 99000       |
| P100233        | 0109BH00000729   | Củ sạc nhanh       | Củ sạc/ Cáp sạc       | 450000     | 1    | 450000      |
| P100334        | 0107AA00000310   | Bảo hiểm rơi vỡ    | Bảo hiểm              | 789000     | 1    | 789000      |

</details>

  
## 🎯 Câu hỏi tình huống
### A. Phân tích đặc điểm khách hàng
1. Nhóm tuổi nào mua nhiều nhất, nhóm tuổi nào mang lại doanh thu nhiều nhất?
2. Nhóm khách hàng 26–30 yêu thích hãng nào?
3. Nhóm khách hàng 26–30 có sẵn sàng mua phụ kiện & bảo hiểm không?
4.  Nhóm khách hàng Nam và Nữ thích điện thoại của hãng nào nhất, lấy top 3?
5. Nhóm khách hàng của từng hãng có mua phụ kiện & bảo hiểm không?
6. Nhóm tuổi nào có hành vi mua trả góp nhiều nhất?
### B. Phân tích giao dịch khách hàng
7. Có bao nhiêu đơn hàng trong từng tháng?
8. Có bao nhiêu khách hàng mua hàng trong từng tháng?
9. Top 3 mẫu điện thoại mang lại doanh thu cao nhất của từng tháng?
10. Hãng điện thoại được mua trả góp nhiều nhất?

## 💯 Giải pháp
### Q1: Nhóm tuổi nào mua nhiều nhất, nhóm tuổi nào mang lại doanh thu nhiều nhất?
```sql
SELECT 
      YearOldRange,
      COUNT(TransactionID) AS so_luong,
      SUM(SalesValue) AS doanh_thu
FROM `ancient-voltage-472014-q9.1.Phone_Sales` 
GROUP BY YearOldRange
ORDER BY doanh_thu DESC,so_luong DESC
```
| YearOldRange | so_luong | doanh_thu     |
|---------------|-----------|---------------|
| 26-30         | 56309    | 250380794600 |
| 31-35         | 19621    | 94639260500  |
| 36-40         | 12361    | 60374518000  |
| Dưới 21       | 3175     | 14045184500  |
| Trên 40       | 1911     | 9996030000   |
| 21-25         | 1929     | 8668643500   |
### Q2: Nhóm khách hàng 26-30 yêu thích hãng nào? 
```sql
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
```
| YearOldRange | ProductBrand | so_luong | rk |
|---------------|---------------|----------|----|
| 26-30         | SAMSUNG       | 20656    | 1  |
| 26-30         | Q-SMART       | 9927     | 2  |
| 26-30         | NOKIA         | 9092     | 3  |
| 26-30         | Mobiistar     | 5547     | 4  |
| 26-30         | LENOVO        | 3075     | 5  |
| 26-30         | SONY          | 2781     | 6  |
| 26-30         | LG            | 1830     | 7  |
| 26-30         | HTC           | 1744     | 8  |
| 26-30         | Q-MOBILE      | 800      | 9  |
### Q3: Nhóm khách hàng 26-30 có sẵn sàng mua phụ kiện & bảo hiểm không?

```sql
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
```
| YearOldRange | accessories_sale | total | ti_le_mua_phu_kien |
|---------------|------------------|--------|--------------------|
| 21-25         | 725              | 1929   | 37.58              |
| 26-30         | 21491            | 56309  | 38.17              |
| 31-35         | 7107             | 19621  | 36.22              |
| 36-40         | 4428             | 12361  | 35.82              |
| Dưới 21       | 1159             | 3175   | 36.50              |
| Trên 40       | 731              | 1911   | 38.25              |

### Q4: Nhóm khách hàng Nam và Nữ thích điện thoại của hãng nào nhất, lấy top 3?
- step1: đếm số lượng bán ra của từng hãng (đếm transactionID) theo giới tính
- step2: ranking dựa trên so_luong,theo từng giới tính

```sql
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
```
| SexType | ProductBrand | so_luong | rk |
|----------|---------------|----------|----|
| NAM      | SAMSUNG       | 15895    | 1  |
| NAM      | NOKIA         | 9869     | 2  |
| NAM      | Q-SMART       | 8395     | 3  |
| NU       | SAMSUNG       | 18320    | 1  |
| NU       | NOKIA         | 7715     | 2  |
| NU       | Q-SMART       | 7136     | 3  |
### Q5: Nhóm khách hàng của từng hãng có mua phụ kiện & bảo hiểm không?
```sql
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
ORDER BY 4 DESC, 1;
```
| ProductBrand   | accessories_sale | total | ti_le_mua_phu_kien |
|----------------|------------------|--------|--------------------|
| APPLE IPHONE   | 1318             | 1318   | 1.0                |
| BLACKBERRY     | 108              | 108    | 1.0                |
| SAMSUNG        | 34215            | 34215  | 1.0                |
| ALCATEL        | 0                | 1      | 0.0                |
| F-MOBILE       | 0                | 13     | 0.0                |
| HTC            | 0                | 2987   | 0.0                |
| HUAWEI         | 0                | 24     | 0.0                |
| LENOVO         | 0                | 5410   | 0.0                |
| LG             | 0                | 3155   | 0.0                |

### Q6: Nhóm tuổi nào có hành vi mua trả góp nhiều nhất?
```sql
SELECT
      YearOldRange,
      COUNT(Bank) AS tra_gop,
      COUNT(*) AS total_orders,
      ROUND(COUNT(Bank) / COUNT(*),4)AS ti_le_tra_gop
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 4 DESC;
```
| YearOldRange | tra_gop | total_orders | ti_le_tra_gop |
|---------------|----------|---------------|----------------|
| 31-35         | 1549     | 19621         | 0.0789         |
| Dưới 21       | 218      | 3175          | 0.0687         |
| 26-30         | 3616     | 56309         | 0.0642         |
| 21-25         | 121      | 1929          | 0.0627         |
| Trên 40       | 119      | 1911          | 0.0623         |
| 36-40         | 759      | 12361         | 0.0614         |

### Q7: Có bao nhiêu đơn hàng trong từng tháng?

```sql
SELECT
  FORMAT_DATE('%Y %m', PARSE_DATE('%Y %m %d', DatePurchase)) AS month,
  COUNT(DISTINCT TransactionID) AS so_don_hang
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 1;
```

| month   | so_don_hang |
|---------|-------------|
| 2015 01 | 16963       |
| 2015 02 | 19999       |
| 2015 03 | 17944       |
| 2015 04 | 19570       |
| 2015 05 | 20830       |

### Q8: Có bao nhiêu khách hàng mua hàng trong từng tháng? 
```sql
SELECT 
      FORMAT_DATE('%Y %m', PARSE_DATE('%Y %m %d', DatePurchase)) AS month,
      COUNT(DISTINCT CustomerCode) AS so_khach_hang
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 1;
```
| month   | so_khach_hang |
|---------|-------------|
| 2015 01 | 16130       |
| 2015 02 | 19217       |
| 2015 03 | 17132       |
| 2015 04 | 18828       |
| 2015 05 | 19934       |

### Q9: Top 3 mẫu điện thoại mang lại doanh thu cao nhất của từng tháng? 

 - step 1: tính doanh thu theo từng tháng, từng sp -> aggregate -> sum
 - step 2: xếp hạng dựa trên doanh thu -> window function -> dense/rank
```sql
WITH raw_data AS (--lấy doanh thu theo từng tháng, từng sp
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
```
| month  | ProductName                    | doanh_thu   | rk |
|---------|--------------------------------|--------------|----|
| 2015 01 | Galaxy Note II N7100 Marble W  | 6325813000   | 1  |
| 2015 01 | Galaxy Note II N7100 Titan Gray| 4961552500   | 2  |
| 2015 01 | Lumia 620 Black                | 3325739500   | 3  |
| 2015 02 | Galaxy Note II N7100 Marble W  | 5035073000   | 1  |
| 2015 02 | Galaxy Note II N7100 Titan Gray| 3909001000   | 2  |
| 2015 02 | Lumia 620 Black                | 3892467000   | 3  |
| 2015 03 | Galaxy Note II N7100 Marble W  | 3578831000   | 1  |
| 2015 03 | Lumia 520 Black                | 3306246000   | 2  |
| 2015 03 | S5360(Toroto) White            | 2811021000   | 3  |

### Q10: Hãng điện thoại được mua trả góp nhiều nhất?
```sql
SELECT
      ProductBrand,
      COUNT(Bank) AS sl_tra_gop,
      COUNT(*) AS total_orders,
      ROUND(COUNT(Bank) / COUNT(*),4) AS ti_le_tra_gop
FROM `ancient-voltage-472014-q9.1.Phone_Sales`
GROUP BY 1
ORDER BY 4 DESC;
```
| ProductBrand  | sl_tra_gop | total_orders | ti_le_tra_gop |
|----------------|----------|---------------|----------------|
| APPLE IPHONE   | 169      | 1318          | 0.1282         |
| SONY           | 586      | 4642          | 0.1262         |
| HTC            | 323      | 2987          | 0.1081         |
| NOKIA          | 1851     | 17584         | 0.1053         |
| LG             | 283      | 3155          | 0.0897         |
| LENOVO         | 355      | 5410          | 0.0656         |
| SAMSUNG        | 2232     | 34215         | 0.0652         |
| BLACKBERRY     | 4        | 108           | 0.0370         |
| Q-SMART        | 464      | 15531         | 0.0299         |

## 💡 Nhận xét

### ❓Q1: Nhóm tuổi nào mua nhiều sản phẩm nhất, nhóm tuổi nào mang lại doanh thu nhiều nhất?
Nhóm **`26–30 tuổi`** ghi nhận số lượng **đơn hàng cao nhất** (56.309 đơn) và cũng mang lại **doanh thu lớn nhất** (≈250,38 tỷ).

➡️ **Nhóm `26–30 tuổi` là nhóm khách hàng tiềm năng.**

---

### ❓Q2: Nhóm khách hàng 26–30 yêu thích hãng nào?
Nhóm khách hàng **`26–30 tuổi`**, **`Samsung`** có số lượng đơn hàng **cao nhất** (20.656 đơn), xếp **thứ hai** là  **`Q-Smart`** (9.927 đơn) và **thứ ba** là **`Nokia`** (9.092 đơn).

➡️ **`Samsung` là thương hiệu được nhóm `26–30 tuổi` lựa chọn nhiều nhất.**

---

### ❓Q3: Nhóm khách hàng 26–30 có sẵn sàng mua phụ kiện & bảo hiểm không?
Nhóm **`trên 40 tuổi`** có tỷ lệ mua phụ kiện **cao nhất** (38,25%), xếp **thứ hai** là nhóm **`26–30 tuổi`** với (38,17%). Các nhóm tuổi còn lại có tỷ lệ thấp hơn dao động quanh 36–37%.

➡️ **Với độ tuổi dưới 40, nhóm `26-30 tuổi` sẵn sàng mua thêm phụ kiện cao nhất so với các nhóm còn lại.**

---
### ❓Q4: Nhóm khách hàng Nam và Nữ thích điện thoại của hãng nào nhất, lấy top 3?
Dựa trên số lượng đơn hàng, **nữ giới** có tổng lượng giao dịch **cao hơn nam giới** ở tất cả các thương hiệu, trong đó **`Samsung`** là hãng có số lượng đơn hàng **cao nhất** ở cả hai nhóm giới tính (Nam: 15.895 đơn hàng; Nữ: 18.320 đơn hàng). Trong khi **`Nokia`** và **`Q-Smart`** lần lượt xếp thứ hai và ba ở cả hai nhóm.

➡️ **`Samsung` lựa chọn ưu thích của khách hàng của cả hai giới tính.**

---
### ❓Q5: Nhóm khách hàng của từng hãng có mua phụ kiện & bảo hiểm không?
Các hãng **`Apple`, `BlackBerry` và `Samsung`** có phát sinh giao dịch **mua thêm** phụ kiện hoặc bảo hành với **tỷ lệ 100%** số đơn hàng đi kèm sản phẩm bổ sung. Các thương hiệu còn lại không ghi nhận giao dịch phụ kiện trong tập dữ liệu.

➡️ **`Apple`, `BlackBerry` và `Samsung` là doanh thu không chỉ đến từ thiết bị mà còn mở rộng sang dịch vụ và bảo hành, góp phần tăng lợi nhuận dài hạn.**

---
### ❓Q6: Nhóm tuổi nào có hành vi mua trả góp nhiều nhất?
Nhóm **`31–35 tuổi`** có tỷ lệ mua trả góp **cao nhất** (7,89%), **thứ hai** là nhóm **`dưới 21 tuổi`** (6,87%) và **thứ ba** là nhóm **`26–30 tuổi`** (6,42%). Các nhóm tuổi còn lại dao động quanh mức 6,1–6,3%.

➡️ **Khách hàng `31–35 tuổi` là nhóm sử dụng hình thức trả góp cao nhất trong tập dữ liệu.**

---
### ❓Q7: Có bao nhiêu đơn hàng trong từng tháng?
Số đơn hàng **`tháng 1/2015`** (16.963 đơn), **`tháng 2/2015`** (19.999 đơn), **`tháng 3/2015`** (17.944 đơn), **`tháng 4/2015`** (19.570 đơn), **`tháng 5/2015`** (20.830 đơn).

➡️ **Số lượng đơn hàng có xu hướng tăng trưởng nhưng không ổn định và cao nhất tại `tháng 5/2015`.**

---
### ❓Q8: Có bao nhiêu khách hàng mua hàng trong từng tháng?
Số lượng khách hàng mua **`tháng 1/2015`** (16.130), **`tháng 2/2015`** (19.217), **`tháng 3/2015`** (17.132), **`tháng 4/2015`** (18.828), **`tháng 5/2015`** (19.934).

➡️ **Số lượng khách hàng có xu hướng tăng trưởng nhưng không ổn định và cao nhất tại `tháng 5/2015`.**

---
### ❓Q9: Top 3 mẫu điện thoại mang lại doanh thu cao nhất của từng tháng?
**`Samsung`** xuất hiện trong **top 3 doanh thu ở cả 5 tháng**. Cụ thể, các mẫu thuộc dòng *Galaxy Note II* nằm ở vị trí doanh thu **top 1** trong hai tháng đầu năm **tháng 1–2** và tiếp tục giữ mặt trong **top 3** ở các **tháng 3–5** với các mẫu *Galaxy khác*.

**`Nokia`** xuất hiện trong **Top 3** doanh thu với **dòng Lumia ở cả 5 tháng**.

➡️ **`Samsung` và `Nokia` đều duy trì doanh thu cao và hiện diện ổn định trong suốt 5 tháng vì vậy cần có lượng hàng tồn kho ổn định cho các dòng sản phẩm của hãng.**

Trong **top 3** mẫu điện thoại bán chạy nhất có **màu sắc chủ đạo** là **`tháng 1/2015`** (1 trắng, 1 đen, 1 xám), **`tháng 2/2015`** (1 trắng, 1 đen, 1 xám), **`tháng 3/2015`** (2 trắng, 1 đen), **`tháng 4/2015`** (2 đen, 1 trắng), **`tháng 5/2015`** (2 trắng, 1 đen)

➡️ **Các dòng điện thoại trong top 3 đều thuộc các gam màu trung tính trắng, đen, xám.**

---
### ❓Q10: Hãng điện thoại được mua trả góp nhiều nhất?
Trong các hãng điện thoại,**`Apple`** có tỷ lệ trả góp **nhiều nhất** (12,81%), xếp **thứ 2** là  **`Sony`** (12,62%) và **thứ ba** là **`HTC`** (10,81%).

➡️ **Hãng `Apple` được mua trả góp nhiều nhất.**

---
