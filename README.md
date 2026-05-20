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
1. Tuyên bố tầm nhìn (Vision Statement):
Mục tiêu dài hạn: Xây dựng một nền tảng kết nối trực tiếp, minh bạch và an toàn giữa những người có ô tô nhàn rỗi và những người có nhu cầu thuê xe tự lái ngắn hạn. Hế thống đóng vai trò là bên thứ ba trung gian (Platform-as-a-Service) hướng tới việc tối ưu hóa nguồn lực phương tiện trong xã hội, giúp người thuê tiết kiệm chi phí, dễ dàng tìm được chiếc xe ưng ý chỉ với vài thao tác, đồng thời tạo ra nguồn thu nhập thụ động an toàn cho các chủ xe.

Nhóm người dùng chính được phục vụ:

Người thuê xe (Khách hàng): Những cá nhân hoặc gia đình có nhu cầu sử dụng ô tô ngắn ngày để đi du lịch, công tác, hoặc di chuyển cá nhân nhưng không muốn hoặc chưa sở hữu xe.

Chủ xe (Đối tác cho thuê): Các cá nhân hoặc doanh nghiệp nhỏ có ô tô nhàn rỗi muốn tận dụng tài sản để kiếm thêm thu nhập.

2. Sơ đồ bối cảnh (Context Diagram)
Hệ thống trung tâm: Nền tảng cho thuê ô tô tự lái (Web/App). Các tác nhân chính (Actors) và cách tương tác:

Khách hàng (User): Tương tác để tìm kiếm xe theo địa điểm/thời gian, xem chi tiết xe, gửi yêu cầu đặt xe, thanh toán tiền cọc, xác nhận nhận/trả xe và đánh giá chuyến đi.

Chủ xe (Car Owner): Tương tác để đăng ký tài khoản đối tác, tạo hồ sơ xe (thêm hình ảnh, giá cả, lịch bận), duyệt hoặc từ chối yêu cầu đặt xe từ khách, nhận thanh toán và đánh giá khách hàng.

Hệ thống thanh toán (Payment Gateway): (Ví dụ như tích hợp VNPAY, Momo, hoặc thẻ ngân hàng). Tương tác để xử lý các giao dịch đặt cọc, thanh toán phần còn lại, giữ tiền đảm bảo và xử lý hoàn tiền nếu có hủy chuyến.

Hệ thống bản đồ/định vị (Map API): Tương tác để lấy vị trí hiện tại của khách hàng, hiển thị danh sách các xe đang ở gần, và hỗ trợ chỉ đường đến điểm nhận xe.

Quản trị viên (Admin): Tương tác để duyệt hồ sơ xe mới đăng ký (đảm bảo xe hợp lệ), quản lý tài khoản người dùng, giải quyết tranh chấp (nếu có va chạm, hỏng hóc), và xem báo cáo doanh thu.

3. Danh sách sự kiện (Event List)
- "Khách hàng gửi yêu cầu đặt xe": Hệ thống ghi nhận thông tin chuyến đi (thời gian, địa điểm, xe được chọn) và gửi thông báo chờ xác nhận đến Chủ xe.
- "Chủ xe xác nhận yêu cầu thuê xe": Hệ thống chuyển trạng thái đơn hàng và yêu cầu Khách hàng thực hiện thanh toán tiền cọc trong một khoảng thời gian quy định.
- "Khách hàng thanh toán cọc thành công": Hệ thống ghi nhận giao dịch, khóa lịch của chiếc xe đó trong khoảng thời gian đã đặt, và gửi thông báo chốt chuyến đi cho cả hai bên.
- "Khách hàng nhận xe bắt đầu chuyến đi": Hai bên tiến hành giao xe (có thể tải lên biên bản đồng kiểm tình trạng xe lên hệ thống). Hệ thống bắt đầu tính thời gian tính phí thực tế.
- "Khách hàng trả xe và hoàn tất chuyến đi": Hệ thống tính toán tổng chi phí cuối cùng (bao gồm cả phí phát sinh như quá giờ, phụ phí rửa xe nếu có), xử lý thanh toán phần còn lại và mở lại lịch trống cho xe.
- "Khách hàng/Chủ xe gửi đánh giá (Rating/Review)": Hệ thống cập nhật điểm uy tín của tài khoản và hiển thị nhận xét trên hồ sơ công khai.

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

CÔNG NGHỆ VÀ CÔNG CỤ SỬ DỤNG
1. Công nghệ phát triển
Ngôn ngữ chính: Java.
Công nghệ Web: Servlet & JSP.
Database: MySQL (Kết nối thông qua JDBC Driver hoặc JPA).
Frontend: HTML, CSS, JavaScript kết hợp các thư viện giao diện như Bootstrap để tự động tối ưu hiển thị trên các màn hình máy tính và điện thoại (Responsive Design) mà không cần viết nhiều code CSS phức tạp.

2. Công cụ hỗ trợ
- Thiết kế giao diện: Figma (Vẽ nhanh các màn hình chính để định hình luồng chạy của ứng dụng trước khi code).
- Quản lý mã nguồn: GitHub (Sử dụng các nhánh cơ bản để gộp code của các thành viên trong nhóm lại với nhau).
- Quản lý công việc: Jira.

3. Quản lý công việc (Link Jira)
https://giahuynguyentq010605.atlassian.net/jira/software/projects/KAN/boards/2

4. Thiết kế giao diện (Figma / Frontend)
https://www.figma.com/design/24yoPSpyqK0TVfSjX8T1WV/Untitled?node-id=0-1&t=iZ2vDAehr4oizSpV-1
