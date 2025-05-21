
-- 1. Bảng roles: Vai trò người dùng
INSERT INTO roles (id, name) VALUES
(1, 'admin'),
(2, 'customer'),
(3, 'doctor'),
(4, 'staff');

-- 2. Users
INSERT INTO users (username, email, password, full_name, phone, address, role_id)
VALUES
('admin_1', 'admin1@example.com', 'hashed_pw', N'Nguyễn Văn A', '0911111111', N'123 Lê Lợi, Q.1', 1),
('staff_1', 'staff1@example.com', 'hashed_pw', N'Trần Thị B', '0922222222', N'456 Nguyễn Trãi, Q.5', 2),
('doctor_1', 'doctor1@example.com', 'hashed_pw', N'Phạm Văn C', '0933333333', N'789 CMT8, Q.3', 3),
('customer_1', 'cust1@example.com', 'hashed_pw', N'Lê Thị D', '0944444444', N'321 Hai Bà Trưng, Q.3', 4),
('admin_2', 'admin2@example.com', 'hashed_pw', N'Huỳnh Văn E', '0955555555', N'12 Lý Thường Kiệt, Q.10', 1),
('staff_2', 'staff2@example.com', 'hashed_pw', N'Đỗ Thị F', '0966666666', N'34 Pasteur, Q.1', 2),
('doctor_2', 'doctor2@example.com', 'hashed_pw', N'Võ Văn G', '0977777777', N'78 Điện Biên Phủ, Q.BT', 3),
('customer_2', 'cust2@example.com', 'hashed_pw', N'Ngô Thị H', '0988888888', N'90 Hoàng Diệu, Q.4', 4),
('admin_3', 'admin3@example.com', 'hashed_pw', N'Hồ Văn I', '0999999999', N'101 Phạm Ngũ Lão, Q.1', 1),
('staff_3', 'staff3@example.com', 'hashed_pw', N'Bùi Thị J', '0900000000', N'67 Nguyễn Văn Cừ, Q.5', 2);

-- 3. Species
INSERT INTO species (name)
VALUES (N'Mèo'), (N'Chó'), (N'Thỏ');

-- 4. Doctors (tham chiếu users.role_id = 3)
INSERT INTO doctors (user_id, specialty, certificates, qualifications, years_of_experience, biography)
VALUES
((SELECT id FROM users WHERE username = 'doctor_1'), N'Thú y tổng quát', N'Chứng chỉ A', N'Bác sĩ thú y', 10, N'10 năm kinh nghiệm điều trị chó mèo.'),
((SELECT id FROM users WHERE username = 'doctor_2'), N'Nội khoa thú cưng', N'Chứng chỉ B', N'Bác sĩ nội trú', 7, N'Chuyên nội khoa động vật nhỏ.');

-- 5. Pets (dùng id động của customer và species)
INSERT INTO pets (owner_id, name, birth_date, species_id, gender) VALUES
((SELECT id FROM users WHERE username = 'customer_1'), N'Miu', '2021-01-01', (SELECT id FROM species WHERE name = N'Mèo'), N'Cái'),
((SELECT id FROM users WHERE username = 'customer_2'), N'Bun', '2020-05-05', (SELECT id FROM species WHERE name = N'Thỏ'), N'Đực'),
((SELECT id FROM users WHERE username = 'customer_1'), N'Lu', '2019-03-03', (SELECT id FROM species WHERE name = N'Chó'), N'Đực'),
((SELECT id FROM users WHERE username = 'customer_2'), N'Đốm', '2022-07-07', (SELECT id FROM species WHERE name = N'Chó'), N'Đực'),
((SELECT id FROM users WHERE username = 'customer_1'), N'Momo', '2020-06-06', (SELECT id FROM species WHERE name = N'Mèo'), N'Cái'),
((SELECT id FROM users WHERE username = 'customer_2'), N'Susu', '2020-09-09', (SELECT id FROM species WHERE name = N'Mèo'), N'Cái'),
((SELECT id FROM users WHERE username = 'customer_1'), N'Ken', '2018-08-08', (SELECT id FROM species WHERE name = N'Mèo'), N'Đực'),
((SELECT id FROM users WHERE username = 'customer_2'), N'Mốc', '2019-10-10', (SELECT id FROM species WHERE name = N'Mèo'), N'Đực'),
((SELECT id FROM users WHERE username = 'customer_1'), N'Chíp', '2020-04-04', (SELECT id FROM species WHERE name = N'Mèo'), N'Cái'),
((SELECT id FROM users WHERE username = 'customer_2'), N'Bim Bim', '2019-11-11', (SELECT id FROM species WHERE name = N'Chó'), N'Đực');

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


