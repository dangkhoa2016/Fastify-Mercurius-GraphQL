# Fastify Mercurius GraphQL

> 🌐 Language / Ngôn ngữ: [English](README.md) | **Tiếng Việt**

## Giới thiệu
Đây là một dự án mẫu minh họa cách tích hợp Fastify và Mercurius GraphQL để phát triển một ứng dụng mạng xã hội chia sẻ về mèo đơn giản. Dự án này tận dụng các công nghệ hiện đại nhằm mang lại một giải pháp mạnh mẽ và hiệu quả.

## Công nghệ sử dụng
- [Fastify](https://www.fastify.io/): Một framework web hiệu năng cao dành cho Node.js, nổi tiếng với tốc độ nhanh và chi phí tài nguyên thấp.
- [Mercurius](https://mercurius.dev/): Một adapter GraphQL cho Fastify, cho phép tích hợp GraphQL liền mạch vào các ứng dụng Fastify.
- [Knex.js](http://knexjs.org/): Một công cụ xây dựng truy vấn SQL cho Node.js hỗ trợ nhiều hệ quản trị cơ sở dữ liệu, giúp đơn giản hóa việc tương tác và migration cơ sở dữ liệu.
- [SQLite3](https://www.sqlite.org/index.html): Một hệ quản trị cơ sở dữ liệu quan hệ gọn nhẹ, không cần máy chủ, được sử dụng cho mục đích phát triển và kiểm thử cục bộ.

## Tính năng chính
- **Theo dõi / Bỏ theo dõi người dùng**: Kết nối với những người dùng khác để cập nhật hoạt động của họ.
- **Thích / Bỏ thích mèo**: Tương tác với các hồ sơ mèo đáng yêu bằng cách thích hoặc bỏ thích.
- **Thích / Bỏ thích ảnh**: Tương tác với những bức ảnh mèo hấp dẫn thông qua lượt thích hoặc bỏ thích.
- **Quản trị viên**: Quản trị viên có thể quản lý tài khoản người dùng, hồ sơ mèo và ảnh được tải lên bằng cách bật hoặc vô hiệu hóa chúng.

## Các dự án Frontend liên quan
Server backend này cung cấp dịch vụ cho các dự án frontend sau:
- [GraphQL-Vue-With-Route](https://github.com/dangkhoa2016/GraphQL-Vue-With-Route) - Frontend Vue.js 3 có định tuyến
- [GraphQL-Vue-Without-Route](https://github.com/dangkhoa2016/GraphQL-Vue-Without-Route) - Frontend Vue.js 3 không có định tuyến
- [GraphQL-Vue-With-Route-Vite](https://github.com/dangkhoa2016/GraphQL-Vue-With-Route-Vite) - Frontend Vue.js 3 có định tuyến và Vite

### Điều kiện tiên quyết
Hãy đảm bảo bạn đã cài đặt các thành phần sau trước khi bắt đầu:
- Node.js
- Yarn

### Bắt đầu
Làm theo các bước sau để thiết lập và chạy dự án:
1. Sao chép (clone) kho lưu trữ này về máy của bạn.
2. Di chuyển đến thư mục dự án trong terminal.
3. Chạy `yarn` để cài đặt toàn bộ dependencies của dự án.
4. Thực thi `yarn dev` để khởi động máy chủ.
5. Mở trình duyệt web và truy cập `http://localhost:3000/graphiql` để sử dụng giao diện GraphiQL playground.

## Giấy phép
Dự án này được cấp phép theo [MIT License](LICENSE). Để biết thêm chi tiết, vui lòng xem tệp LICENSE.

### Tác giả
- Fork gốc bởi **Yuri Fontella**: [YuriFontella](https://github.com/YuriFontella)
- Được duy trì bởi **Đăng Khoa**: [dangkhoa2016](https://github.com/dangkhoa2016)
