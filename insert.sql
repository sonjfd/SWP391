
-- 1. Bảng roles: Vai trò người dùng
INSERT INTO roles (name) VALUES
('customer'),
('admin'),
('doctor'),
('staff');


-- 2. Users
INSERT INTO users (username, email, password, full_name, phone, address, role_id)
VALUES
-- Admins (role_id = 2)
('admin_1', 'admin1@example.com', 'hashed_pw', N'Nguyễn Văn A', '0911111111', N'123 Lê Lợi, Q.1', 2),
('admin_2', 'admin2@example.com', 'hashed_pw', N'Huỳnh Văn E', '0955555555', N'12 Lý Thường Kiệt, Q.10', 2),
('admin_3', 'admin3@example.com', 'hashed_pw', N'Hồ Văn I', '0999999999', N'101 Phạm Ngũ Lão, Q.1', 2),

-- Staffs (role_id = 4)
('staff_1', 'staff1@example.com', 'hashed_pw', N'Trần Thị B', '0922222222', N'456 Nguyễn Trãi, Q.5', 4),
('staff_2', 'staff2@example.com', 'hashed_pw', N'Đỗ Thị F', '0966666666', N'34 Pasteur, Q.1', 4),
('staff_3', 'staff3@example.com', 'hashed_pw', N'Bùi Thị J', '0900000000', N'67 Nguyễn Văn Cừ, Q.5', 4),

-- Doctors (role_id = 3)
('doctor_1', 'doctor1@example.com', 'hashed_pw', N'Phạm Văn C', '0933333333', N'789 CMT8, Q.3', 3),
('doctor_2', 'doctor2@example.com', 'hashed_pw', N'Võ Văn G', '0977777777', N'78 Điện Biên Phủ, Q.BT', 3),

-- Customers (role_id = 1)
('customer_1', 'cust1@example.com', 'hashed_pw', N'Lê Thị D', '0944444444', N'321 Hai Bà Trưng, Q.3', 1),
('customer_2', 'cust2@example.com', 'hashed_pw', N'Ngô Thị H', '0988888888', N'90 Hoàng Diệu, Q.4', 1);

-- 3. Loài
INSERT INTO species (name)
VALUES 
(N'Mèo'),
(N'Chó'),
(N'Thỏ');

-- 4.Giống
-- Giống của Mèo
INSERT INTO breeds (name, species_id) VALUES
(N'Mèo Ba Tư',      (SELECT id FROM species WHERE name = N'Mèo')),
(N'Mèo Anh Lông Ngắn', (SELECT id FROM species WHERE name = N'Mèo')),
(N'Mèo Xiêm',       (SELECT id FROM species WHERE name = N'Mèo')),
(N'Mèo Mướp',       (SELECT id FROM species WHERE name = N'Mèo')),

-- Giống của Chó
(N'Chó Poodle',     (SELECT id FROM species WHERE name = N'Chó')),
(N'Chó Husky',      (SELECT id FROM species WHERE name = N'Chó')),
(N'Chó Phốc Sóc',   (SELECT id FROM species WHERE name = N'Chó')),
(N'Chó Golden',     (SELECT id FROM species WHERE name = N'Chó')),

-- Giống của Thỏ
(N'Thỏ Hà Lan',     (SELECT id FROM species WHERE name = N'Thỏ')),
(N'Thỏ Mỹ',         (SELECT id FROM species WHERE name = N'Thỏ')),
(N'Thỏ Mini Rex',   (SELECT id FROM species WHERE name = N'Thỏ'));



-- 4. Doctors (tham chiếu users.role_id = 3)
INSERT INTO doctors (user_id, specialty, certificates, qualifications, years_of_experience, biography)
VALUES
(
  (SELECT id FROM users WHERE username = 'doctor_1'),
  N'Thú y tổng quát',
  N'Chứng chỉ A',
  N'Bác sĩ thú y',
  10,
  N'Có hơn 10 năm kinh nghiệm khám và điều trị cho chó mèo.'
),
(
  (SELECT id FROM users WHERE username = 'doctor_2'),
  N'Nội khoa thú cưng',
  N'Chứng chỉ B',
  N'Bác sĩ nội trú',
  7,
  N'Chuyên gia điều trị bệnh nội khoa cho thú cưng nhỏ, đặc biệt là mèo.'
);

-- 5. Pets (dùng id động của customer và species)
INSERT INTO pets (owner_id, name, birth_date, breeds_id, gender, description, status)
VALUES
-- 1. Miu - Mèo Ba Tư
((SELECT id FROM users WHERE username = 'customer_1'), N'Miu', '2021-01-01',
 (SELECT id FROM breeds WHERE name = N'Mèo Ba Tư'), N'Cái',
 N'Một cô mèo Ba Tư lông dài, rất hiền và thích nằm ngủ.', N'active'),

