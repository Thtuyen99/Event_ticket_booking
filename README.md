Thực hành Lab_01 - Môn Cơ Sở Dữ Liệu - Giảng viên Lê Hà Thanh

Họ tên: Nguyễn Thanh Tuyền - MSSV: N24DECE103

Database Overview
Cơ sở dữ liệu event_ticket_booking được thiết kế để quản lý hoạt động tổ chức sự kiện và bán vé. Cơ sở dữ liệu gồm 9 bảng: event_category, venue, event, customer, ticket_type, ticket_order, order_item, payment và ticket. Các bảng liên kết với nhau để lưu thông tin danh mục, địa điểm, sự kiện, khách hàng, đơn đặt vé, chi tiết vé trong đơn, giao dịch thanh toán và từng vé được phát hành. Luồng dữ liệu chính bắt đầu khi khách hàng tạo đơn hàng, chọn loại vé và số lượng; sau đó hệ thống ghi nhận thanh toán và quản lý vé đã phát hành.

1. DDL Scripts
Tệp	Mục đích
create_database.sql	Tạo database event_ticket_booking và chọn database để sử dụng.
create_table1.sql	Tạo các bảng event_category, venue và event.
create_table2.sql	Tạo các bảng customer, ticket_type, ticket_order, order_item, payment và ticket.
create_index.sql	Tạo các index hỗ trợ tra cứu sự kiện, đơn hàng, thanh toán và vé.
create_procedure.sql	Tạo procedure get_order_summary để truy vấn thông tin và tính tổng số vé, tổng tiền của một đơn hàng.
create_dulieu.sql	Thêm dữ liệu mẫu để kiểm tra database.

