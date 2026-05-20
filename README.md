# Research by Learning Project - Team 3
Đề tài: Nền tảng hổ trợ cho thuê ô tô điện tự lái

1. Thành viên nhóm:

Nguyễn Gia Huy - DE191025
Hồ Văn Dương - DE190963
Bùi	Nam	Khánh - DE200227
Trần Đức Thịnh - DE200403
Lê Quang Minh Đức - DE190607

3. Chi tiết dự án & Hàm lượng nghiên cứu

🔹 Phần Business (Nghiệp vụ của dự án)
1. Business Model:
- Định vị nền tảng: Hế thống đóng vai trò là bên thứ ba trung gian (Platform-as-a-Service), cung cấp giải pháp công nghệ để kết nối những người có xe ô tô nhãn rỗi và những người có nhu cầu thuê xe tự lái ngắn hạn.
- Giải quyết vấn đề:
 + Với người thuê: Khó tìm xe với giá hợp lí, thủ tục giấy tờ rườm rà, rủi ro bị lừa cọc, khó đánh giá chất lượng xe thực tế.
 + Với chủ xe: Xe để không làm lãng phí khấu hao, khó tìm nguồn khách hàng tin cậy, lo sợ rủi ro mất cắp, tranh chấp với người dùng khi hư hỏng.
2. Revenue Streams(Dòng tiền và doanh thu):
- Phí hoa hồng (Commission Fee) - Nguồn thu cốt lõi: Nền tảng sẽ thu một tỷ lệ 14% trên tổng giá trị mỗi chuyến đi thành công. Số tiền này được trừ trực tiếp vào doanh thu của chủ xe trước khi nền tảng đối soát và chuyển tiền cho họ.
- Phí giao nhận xe và phụ thu: Thu thêm phí nếu khách hàng yêu cầu giao/nhận xe tận nơi (tại sân bay, khách sạn, v.v.) hoặc phụ thu khi vượt số km giới hạn và trả xe trễ giờ quy định.
- Phí đăng tin/Quảng cáo nổi bật (Listing/Ads Fee): Thu phí các đơn vị cho thuê xe chuyên nghiệp hoặc các chủ xe muốn ghim hiển thị xe của họ lên đầu trang kết quả tìm kiếm.

3. Quy trình Dòng tiền & Thanh toán (Financial Flow):
- Cơ chế tạm giữ tiền (Escrow): Khi Renter đặt xe, tiền thuê và tiền cọc sẽ được thanh toán qua cổng điện tử và chuyển vào tài khoản trung gian của hệ thống (Ví nền tảng).
- Giải ngân an toàn: Chỉ khi trạng thái Use Case "Nhận/Trả xe" (UC18) hoàn tất, không có phát sinh khiếu nại (UC30), hệ thống mới tự động cắt 14% hoa hồng và tự động giải ngân phần tiền còn lại về tài khoản ngân hàng của Chủ xe, đồng thời hoàn cọc (nếu có) về thẻ của Renter.

4. Quy định & Chính sách nghiệp vụ (Business Policies):
- Chính sách định giá: Chủ xe tự quyết định giá thuê theo ngày, nhưng hệ thống có thể áp dụng giới hạn mức trần/sàn, hoặc phụ thu phí vượt km, phí giao xe tận nơi.
- Chính sách hủy chuyến (Cancellation Policy):
    + Renter hủy trước 24h: Hoàn 100% tiền.
    + Renter hủy sát giờ: Mất phí cọc (chuyển cho chủ xe để bồi thường cơ hội).
    + Chủ xe tự ý hủy: Bị phạt tiền (trừ vào số dư ví) và giảm điểm uy tín.

🔹 Hàm lượng nghiên cứu (Research Depth)
1. Nghiên cứu mô hình kiến trúc ứng dụng Web với Java
Áp dụng mô hình MVC (Model - View - Controller): Nghiên cứu và tổ chức mã nguồn theo chuẩn cấu trúc MVC để tách biệt rõ ràng các thành phần: Giao diện hiển thị (JSP/Thymeleaf), Bộ điều hướng và xử lý yêu cầu (Servlet/Controller), và Tầng dữ liệu nghiệp vụ (Model/Service). Cách tổ chức này giúp code dễ đọc, dễ debug và bảo trì trong quá trình làm việc nhóm.