-- 2. Bun - Thỏ Hà Lan
((SELECT id FROM users WHERE username = 'customer_2'), N'Bun', '2020-05-05',
 (SELECT id FROM breeds WHERE name = N'Thỏ Hà Lan'), N'Đực',
 N'Thỏ lông trắng, ngoan ngoãn, thích ăn cà rốt và rau xanh.', N'active'),

-- 3. Lu - Chó Poodle
((SELECT id FROM users WHERE username = 'customer_1'), N'Lu', '2019-03-03',
 (SELECT id FROM breeds WHERE name = N'Chó Poodle'), N'Đực',
 N'Chó Poodle thông minh, biết làm nhiều trò và rất thân thiện.', N'inactive'),

-- 4. Đốm - Chó Husky
((SELECT id FROM users WHERE username = 'customer_2'), N'Đốm', '2022-07-07',
 (SELECT id FROM breeds WHERE name = N'Chó Husky'), N'Đực',
 N'Husky có đôi mắt xanh và năng lượng cao, thích chạy nhảy.', N'lost'),

-- 5. Momo - Mèo Anh Lông Ngắn
((SELECT id FROM users WHERE username = 'customer_1'), N'Momo', '2020-06-06',
 (SELECT id FROM breeds WHERE name = N'Mèo Anh Lông Ngắn'), N'Cái',
 N'Mèo lông xám mượt, dễ gần, rất yêu thích được vuốt ve.', N'active'),

-- 6. Susu - Mèo Xiêm
((SELECT id FROM users WHERE username = 'customer_2'), N'Susu', '2020-09-09',
 (SELECT id FROM breeds WHERE name = N'Mèo Xiêm'), N'Cái',
 N'Mèo Xiêm thông minh, đôi mắt to tròn và thích leo trèo.', N'active'),

-- 7. Ken - Mèo Mướp
((SELECT id FROM users WHERE username = 'customer_1'), N'Ken', '2018-08-08',
 (SELECT id FROM breeds WHERE name = N'Mèo Mướp'), N'Đực',
 N'Mèo Mướp truyền thống, lanh lợi, giỏi bắt chuột.', N'deceased'),

-- 8. Mốc - Mèo Ba Tư
((SELECT id FROM users WHERE username = 'customer_2'), N'Mốc', '2019-10-10',
 (SELECT id FROM breeds WHERE name = N'Mèo Ba Tư'), N'Đực',
 N'Mèo Ba Tư lông trắng, khá trầm tính và ít kêu.', N'active'),

-- 9. Chíp - Mèo Xiêm
((SELECT id FROM users WHERE username = 'customer_1'), N'Chíp', '2020-04-04',
 (SELECT id FROM breeds WHERE name = N'Mèo Xiêm'), N'Cái',
 N'Mèo nhỏ, hoạt bát, thích chơi đồ chơi có tiếng.', N'active'),

-- 10. Bim Bim - Chó Golden
((SELECT id FROM users WHERE username = 'customer_2'), N'Bim Bim', '2019-11-11',
 (SELECT id FROM breeds WHERE name = N'Chó Golden'), N'Đực',
 N'Chó Golden dễ huấn luyện, hiền lành và thích bơi lội.', N'inactive');


-- 6. Services
INSERT INTO services (name, description, price) VALUES
(N'Khám tổng quát', N'Tổng kiểm tra sức khỏe thú cưng.', 100000),
(N'Tiêm phòng', N'Vaccine phòng bệnh.', 150000),
(N'Tẩy giun', N'Tẩy giun định kỳ.', 80000),
(N'Tắm gội', N'Dịch vụ tắm cho thú cưng.', 50000),
(N'Cắt lông', N'Cắt và tạo kiểu lông.', 120000),
(N'Khám nội soi', N'Nội soi kiểm tra chuyên sâu.', 300000),
(N'Phẫu thuật đơn giản', N'Tiểu phẫu cơ bản.', 500000),
(N'Phẫu thuật nâng cao', N'Phẫu thuật chuyên sâu.', 1500000),
(N'Spa thú cưng', N'Thư giãn và chăm sóc.', 200000),
(N'Tư vấn dinh dưỡng', N'Hướng dẫn ăn uống.', 60000);

