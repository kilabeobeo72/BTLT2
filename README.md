# BTLT2 - Tích hợp dữ liệu vào Retail_DDS (SSIS)

## 1. Cấu trúc thư mục (`23120055_23120290_21120277/`)
- `Scripts/ERP.sql`: Script tạo Database nguồn `RetailPlus_Legacy` (chứa bảng `ERP_Sales`, `CustomerMaster`, `ProductMaster`, `CustomerMap`, `ProductMap`).
- `Scripts/RetailDDS.sql`: Script tạo Database đích `Retail_DDS` (chứa `DimDate`, `DimCustomer`, `DimProduct`, `FactSales`, `ETL_RejectedRows`).
- `Data/POS.csv`: Nguồn dữ liệu bán hàng POS (`T001` -> `T016`).
- `Data/Online.xlsx`: Nguồn dữ liệu đơn hàng Online (`T011` -> `T026`).
- `23120055_23120290_21120277.sln`: Solution SSIS mở bằng Visual Studio.

## 2. Hướng dẫn cài đặt trước khi kéo thả trên Visual Studio
1. Clone repo này về đúng đường dẫn `D:\BTLT2` (để không bị lệch đường dẫn file nguồn trong Connection Manager).
2. Mở **SSMS**, chạy 2 file trong thư mục `23120055_23120290_21120277/Scripts/`:
   - `ERP.sql`
   - `RetailDDS.sql`
3. Mở file `23120055_23120290_21120277\23120055_23120290_21120277.sln` bằng Visual Studio.

## 3. Phân công công việc (2 người làm trên Package riêng để tránh xung đột file `.dtsx`)
- **Người 1**: Tạo package riêng xử lý nạp 3 bảng Dimension (`DimDate`, `DimCustomer`, `DimProduct`) + Nạp `FactSales` từ nguồn `dbo.ERP_Sales`.
- **Người 2**: Tạo package riêng xử lý nạp `FactSales` từ 2 nguồn file `POS.csv` và `Online.xlsx`.
- Sau khi hoàn thành, ghép chung vào `Package.dtsx` chính bằng `Sequence Container` hoặc `Execute Package Task`.
