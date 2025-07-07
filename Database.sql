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
  avatar NVARCHAR(255) DEFAULT '/SWP391/image-loader/default_user.png',
  status   TINYINT NOT NULL DEFAULT 1,
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
  name NVARCHAR(100) UNIQUE NOT NULL,
  image_url NVARCHAR(255)
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
  avatar NVARCHAR(255) DEFAULT '/SWP391/image-loader/default_pet.png' ,
  description NVARCHAR(MAX) NULL,
  status NVARCHAR(50) DEFAULT 'active',
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  isDelete BIT DEFAULT 0,
  CONSTRAINT FK_pets_users FOREIGN KEY (owner_id) REFERENCES users(id),
  CONSTRAINT FK_pets_breeds FOREIGN KEY (breeds_id) REFERENCES breeds(id)
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


-- 13. Appointments (Cuộc hẹn)
CREATE TABLE appointments (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  customer_id UNIQUEIDENTIFIER NOT NULL,
  pet_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  appointment_time DATETIME NOT NULL,
  start_time TIME,
  end_time TIME,
 status NVARCHAR(50) DEFAULT 'booked' CHECK (status IN ('booked','completed','cancel_requested', 'canceled','pending')
  ),
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


CREATE TABLE examination_prices (
    id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    price DECIMAL(10, 2) NOT NULL
);

-- 11. Services (Dịch vụ)
CREATE TABLE services (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  department_id INT NOT NULL,
  name NVARCHAR(255) UNIQUE NOT NULL,
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

CREATE TABLE nurse_specialization_results (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  service_id UNIQUEIDENTIFIER NOT NULL, -- Dịch vụ trong phòng ban
  nurse_id UNIQUEIDENTIFIER NOT NULL, -- Bác sĩ thực hiện dịch vụ
  created_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_specialization_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id),
  CONSTRAINT FK_specialization_department_service FOREIGN KEY (service_id) REFERENCES services(id),
  CONSTRAINT FK_specialization_nurse FOREIGN KEY (nurse_id) REFERENCES nurses(user_id)
);
CREATE TABLE uploaded_files (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  result_id UNIQUEIDENTIFIER NOT NULL,  -- Liên kết với kết quả của nurse_specialization_results
  file_url NVARCHAR(500) NOT NULL,
  file_name NVARCHAR(500) NOT NULL,
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
  name NVARCHAR(255) Unique  NOT NULL,
  description NVARCHAR(MAX),
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

CREATE TABLE [dbo].[tokenForgetPassword](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[token] [varchar](255) NOT NULL,
	[expiryTime] [datetime] NOT NULL,
	[isUsed] [bit] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tokenForgetPassword]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([id])
GO

CREATE TABLE ratings (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  customer_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  satisfaction_level INT CHECK (satisfaction_level BETWEEN 1 AND 5),
  comment NVARCHAR(MAX),
  status NVARCHAR(50) DEFAULT 'pending' CHECK (status IN ('posted', 'hide', 'pending')),
  created_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_rating_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE,
  CONSTRAINT FK_rating_customer FOREIGN KEY (customer_id) REFERENCES users(id),
  CONSTRAINT FK_rating_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
  CONSTRAINT UQ_rating_appointment UNIQUE (appointment_id) -- mỗi appointment chỉ được đánh giá 1 lần
);


CREATE TABLE [dbo].[ChatHistory] (
    [chat_id] INT IDENTITY(1,1) PRIMARY KEY,
    [session_id] NVARCHAR(100),            
    [user_id] UNIQUEIDENTIFIER NULL,       
    [sender_type] NVARCHAR(10) NOT NULL,   
    [message_text] NVARCHAR(MAX),
    [created_at] DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_ChatHistory_User FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE appointment_symptoms (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  symptom NVARCHAR(255) NOT NULL,     -- Nhập tay
  diagnosis NVARCHAR(255) NOT NULL,
  note NVARCHAR(MAX),
  created_at DATETIME DEFAULT GETDATE(),

  FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);



-- Danh mục sản phẩm
CREATE TABLE categories (
  category_id INT PRIMARY KEY IDENTITY(1,1),
  category_name NVARCHAR(50) UNIQUE NOT NULL,
  description NVARCHAR(100),
  status BIT DEFAULT 1
);

-- Trọng lượng biến thể
CREATE TABLE product_variant_weights (
  weight_id INT PRIMARY KEY IDENTITY(1,1),
  weight DECIMAL(10,2) NOT NULL,
  status BIT DEFAULT 1
);

-- Hương vị biến thể
CREATE TABLE product_variant_flavors (
  flavor_id INT PRIMARY KEY IDENTITY(1,1),
  flavor NVARCHAR(50) NOT NULL,
  status BIT DEFAULT 1
);

-- Sản phẩm
CREATE TABLE products (
  product_id INT PRIMARY KEY IDENTITY(1,1),
  category_id INT NOT NULL,
  product_name NVARCHAR(100) NOT NULL,
  description NVARCHAR(255),
  status BIT DEFAULT 1,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  CONSTRAINT FK_products_categories FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Biến thể sản phẩm (bỏ variant_name, dùng category_name để hiển thị)
CREATE TABLE product_variants (
  product_variant_id INT PRIMARY KEY IDENTITY(1,1),
  product_id INT NOT NULL,
  weight_id INT NOT NULL,
  flavor_id INT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock_quantity INT NOT NULL,
  status BIT DEFAULT 1,
  image NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  -- Khóa ngoại
  CONSTRAINT FK_variants_products FOREIGN KEY (product_id) REFERENCES products(product_id),
  CONSTRAINT FK_variants_weights FOREIGN KEY (weight_id) REFERENCES product_variant_weights(weight_id),
  CONSTRAINT FK_variants_flavors FOREIGN KEY (flavor_id) REFERENCES product_variant_flavors(flavor_id),

  -- Ràng buộc: mỗi sản phẩm chỉ có 1 biến thể theo weight + flavor
  CONSTRAINT unique_product_variant UNIQUE (product_id, weight_id, flavor_id)
);

CREATE TABLE sales_invoices (
  invoice_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  staff_id UNIQUEIDENTIFIER  ,
  total_amount DECIMAL(10, 2) NOT NULL,
  payment_method NVARCHAR(50) CHECK (payment_method IN ('cash', 'online')) NOT NULL,
  payment_status NVARCHAR(20) DEFAULT 'unpaid' CHECK (payment_status IN ('unpaid', 'paid')),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  CONSTRAINT FK_sales_invoices_staff FOREIGN KEY (staff_id) REFERENCES users(id)
);


-- 7. Chi tiết hóa đơn
CREATE TABLE sales_invoice_items (
  id INT PRIMARY KEY IDENTITY(1,1),
  invoice_id UNIQUEIDENTIFIER NOT NULL,
  product_variant_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  price DECIMAL(10, 2) NOT NULL,
  CONSTRAINT FK_invoice_items_invoice FOREIGN KEY (invoice_id) REFERENCES sales_invoices(invoice_id) ON DELETE CASCADE,
  CONSTRAINT FK_invoice_items_variant FOREIGN KEY (product_variant_id) REFERENCES product_variants(product_variant_id)
);


CREATE TABLE cart (
    cart_id INT PRIMARY KEY IDENTITY(1,1),
    user_id UNIQUEIDENTIFIER NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_cart_user FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE cart_items (
    id INT PRIMARY KEY IDENTITY(1,1),
    cart_id INT NOT NULL,
    product_variant_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    CONSTRAINT FK_cart_items_cart FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE,
    CONSTRAINT FK_cart_items_variant FOREIGN KEY (product_variant_id) REFERENCES product_variants(product_variant_id)
);


CREATE TABLE conversations (
    conversation_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    customer_id UNIQUEIDENTIFIER NOT NULL,
    staff_id UNIQUEIDENTIFIER NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    last_message_time DATETIME,

    CONSTRAINT FK_conversations_customer FOREIGN KEY (customer_id) REFERENCES users(id),
    CONSTRAINT FK_conversations_staff FOREIGN KEY (staff_id) REFERENCES users(id)
);

CREATE TABLE messages (
    message_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    conversation_id UNIQUEIDENTIFIER NOT NULL,
    sender_id UNIQUEIDENTIFIER NOT NULL,
    content NVARCHAR(MAX),
    sent_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_messages_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id),
    CONSTRAINT FK_messages_sender FOREIGN KEY (sender_id) REFERENCES users(id)
);
CREATE TABLE consulting_staff (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    staff_id UNIQUEIDENTIFIER NOT NULL,
    assigned_at DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_consulting_staff_user FOREIGN KEY (staff_id) REFERENCES users(id)
);