-- 7. Medicines
INSERT INTO medicines (name, description, price) VALUES
(N'Thuốc nhỏ gáy', N'Tiêu diệt ve rận.', 120000),
(N'Thuốc tẩy giun', N'Tẩy giun cho thú cưng.', 60000),
(N'Amoxicillin', N'Kháng sinh phổ rộng.', 70000),
(N'Vitamin tổng hợp', N'Tăng cường sức khỏe.', 90000),
(N'Thuốc trị nấm', N'Điều trị nấm da.', 85000),
(N'Thuốc nhỏ mắt', N'Giảm viêm mắt.', 40000),
(N'Thuốc chống nôn', N'Hỗ trợ tiêu hóa.', 50000),
(N'Thuốc giảm đau', N'Dùng sau phẫu thuật.', 75000),
(N'Siro ho', N'Giảm ho.', 65000),
(N'Thuốc nhỏ tai', N'Trị viêm tai.', 55000);


-- Insert bảng clinic info
INSERT INTO clinic_info (
  name, address, phone, email, website, working_hours, description, logo, googlemap
)
VALUES (
  N'Phòng Khám Thú Cưng Pet24h',
  N'Đại học FPT Hà Nội, Khu Công nghệ cao Hòa Lạc, Thạch Thất, Hà Nội',
  '02412345678',
  'contact@pet24h.vn',
  'https://www.pet24h.vn',
  N'Thứ 2 - Chủ nhật: 8h00 - 20h00',
  N'Phòng khám thú y Pet24h cung cấp dịch vụ chăm sóc sức khỏe toàn diện cho thú cưng như khám tổng quát, tiêm phòng, phẫu thuật, siêu âm, xét nghiệm, chăm sóc sau điều trị và tư vấn dinh dưỡng. Đội ngũ bác sĩ giàu kinh nghiệm, tận tâm và hệ thống trang thiết bị hiện đại, Pet24h cam kết mang đến sự an tâm cho bạn và thú cưng của mình.',
  '/assets/images/logo.jpg',  -- Thay bằng đường dẫn thực tế đến logo
  'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5062169039634!2d105.52271427379664!3d21.012421688342386!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1748008844264!5m2!1svi!2s'
);

INSERT INTO sliders (title, description, image_url, link, is_active, created_at, updated_at)
VALUES
(N'Khám thú cưng tổng quát', N'Đặt lịch khám sức khoẻ tổng quát cho thú cưng của bạn tại Pet24H.', '/assets/images/banner/banner1.jpg', 'booking.jsp', 1, GETDATE(), GETDATE()),
(N'Tiêm phòng định kỳ', N'Bảo vệ thú cưng khỏi các bệnh nguy hiểm với dịch vụ tiêm phòng định kỳ.', '/assets/images/banner/banner2.jpg', 'service.jsp?id=2', 1, GETDATE(), GETDATE()),
(N'Spa - Tắm & làm đẹp', N'Thú cưng sạch thơm, đáng yêu hơn mỗi ngày cùng dịch vụ Spa.', '/assets/images/banner/banner3.jpg', 'service.jsp?id=9', 1, GETDATE(), GETDATE()),
(N'Ưu đãi tháng 6', N'Giảm 20% dịch vụ khám bệnh cho thú cưng từ 1/6 - 30/6.', '/assets/images/banner/banner4.jpg', NULL, 1, GETDATE(), GETDATE()),
(N'Thú cưng bị lạc?', N'Liên hệ ngay với phòng khám để được hỗ trợ tìm thú cưng.', '/assets/images/banner/banner5.jpg', 'contact.jsp', 1, GETDATE(), GETDATE());


INSERT INTO tags (id, name) VALUES
(NEWID(), N'Khám sức khỏe định kỳ'),
(NEWID(), N'Tiêm phòng thú cưng'),
(NEWID(), N'Chăm sóc sau phẫu thuật'),
(NEWID(), N'Dinh dưỡng cho thú cưng'),
(NEWID(), N'Tẩy giun và phòng ký sinh'),
(NEWID(), N'Vệ sinh và làm đẹp'),
(NEWID(), N'Bệnh lý thường gặp ở chó'),
(NEWID(), N'Bệnh lý thường gặp ở mèo'),
(NEWID(), N'Thuốc và điều trị'),
(NEWID(), N'Tư vấn hành vi thú cưng'),
(NEWID(), N'Hướng dẫn nuôi thú cưng cho người mới'),
(NEWID(), N'Dịch vụ chăm sóc thú cưng tại nhà'),
(NEWID(), N'Vắc xin cần thiết'),
(NEWID(), N'Chăm sóc thú cưng mùa hè'),
(NEWID(), N'Chăm sóc thú cưng mùa đông');