Công cụ sử dụng: MySQL, MySQL Workbench.
2.ERD (ERD.png)
Relationships between tables
event_category – event
•	Một danh mục có thể gồm nhiều sự kiện; mỗi sự kiện thuộc một danh mục. (1:N)
venue – event
•	Một địa điểm có thể tổ chức nhiều sự kiện; mỗi sự kiện diễn ra tại một địa điểm. (1:N)
event – ticket_type
•	Một sự kiện có thể có nhiều loại vé; mỗi loại vé thuộc về một sự kiện. (1:N)
customer – ticket_order
•	Một khách hàng có thể tạo nhiều đơn hàng; mỗi đơn hàng thuộc về một khách hàng. (1:N)
ticket_order – order_item
•	Một đơn hàng có thể gồm nhiều chi tiết đơn hàng; mỗi chi tiết thuộc về một đơn hàng. (1:N)
ticket_type – order_item
•	Một loại vé có thể xuất hiện trong nhiều chi tiết đơn hàng; mỗi chi tiết đơn hàng chọn một loại vé. (1:N)
ticket_order – payment
•	Một đơn hàng có thể có nhiều giao dịch thanh toán; mỗi giao dịch thuộc về một đơn hàng. (1:N)
order_item – ticket
•	Một chi tiết đơn hàng có thể tạo ra nhiều vé riêng lẻ; mỗi vé được tạo từ một chi tiết đơn hàng. (1:N)
Ghi chú: customer liên kết với payment thông qua ticket_order; database hiện không có quan hệ trực tiếp giữa hai bảng này.
Công cụ sử dụng: https://sqltoerdiagram.com/
3. Table Description
3.1. event_category
Dùng để phân loại sự kiện, ví dụ: Music, Sports, Conference, Festival.
Column	Data type	Constraints	Description
category_id	INT	PK, AUTO_INCREMENT	Mã danh mục
category_name	VARCHAR(100)	NOT NULL, UNIQUE	Tên danh mục
description	VARCHAR(500)	NULL	Mô tả danh mục
3.2. venue
Lưu thông tin địa điểm như SECC, sân vận động, nhà hát.
Column	Data type	Constraints	Description
venue_id	INT	PK, AUTO_INCREMENT	Mã địa điểm
venue_name	VARCHAR(150)	NOT NULL	Tên địa điểm
address	VARCHAR(255)	NOT NULL	Địa chỉ
capacity	INT	NOT NULL, CHECK > 0	Sức chứa
3.3. event
Lưu sự kiện cụ thể, gồm tên, thời gian, địa điểm, danh mục và trạng thái.
Column	Data type	Constraints	Description
event_id	INT	PK, AUTO_INCREMENT	Mã sự kiện
category_id	INT	FK, NOT NULL	Danh mục sự kiện
venue_id	INT	FK, NOT NULL	Địa điểm tổ chức
event_name	VARCHAR(200)	NOT NULL	Tên sự kiện
description	TEXT	NULL	Mô tả
start_time	DATETIME	NOT NULL	Thời gian bắt đầu
end_time	DATETIME	NOT NULL, CHECK	Thời gian kết thúc
event_status	ENUM	NOT NULL, DEFAULT 'Draft'	Trạng thái
3.4. customer
Lưu thông tin người mua vé.
Column	Data type	Constraints	Description
customer_id	INT	PK, AUTO_INCREMENT	Mã khách hàng
full_name	VARCHAR(150)	NOT NULL	Họ tên
email	VARCHAR(150)	NOT NULL, UNIQUE	Email
phone	VARCHAR(20)	NULL	Số điện thoại
created_at	TIMESTAMP	NOT NULL, DEFAULT CURRENT_TIMESTAMP	Ngày tạo hồ sơ
3.5. ticket_type
Mỗi sự kiện có thể bán nhiều loại vé, ví dụ Standard và VIP.
Column	Data type	Constraints	Description
ticket_type_id	INT	PK, AUTO_INCREMENT	Mã loại vé
event_id	INT	FK, NOT NULL	Sự kiện
type_name	VARCHAR(100)	NOT NULL	Tên loại vé
price	DECIMAL(12,2)	NOT NULL, CHECK >= 0	Giá niêm yết
quantity_issued	INT	NOT NULL, CHECK >= 0	Số vé dự kiến phát hành
created_at	TIMESTAMP	NOT NULL, DEFAULT CURRENT_TIMESTAMP	Thời điểm tạo
Cặp (event_id, type_name) là duy nhất để một sự kiện không có hai loại vé trùng tên.
3.6. ticket_order
Đại diện cho một lần đặt vé của khách hàng. (don hang)
Column	Data type	Constraints	Description
order_id	INT	PK, AUTO_INCREMENT	Mã đơn hàng
customer_id	INT	FK, NOT NULL	Người đặt
order_date	TIMESTAMP	NOT NULL, DEFAULT CURRENT_TIMESTAMP	Ngày đặt
order_status	ENUM	NOT NULL, DEFAULT 'Pending'	Trạng thái đơn
3.7. order_item
Mỗi dòng ghi một loại vé được mua trong một đơn hàng.
Column	Data type	Constraints	Description
order_item_id	INT	PK, AUTO_INCREMENT	Mã chi tiết đơn
order_id	INT	FK, NOT NULL	Đơn hàng
ticket_type_id	INT	FK, NOT NULL	Loại vé
quantity	INT	NOT NULL, CHECK > 0	Số vé đặt
unit_price	DECIMAL(12,2)	NOT NULL, CHECK >= 0	Giá tại thời điểm đặt
Thành tiền của mỗi mục hàng được tính bằng quantity * unit_price; không cần lưu thêm một cột thành tiền có thể tính được.
3.8. payment
Lưu thông tin các giao dịch thanh toán liên quan đến đơn hàng.
Column	Data type	Constraints	Description
payment_id	INT	PK, AUTO_INCREMENT	Mã giao dịch
order_id	INT	FK, NOT NULL	Đơn hàng
amount	DECIMAL(12,2)	NOT NULL, CHECK >= 0	Số tiền giao dịch
payment_method	ENUM	NOT NULL	Phương thức thanh toán
payment_status	ENUM	NOT NULL, DEFAULT 'Pending'	Trạng thái giao dịch
transaction_reference	VARCHAR(100)	UNIQUE, NULL	Mã giao dịch từ cổng thanh toán
payment_date	TIMESTAMP	NOT NULL, DEFAULT CURRENT_TIMESTAMP	Thời điểm ghi nhận
3.9. ticket
Lưu từng vé riêng lẻ, thay vì chỉ lưu tổng số vé trong đơn.
Column	Data type	Constraints	Description
ticket_id	INT	PK, AUTO_INCREMENT	Mã bản ghi vé
order_item_id	INT	FK, NOT NULL	Chi tiết đơn đã mua
ticket_code	CHAR(36)	NOT NULL, UNIQUE	Mã vé dùng để xác thực
ticket_status	ENUM	NOT NULL, DEFAULT 'Valid'	Trạng thái vé
issued_at	TIMESTAMP	NOT NULL, DEFAULT CURRENT_TIMESTAMP	Thời điểm phát hành
used_at	DATETIME	NULL	Thời điểm sử dụng


4. Bảng mô tả index
Index name	Table	Columns	Type	Purpose
PRIMARY	event	event_id	Unique B-tree	Xác định sự kiện
uq_customer_email	customer	email	Unique B-tree	Ngăn email trùng
uq_ticket_code	ticket	ticket_code	Unique B-tree	Tra cứu và xác thực vé
idx_event_start_time	event	start_time	Non-unique B-tree	Lọc, sắp xếp theo giờ bắt đầu
idx_event_status_start_time	event	event_status, start_time	Non-unique B-tree	Lọc trạng thái rồi theo thời gian
idx_ticket_order_customer_date	ticket_order	customer_id, order_date	Non-unique B-tree	Tra cứu đơn theo khách hàng ngày
idx_payment_order_status	payment	order_id, payment_status	Non-unique B-tree	Tra cứu trạng thái thanh toán của đơn
idx_ticket_order_item	ticket	order_item_id	Non-unique B-tree	Lấy các vé của một mục đơn hàng

