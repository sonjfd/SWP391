-- 1. Create Database
CREATE DATABASE SWP;
GO

USE SWP;
GO

-- 2. Roles
CREATE TABLE roles (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(50) UNIQUE NOT NULL -- e.g. 'customer', 'doctor', 'staff', 'admin'
);
-- 1.CUSTOMER
-- 2.STAFF
-- 3.DOCTOR
-- 4.ADMIN

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
  qualifications NVARCHAR(255),         -- Degrees, certifications
  years_of_experience INT CHECK (years_of_experience >= 0),
  biography NVARCHAR(MAX),              -- Short description of the doctor
  
  CONSTRAINT FK_doctors_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. Species loài : (Mèo , chó , thỏ)
CREATE TABLE species (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(100) UNIQUE NOT NULL
);

-- 6. Shift (Ca làm việc)
CREATE TABLE shift (
    shift_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) NOT NULL,        -- tên ca (vd: Ca sáng, Ca chiều)
    start_time TIME NOT NULL,           -- giờ bắt đầu ca
    end_time TIME NOT NULL              -- giờ kết thúc ca
);

-- 7. Weekly schedule template (Lịch làm việc mẫu theo thứ)
CREATE TABLE weekly_schedule_template (
    template_id INT PRIMARY KEY IDENTITY(1,1),
    doctor_id UNIQUEIDENTIFIER NOT NULL,
    weekday TINYINT NOT NULL, -- 0=Chủ nhật, 1=Thứ 2, ..., 6=Thứ 7
    shift_id INT NOT NULL,
    CONSTRAINT FK_weekly_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
    CONSTRAINT FK_weekly_shift FOREIGN KEY (shift_id) REFERENCES shift(shift_id),
    CONSTRAINT UQ_weekly UNIQUE (doctor_id, weekday, shift_id) -- tránh lặp ca trong cùng ngày
);

-- 8. Doctor schedule (Lịch làm việc thực tế)
CREATE TABLE doctor_schedule (
    schedule_id INT PRIMARY KEY IDENTITY(1,1),
    doctor_id UNIQUEIDENTIFIER NOT NULL,
    work_date DATE NOT NULL,
    shift_id INT NOT NULL,
    is_available BIT DEFAULT 1, -- 1: làm việc, 0: nghỉ
    CONSTRAINT FK_schedule_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
    CONSTRAINT FK_schedule_shift FOREIGN KEY (shift_id) REFERENCES shift(shift_id),
    CONSTRAINT UQ_schedule UNIQUE (doctor_id, work_date, shift_id) -- tránh trùng ca trên cùng ngày
);

-- 9. Breeds (Giống loài)
CREATE TABLE breeds (
  id INT PRIMARY KEY IDENTITY(1,1),
  species_id INT NOT NULL,
  name NVARCHAR(100) NOT NULL,
  CONSTRAINT FK_breeds_species FOREIGN KEY (species_id) REFERENCES species(id)
);

-- 10. Pets (Thú cưng)
CREATE TABLE pets (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  owner_id UNIQUEIDENTIFIER NOT NULL,
  name NVARCHAR(100) NOT NULL,
  birth_date DATE,
  breeds_id INT NOT NULL,
  gender NVARCHAR(20),
  avatar NVARCHAR(255) DEFAULT '/assets/images/default_pet.png',
  description NVARCHAR(MAX) NULL,
  status NVARCHAR(50) DEFAULT 'active', -- hoặc 'active', 'inactive', 'lost'...
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_pets_users FOREIGN KEY (owner_id) REFERENCES users(id),
  CONSTRAINT FK_pets_breeds FOREIGN KEY (breeds_id) REFERENCES breeds(id)
);

-- 11. Services (Dịch vụ)
CREATE TABLE services (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  description NVARCHAR(MAX),
  price DECIMAL(10, 2) NOT NULL,
  status BIT DEFAULT 1
);

-- 12. Medicines (Thuốc)
CREATE TABLE medicines (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  description NVARCHAR(MAX),
  price DECIMAL(10, 2) NOT NULL,
  status BIT DEFAULT 1
);

-- 13. Appointments (Cuộc hẹn)
CREATE TABLE appointments (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  customer_id UNIQUEIDENTIFIER NOT NULL,
  pet_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  appointment_time DATETIME NOT NULL, 
  start_time DATETIME, 
  end_time DATETIME,  
  status NVARCHAR(50) DEFAULT 'completed' CHECK (status IN ('completed', 'canceled')),
   payment_status NVARCHAR(50) DEFAULT 'unpaid' CHECK (payment_status IN ('unpaid', 'paid')),
  payment_method NVARCHAR(50) CHECK (payment_method IN ('cash', 'online')),
  notes NVARCHAR(MAX),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  CONSTRAINT FK_appointments_customer FOREIGN KEY (customer_id) REFERENCES users(id),
  CONSTRAINT FK_appointments_pet FOREIGN KEY (pet_id) REFERENCES pets(id),
  CONSTRAINT FK_appointments_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id)
);


-- 14. Appointment Services (Dịch vụ của cuộc hẹn)
CREATE TABLE appointment_services (
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  service_id UNIQUEIDENTIFIER NOT NULL,

  CONSTRAINT PK_appointment_services PRIMARY KEY (appointment_id, service_id),
  CONSTRAINT FK_app_services_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE,
  CONSTRAINT FK_app_services_service FOREIGN KEY (service_id) REFERENCES services(id)
);

-- 15. Medical Records (Hồ sơ y tế)
CREATE TABLE medical_records (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  pet_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  appointment_id UNIQUEIDENTIFIER NULL,
  diagnosis NVARCHAR(MAX),
  treatment NVARCHAR(MAX),
  re_exam_date DATE,
  attachments NVARCHAR(MAX),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_medical_pet FOREIGN KEY (pet_id) REFERENCES pets(id),
  CONSTRAINT FK_medical_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
  CONSTRAINT FK_medical_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

-- 16. Prescribed Medicines (Thuốc kê đơn)
CREATE TABLE prescribed_medicines (
  medical_record_id UNIQUEIDENTIFIER NOT NULL,
  medicine_id UNIQUEIDENTIFIER NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  dosage NVARCHAR(255), -- Liều lượng (vd: "1 viên / lần x 2 lần / ngày")
  duration NVARCHAR(255), -- Thời gian dùng (vd: "5 ngày")
  usage_instructions NVARCHAR(MAX), -- Hướng dẫn thêm, vd: uống sau ăn

  CONSTRAINT PK_prescribed_medicines PRIMARY KEY (medical_record_id, medicine_id),

  CONSTRAINT FK_prescribed_medical_record FOREIGN KEY (medical_record_id) REFERENCES medical_records(id) ON DELETE CASCADE,
  CONSTRAINT FK_prescribed_medicine FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);

-- 17. Invoices (Hóa đơn)
CREATE TABLE invoices (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL CHECK(total_amount >= 0),
  payment_status NVARCHAR(50) DEFAULT 'pending',
  payment_method NVARCHAR(50),
  paid_at DATETIME NULL,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_invoices_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

-- 18. Invoice Medicines (Thuốc trong hóa đơn)
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


