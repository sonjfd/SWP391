-- 1. Create Database
CREATE DATABASE SWP;
GO

USE SWP;
GO

-- 2. Roles
CREATE TABLE roles (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(50) UNIQUE NOT NULL -- e.g. 'customer', 'doctor', 'staff', 'admin', 'nurse'
);



-- 3. Users
CREATE TABLE users (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  username NVARCHAR(100) UNIQUE NOT NULL,
  email NVARCHAR(255) UNIQUE NOT NULL,
  password NVARCHAR(255) NOT NULL,
  full_name NVARCHAR(255),
  phone NVARCHAR(20),
  address NVARCHAR(255),
  avatar NVARCHAR(255) DEFAULT '/assets/images/default_user.png',
  status BIT DEFAULT 1,
  role_id INT NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_users_roles FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- 4. Doctors
CREATE TABLE doctors (
  user_id UNIQUEIDENTIFIER PRIMARY KEY,
  specialty NVARCHAR(255),
  certificates NVARCHAR(MAX),
  qualifications NVARCHAR(255),
  years_of_experience INT CHECK (years_of_experience >= 0),
  biography NVARCHAR(MAX),

  CONSTRAINT FK_doctors_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. Departments (Phòng ban)
CREATE TABLE departments (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(255) NOT NULL UNIQUE,
  description NVARCHAR(MAX)
);

-- 6. Nurses (Y tá)
CREATE TABLE nurses (
  user_id UNIQUEIDENTIFIER PRIMARY KEY,
  department_id INT NOT NULL,

  CONSTRAINT FK_nurses_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT FK_nurses_departments FOREIGN KEY (department_id) REFERENCES departments(id)
);


-- 7. Species (Loài)
CREATE TABLE species (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(100) UNIQUE NOT NULL
);

-- 8. Shift (Ca làm việc)
CREATE TABLE shift (
    shift_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- 9. Weekly schedule template
CREATE TABLE weekly_schedule_template (
    template_id INT PRIMARY KEY IDENTITY(1,1),
    doctor_id UNIQUEIDENTIFIER NOT NULL,
    weekday TINYINT NOT NULL, -- 0=Sun,...,6=Sat
    shift_id INT NOT NULL,

    CONSTRAINT FK_weekly_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
    CONSTRAINT FK_weekly_shift FOREIGN KEY (shift_id) REFERENCES shift(shift_id),
    CONSTRAINT UQ_weekly UNIQUE (doctor_id, weekday, shift_id)
);

-- 10. Doctor schedule (Lịch làm việc thực tế)
CREATE TABLE doctor_schedule (
    schedule_id INT PRIMARY KEY IDENTITY(1,1),
    doctor_id UNIQUEIDENTIFIER NOT NULL,
    work_date DATE NOT NULL,
    shift_id INT NOT NULL,
    is_available BIT DEFAULT 1,

    CONSTRAINT FK_schedule_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
    CONSTRAINT FK_schedule_shift FOREIGN KEY (shift_id) REFERENCES shift(shift_id),
    CONSTRAINT UQ_schedule UNIQUE (doctor_id, work_date, shift_id)
);

-- 11. Breeds (Giống loài)
CREATE TABLE breeds (
  id INT PRIMARY KEY IDENTITY(1,1),
  species_id INT NOT NULL,
  name NVARCHAR(100) NOT NULL,
  CONSTRAINT FK_breeds_species FOREIGN KEY (species_id) REFERENCES species(id)
);

-- 12. Pets (Thú cưng)
CREATE TABLE pets (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  pet_code NVARCHAR(15) UNIQUE,
  owner_id UNIQUEIDENTIFIER NOT NULL,
  name NVARCHAR(100) NOT NULL,
  birth_date DATE,
  breeds_id INT NOT NULL,
  gender NVARCHAR(20),
  avatar NVARCHAR(255) DEFAULT '/assets/images/default_pet.png',
  description NVARCHAR(MAX) NULL,
  status NVARCHAR(50) DEFAULT 'active',
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_pets_users FOREIGN KEY (owner_id) REFERENCES users(id),
  CONSTRAINT FK_pets_breeds FOREIGN KEY (breeds_id) REFERENCES breeds(id)
);

-- 13. Appointments (Cuộc hẹn)
CREATE TABLE appointments (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  customer_id UNIQUEIDENTIFIER NOT NULL,
  pet_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  appointment_time DATETIME NOT NULL,
  start_time TIME,
  end_time TIME,
  status NVARCHAR(50) DEFAULT 'pending' CHECK (status IN ('completed', 'canceled', 'pending')),
checkin_status NVARCHAR(20) DEFAULT 'noshow' CHECK (checkin_status IN ('noshow', 'checkin')),
  payment_status NVARCHAR(50) DEFAULT 'unpaid' CHECK (payment_status IN ('unpaid', 'paid')),
  payment_method NVARCHAR(50) CHECK (payment_method IN ('cash', 'online')),
  notes NVARCHAR(MAX),
  price DECIMAL(10,2),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_appointments_customer FOREIGN KEY (customer_id) REFERENCES users(id),
  CONSTRAINT FK_appointments_pet FOREIGN KEY (pet_id) REFERENCES pets(id),
  CONSTRAINT FK_appointments_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id)
);

-- 11. Services (Dịch vụ)
CREATE TABLE services (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  department_id INT NOT NULL,
  name NVARCHAR(255) NOT NULL,
  description NVARCHAR(MAX),
  price DECIMAL(10, 2) NOT NULL,
  status BIT DEFAULT 1,
  CONSTRAINT FK_department_services_department FOREIGN KEY (department_id) REFERENCES departments(id)
);



-- 14. Appointment Departments (Phòng ban chỉ định cho cuộc hẹn)
CREATE TABLE appointment_services (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  service_id UNIQUEIDENTIFIER NOT NULL, -- Dịch vụ trong phòng ban
  price DECIMAL(10, 2) NOT NULL, -- Giá dịch vụ tại thời điểm thực hiện
  status NVARCHAR(50) DEFAULT 'pending', -- Trạng thái dịch vụ (pending, completed, etc.)
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_appointment_services_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id),
  CONSTRAINT FK_appointment_services_department_service FOREIGN KEY (service_id) REFERENCES services(id)
);


-- 15. Nurse Results (Kết quả cập nhật bởi y tá)
CREATE TABLE nurse_specialization_results (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  service_id UNIQUEIDENTIFIER NOT NULL, -- Dịch vụ trong phòng ban
  nurse_id UNIQUEIDENTIFIER NOT NULL, 
  created_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_specialization_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id),
  CONSTRAINT FK_specialization_department_service FOREIGN KEY (service_id) REFERENCES services(id),
  CONSTRAINT FK_specialization_doctor FOREIGN KEY (nurse_id) REFERENCES doctors(user_id)
);
CREATE TABLE uploaded_files (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  result_id UNIQUEIDENTIFIER NOT NULL,  -- Liên kết với kết quả của nurse_specialization_results
  file_url NVARCHAR(500) NOT NULL,
  file_type NVARCHAR(50),
  uploaded_at DATETIME DEFAULT GETDATE(),
  
  CONSTRAINT FK_uploaded_files_result FOREIGN KEY (result_id) REFERENCES nurse_specialization_results(id) ON DELETE CASCADE
);







