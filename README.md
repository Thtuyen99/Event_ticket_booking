Thực hành Lab_01 - Môn Cơ Sở Dữ Liệu - Giảng viên Lê Hà Thanh

Họ tên: Nguyễn Thanh Tuyền - MSSV: N24DECE103

Database Overview
Cơ sở dữ liệu event_ticket_booking được thiết kế để quản lý hoạt động tổ chức sự kiện và bán vé. Cơ sở dữ liệu gồm 9 bảng: event_category, venue, event, customer, ticket_type, ticket_order, order_item, payment và ticket. Các bảng liên kết với nhau để lưu thông tin danh mục, địa điểm, sự kiện, khách hàng, đơn đặt vé, chi tiết vé trong đơn, giao dịch thanh toán và từng vé được phát hành. Luồng dữ liệu chính bắt đầu khi khách hàng tạo đơn hàng, chọn loại vé và số lượng; sau đó hệ thống ghi nhận thanh toán và quản lý vé đã phát hành.