Thiết kế tầng giao tiếp dữ liệu (DAO/Repository Pattern): Nghiên cứu cách tách biệt các câu lệnh SQL ra khỏi logic xử lý nghiệp vụ thông qua tầng DAO (Data Access Object) kết hợp kết nối cơ sở dữ liệu JDBC (hoặc Hibernate/Spring Data JPA), giúp quản lý các kết nối đến MySQL một cách an toàn và tối ưu.

2. Nghiên cứu giải pháp xác thực và kiểm soát quyền truy cập
Cơ chế lưu trạng thái đăng nhập (Session-based Authentication): Nghiên cứu và áp dụng cơ chế HTTPSession mặc định của Java để quản lý trạng thái đăng nhập của người dùng. Hệ thống sẽ tự động hủy phiên làm việc (Session Timeout) sau một khoảng thời gian nhất định để bảo vệ tài khoản.

Phân quyền hệ thống bằng Bộ lọc (Filter / Interceptor): Thiết kế giải pháp phân quyền cho 3 nhóm đối tượng (Khách thuê, Chủ xe, Admin) bằng cách sử dụng HTTP Filter(hoặc Spring Security). Bộ lọc sẽ chặn các yêu cầu truy cập trái phép vào các trang quản trị hoặc chức năng duyệt xe nếu người dùng không có quyền tương ứng.

Mã hóa mật khẩu cơ bản: Thay vì lưu mật khẩu dạng văn bản thô, nghiên cứu áp dụng các hàm băm một chiều có sẵn trong Java (như mã hóa MD5, SHA-256 hoặc thư viện BCrypt) để bảo mật thông tin người dùng trong cơ sở dữ liệu.

3. Nghiên cứu thuật toán kiểm tra trùng lịch đặt xe
Xử lý logic ràng buộc thời gian (Thuật toán cốt lõi của bài tập): Thiết kế thuật toán so sánh khoảng thời gian. Khi khách hàng chọn ngày bắt đầu và ngày kết thúc để thuê xe, hệ thống sẽ thực thi một câu lệnh truy vấn SQL kiểm tra trong bảng DonThue xem có bất kỳ đơn hàng nào của chiếc xe đó đã được duyệt thành công mà bị chồng lấn thời gian hay không. Nếu có kết quả trả về, hệ thống sẽ từ chối lệnh đặt xe để tránh tình trạng một chiếc xe bị thuê trùng lịch.

4. Nghiên cứu thiết kế cơ sở dữ liệu quan hệ (RDBMS)
Thiết kế mô hình dữ liệu chuẩn hóa: Nghiên cứu tổ chức cơ sở dữ liệu MySQL đạt chuẩn 2NF/3NF gồm các bảng cốt lõi: Người dùng, Xe, Đơn thuê, và Hóa đơn. Đảm bảo tính toàn vẹn dữ liệu thông qua các ràng buộc khóa chính (Primary Key), khóa ngoại (Foreign Key) và cơ chế tự động cập nhật trạng thái xe khi đơn thuê được duyệt.

CÔNG NGHỆ VÀ CÔNG CỤ SỬ DỤNG (ĐÃ TINH GỌN)
1. Công nghệ phát triển
Ngôn ngữ chính: Java.

Công nghệ Web: Servlet & JSP (nếu làm Java Web thuần) hoặc Spring Boot & Thymeleaf (nếu làm Framework).

Database: MySQL (Kết nối thông qua JDBC Driver hoặc JPA).

Frontend: HTML, CSS, JavaScript kết hợp các thư viện giao diện như Bootstrap để tự động tối ưu hiển thị trên các màn hình máy tính và điện thoại (Responsive Design) mà không cần viết nhiều code CSS phức tạp.

2. Công cụ hỗ trợ
Thiết kế giao diện: Figma (Vẽ nhanh các màn hình chính để định hình luồng chạy của ứng dụng trước khi code).

Quản lý mã nguồn: GitHub (Sử dụng các nhánh cơ bản để gộp code của các thành viên trong nhóm lại với nhau).

Quản lý công việc: Jira (hoặc có thể thay bằng Trello cho đơn giản hơn nếu nhóm ít người) để phân chia đầu việc theo tuần.

3. Quản lý công việc (Link Jira)
https://giahuynguyentq010605.atlassian.net/jira/software/projects/KAN/boards/2

4. Thiết kế giao diện (Figma / Frontend)