5. Constraints Documentation.
5.1. Primary key constraints
Constraint	Table	Column	Purpose
pk_event_category	event_category	category_id	Xác định duy nhất danh mục
pk_venue	venue	venue_id	Xác định duy nhất địa điểm
pk_event	event	event_id	Xác định duy nhất sự kiện
pk_customer	customer	customer_id	Xác định duy nhất khách hàng
pk_ticket_type	ticket_type	ticket_type_id	Xác định duy nhất loại vé
pk_ticket_order	ticket_order	order_id	Xác định duy nhất đơn hàng
pk_order_item	order_item	order_item_id	Xác định duy nhất chi tiết đơn
pk_payment	payment	payment_id	Xác định duy nhất giao dịch
pk_ticket	ticket	ticket_id	Xác định duy nhất vé
5.2. Foreign key constraints
Constraint	Table.Column	References	Purpose
fk_event_category	event.category_id	event_category.category_id	Liên kết sự kiện với danh mục
fk_event_venue	event.venue_id	venue.venue_id	Liên kết sự kiện với địa điểm
fk_ticket_type_event	ticket_type.event_id	event.event_id	Xác định loại vé thuộc sự kiện
fk_ticket_order_customer	ticket_order.customer_id	customer.customer_id	Xác định chủ đơn
fk_order_item_order	order_item.order_id	ticket_order.order_id	Liên kết chi tiết với đơn
fk_order_item_ticket_type	order_item.ticket_type_id	ticket_type.ticket_type_id	Xác định loại vé được đặt
fk_payment_order	payment.order_id	ticket_order.order_id	Liên kết giao dịch với đơn
fk_ticket_order_item	ticket.order_item_id	order_item.order_item_id	Liên kết vé đã phát hành với chi tiết đơn
Các khóa ngoại sử dụng hành vi mặc định RESTRICT/NO ACTION khi xóa hoặc cập nhật bản ghi được tham chiếu. Điều này giúp tránh xóa nhầm dữ liệu đơn hàng, giao dịch hoặc vé.
5.3. Unique constraints
Constraint	Table	Column(s)	Purpose
uq_event_category_name	event_category	category_name	Không trùng tên danh mục
uq_customer_email	customer	email	Không trùng email
uq_ticket_type_event_name	ticket_type	event_id, type_name	Không trùng tên loại vé trong cùng sự kiện
uq_order_item_order_type	order_item	order_id, ticket_type_id	Một loại vé chỉ có một dòng trong mỗi đơn
uq_payment_transaction_reference	payment	transaction_reference	Không trùng mã giao dịch khi mã được cung cấp
uq_ticket_code	ticket	ticket_code	Không trùng mã vé
5.4. Check constraints
Constraint	Table	Rule	Purpose
chk_venue_capacity	venue	capacity > 0	Sức chứa phải dương
chk_event_time	event	end_time > start_time	Thời gian kết thúc sau bắt đầu
chk_ticket_price	ticket_type	price >= 0	Giá vé không âm
chk_ticket_quantity	ticket_type	quantity_issued >= 0	Số lượng phát hành không âm
chk_order_item_quantity	order_item	quantity > 0	Mỗi dòng đơn phải có số lượng dương
chk_order_item_price	order_item	unit_price >= 0	Giá tại thời điểm đặt không âm
chk_payment_amount	payment	amount >= 0	Số tiền giao dịch không âm

6. Version Control
Các tệp SQL và tài liệu Database Design Documentation (DDD) được quản lý bằng Git để theo dõi các thay đổi của cơ sở dữ liệu. Khi thay đổi bảng, cột, chỉ mục, ràng buộc hoặc stored procedure, các tệp liên quan được cập nhật và lưu lại bằng commit. Việc này giúp xem lại lịch sử thay đổi và khôi phục phiên bản trước khi cần thiết.
Mã nguồn được lưu trữ trên GitHub tại: https://github.com/Thtuyen99/Event_ticket_booking
7. Regular Updates
Tài liệu Database Design Documentation (DDD) cần được cập nhật mỗi khi cấu trúc cơ sở dữ liệu thay đổi, bao gồm việc thêm, sửa hoặc xóa bảng, cột, chỉ mục, ràng buộc hoặc stored procedure. Sau mỗi thay đổi, cần đối chiếu DDD với các SQL scripts để bảo đảm tài liệu phản ánh chính xác cấu trúc hiện tại của database.
8. Tài liệu Stored Procedure: get_order_summary
Mục đích:
Truy xuất thông tin đơn hàng, đồng thời tính tổng số vé và tổng giá trị đơn hàng.
Tham số đầu vào:
•	p_order_id (INT): Mã đơn hàng cần truy xuất.
Kết quả trả về:
•	order_id: Mã đơn hàng
•	customer_name: Tên khách hàng
•	order_date: Ngày đặt hàng
•	order_status: Trạng thái đơn hàng
•	total_tickets: Tổng số vé
•	order_total: Tổng giá trị đơn hàng
Mô tả:
Procedure tìm đơn hàng theo mã được cung cấp, kết hợp với bảng customer để lấy tên khách hàng và bảng order_item để tính tổng số vé, tổng giá trị đơn hàng. Hàm COALESCE trả về 0 nếu đơn hàng chưa có chi tiết đơn hàng.
Các bảng liên quan:
•	ticket_order
•	customer
•	order_item
Kiểm thử:
Chạy lệnh CALL get_order_summary(1); để xem thông tin tổng hợp của đơn hàng có mã 1.