-- 18. Medical Records (Hồ sơ y tế)
CREATE TABLE medical_records (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  pet_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  appointment_id UNIQUEIDENTIFIER NULL,
  diagnosis NVARCHAR(MAX),
  treatment NVARCHAR(MAX),
  re_exam_date DATE,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_medical_pet FOREIGN KEY (pet_id) REFERENCES pets(id),
  CONSTRAINT FK_medical_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
  CONSTRAINT FK_medical_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

CREATE TABLE medical_record_files (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    medical_record_id UNIQUEIDENTIFIER NOT NULL,
    file_name NVARCHAR(255) NOT NULL,
    file_url NVARCHAR(500) NOT NULL,
    uploaded_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_medicalrecordfile_medicalrecord FOREIGN KEY (medical_record_id) REFERENCES medical_records(id) ON DELETE CASCADE
);

-- 19. Medicines (Thuốc)
CREATE TABLE medicines (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  description NVARCHAR(MAX),
  price DECIMAL(10, 2) NOT NULL,
  status BIT DEFAULT 1
);

-- 20. Prescribed Medicines (Thuốc kê đơn)
CREATE TABLE prescribed_medicines (
  medical_record_id UNIQUEIDENTIFIER NOT NULL,
  medicine_id UNIQUEIDENTIFIER NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  dosage NVARCHAR(255),
  duration NVARCHAR(255),
  usage_instructions NVARCHAR(MAX),

  CONSTRAINT PK_prescribed_medicines PRIMARY KEY (medical_record_id, medicine_id),

  CONSTRAINT FK_prescribed_medical_record FOREIGN KEY (medical_record_id) REFERENCES medical_records(id) ON DELETE CASCADE,
  CONSTRAINT FK_prescribed_medicine FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);

-- 22. Invoices (Hóa đơn)
CREATE TABLE invoices (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL CHECK(total_amount >= 0),
  payment_status NVARCHAR(50) DEFAULT 'pending',
  payment_method NVARCHAR(50),
  paid_at DATETIME NULL,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_invoice_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

-- 21. Invoice Medicines (Thuốc trong hóa đơn)
CREATE TABLE invoice_medicines (
  invoice_id UNIQUEIDENTIFIER NOT NULL,
  medicine_id UNIQUEIDENTIFIER NOT NULL,
  quantity INT NOT NULL CHECK(quantity > 0),
  price DECIMAL(10, 2) NOT NULL CHECK(price >= 0),

  CONSTRAINT PK_invoice_medicines PRIMARY KEY (invoice_id, medicine_id),

  CONSTRAINT FK_invoice_med FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE,
  CONSTRAINT FK_invoice_medicine FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);





-- 19. Sliders (Trang chủ/banner)
CREATE TABLE sliders (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  title NVARCHAR(255),
  description NVARCHAR(MAX),
  image_url NVARCHAR(255) NOT NULL,
  link NVARCHAR(255),
  is_active BIT DEFAULT 1,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE()
);

-- 20. Clinic Info (Thông tin phòng khám)
CREATE TABLE clinic_info (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  address NVARCHAR(500),
  phone NVARCHAR(20),
  email NVARCHAR(255),
  website NVARCHAR(255),
  working_hours NVARCHAR(255),  -- VD: "Thứ 2 - Thứ 6: 8h00 - 17h00"
  description NVARCHAR(MAX),
  logo NVARCHAR(255), -- Trường lưu đường dẫn logo
  googlemap NVARCHAR(MAX), -- URL hoặc mã nhúng Google Maps
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE()
);



-- 22. Contacts (Liên hệ)
CREATE TABLE contacts (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  email NVARCHAR(255) NOT NULL,
  phone NVARCHAR(20),
  message NVARCHAR(MAX) NOT NULL,
  status NVARCHAR(50) DEFAULT 'pending',
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE()
);


--- BẢNG BLOG
CREATE TABLE blogs (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  title NVARCHAR(255) NOT NULL,
  content NVARCHAR(MAX) NOT NULL,
  author_id UNIQUEIDENTIFIER NOT NULL, -- ID của nhân viên tạo blog
  image NVARCHAR(500),                 -- Đường dẫn ảnh đại diện blog
  status NVARCHAR(50) DEFAULT 'draft', -- 'draft', 'published'
  published_at DATETIME,               -- Ngày xuất bản
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  reactions_count INT DEFAULT 0,
  comments_count INT DEFAULT 0
);
--- BẢNG TAG (QH M-T-M với blogs)
CREATE TABLE tags (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE blog_tags (
  blog_id UNIQUEIDENTIFIER NOT NULL,
  tag_id UNIQUEIDENTIFIER NOT NULL,
  PRIMARY KEY (blog_id, tag_id),
  FOREIGN KEY (blog_id) REFERENCES blogs(id),
  FOREIGN KEY (tag_id) REFERENCES tags(id)
);



-- Danh mục sản phẩm
CREATE TABLE categories (
  category_id INT PRIMARY KEY IDENTITY(1,1),
  category_name NVARCHAR(50) UNIQUE NOT NULL,
  description TEXT
);

-- Nhà cung cấp
CREATE TABLE suppliers (
  supplier_id INT PRIMARY KEY IDENTITY(1,1),
  supplier_name NVARCHAR(100) NOT NULL,
  contact_name NVARCHAR(100),
  phone NVARCHAR(20),
  email NVARCHAR(100),
  address TEXT,
  created_at DATETIME DEFAULT GETDATE()
);

-- Sản phẩm
CREATE TABLE products (
  product_id INT PRIMARY KEY IDENTITY(1,1),
  category_id INT NOT NULL,
  supplier_id INT NOT NULL,
  product_name NVARCHAR(100) NOT NULL,
  description TEXT,
  image NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_products_categories FOREIGN KEY (category_id) REFERENCES categories(category_id),
  CONSTRAINT FK_products_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Biến thể sản phẩm (ví dụ: size, gói nhỏ/lớn)
CREATE TABLE product_variants (
  product_variant_id INT PRIMARY KEY IDENTITY(1,1),
  product_id INT NOT NULL,
  variant_name NVARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock_quantity INT NOT NULL,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_variants_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Trọng lượng cho biến thể
CREATE TABLE product_variant_weights (
  weight_id INT PRIMARY KEY IDENTITY(1,1),
  product_variant_id INT UNIQUE NOT NULL,
  weight DECIMAL(10,2),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_weights_variants FOREIGN KEY (product_variant_id) REFERENCES product_variants(product_variant_id)
);

-- Hương vị cho biến thể
CREATE TABLE product_variant_flavors (
  flavor_id INT PRIMARY KEY IDENTITY(1,1),
  product_variant_id INT UNIQUE NOT NULL,
  flavor NVARCHAR(50),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_flavors_variants FOREIGN KEY (product_variant_id) REFERENCES product_variants(product_variant_id)
);


-- HOÁ ĐƠN BÁN HÀNG TẠI QUẦY (POS = Point Of Sale)
CREATE TABLE pos_invoices (
  pos_invoice_id INT PRIMARY KEY IDENTITY(1,1),
  customer_id UNIQUEIDENTIFIER NOT NULL, -- users.id (role = 'customer')
  staff_id UNIQUEIDENTIFIER NOT NULL,    -- users.id (role = 'staff')
  invoice_date DATETIME DEFAULT GETDATE(),
  total_amount DECIMAL(10,2) NOT NULL,
  payment_status NVARCHAR(20) DEFAULT 'Unpaid', -- 'Paid' | 'Unpaid'
  notes NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_pos_invoice_customer FOREIGN KEY (customer_id) REFERENCES users(id),
  CONSTRAINT FK_pos_invoice_staff FOREIGN KEY (staff_id) REFERENCES users(id),
  CONSTRAINT chk_pos_payment_status CHECK (payment_status IN ('Paid', 'Unpaid'))
);

-- CHI TIẾT HOÁ ĐƠN BÁN HÀNG
CREATE TABLE pos_invoice_items (
  pos_invoice_item_id INT PRIMARY KEY IDENTITY(1,1),
  pos_invoice_id INT NOT NULL,
  product_variant_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  total_price AS (quantity * unit_price) PERSISTED,

  CONSTRAINT FK_pos_items_invoice FOREIGN KEY (pos_invoice_id) REFERENCES pos_invoices(pos_invoice_id),
  CONSTRAINT FK_pos_items_variant FOREIGN KEY (product_variant_id) REFERENCES product_variants(product_variant_id)
);

