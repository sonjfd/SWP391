-- Create Database
CREATE DATABASE SWP;
GO

USE SWP;
GO

-- 1. Roles
CREATE TABLE roles (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(50) UNIQUE NOT NULL -- e.g. 'customer', 'doctor', 'staff', 'admin'
);
-- 1.CUSTOMER
-- 2.STAFF
-- 3.DOCTOR
-- 4.ADMIN

-- 2. Users
CREATE TABLE users (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  username NVARCHAR(100) UNIQUE NOT NULL,
  email NVARCHAR(255) UNIQUE NOT NULL,
  password NVARCHAR(255) NOT NULL,
  full_name NVARCHAR(255),
  phone NVARCHAR(20),
  address NVARCHAR(255),
  avatar NVARCHAR(255) DEFAULT '/assets/images/default_user.png',
  role_id INT NOT NULL DEFAULT 1,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_users_roles FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE doctors (
  user_id UNIQUEIDENTIFIER PRIMARY KEY,
  specialty NVARCHAR(255),
  certificates NVARCHAR(MAX), 
  qualifications NVARCHAR(255),         -- Degrees, certifications
  years_of_experience INT CHECK (years_of_experience >= 0),
  biography NVARCHAR(MAX),              -- Short description of the doctor
  status BIT DEFAULT 1,     -- Whether to show on public page
  CONSTRAINT FK_doctor_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Species loài : (Mèo , chó , thỏ)
CREATE TABLE species (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(100) UNIQUE NOT NULL
);

--Lich lam viec cua bac si
CREATE TABLE work_schedules (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  work_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE()
  CONSTRAINT FK_schedule_doctor FOREIGN KEY (doctor_id) REFERENCES users(id)
);

-- 4. Pets
CREATE TABLE pets (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  owner_id UNIQUEIDENTIFIER NOT NULL,
  name NVARCHAR(100) NOT NULL,
  birth_date DATE,
  species_id INT NOT NULL,
  gender NVARCHAR(20),
  avatar NVARCHAR(255) DEFAULT '/assets/images/default_pet.png',
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_pets_users FOREIGN KEY (owner_id) REFERENCES users(id),
  CONSTRAINT FK_pets_breeds FOREIGN KEY (species_id) REFERENCES species(id)
);

-- 6. Services
CREATE TABLE services (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  description NVARCHAR(MAX),
  price DECIMAL(10, 2) NOT NULL
);

-- 7. Medicines
CREATE TABLE medicines (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  description NVARCHAR(MAX),
  price DECIMAL(10, 2) NOT NULL
);

-- 8. Appointments
CREATE TABLE appointments (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  customer_id UNIQUEIDENTIFIER NOT NULL,
  pet_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  appointment_time DATETIME NOT NULL,
  status NVARCHAR(50) DEFAULT 'registered', --- registered , confirmed , completed , canceled
  notes NVARCHAR(MAX),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_appointments_customer FOREIGN KEY (customer_id) REFERENCES users(id),
  CONSTRAINT FK_appointments_pet FOREIGN KEY (pet_id) REFERENCES pets(id),
    CONSTRAINT FK_appointments_doctor FOREIGN KEY (doctor_id) REFERENCES users(id)
);


-- 9. Appointment Services
CREATE TABLE appointment_services (
  appointment_id UNIQUEIDENTIFIER NOT NULL,
  service_id UNIQUEIDENTIFIER NOT NULL,

  PRIMARY KEY (appointment_id, service_id),
  CONSTRAINT FK_app_services_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE,
  CONSTRAINT FK_app_services_service FOREIGN KEY (service_id) REFERENCES services(id)
);

-- 10. Medical Records
CREATE TABLE medical_records (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  pet_id UNIQUEIDENTIFIER NOT NULL,
  doctor_id UNIQUEIDENTIFIER NOT NULL,
  appointment_id UNIQUEIDENTIFIER,
  diagnosis NVARCHAR(MAX),
  treatment NVARCHAR(MAX),
  re_exam_date DATE,
  attachments NVARCHAR(MAX),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_medical_pet FOREIGN KEY (pet_id) REFERENCES pets(id),
  CONSTRAINT FK_medical_doctor FOREIGN KEY (doctor_id) REFERENCES users(id),
  CONSTRAINT FK_medical_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

-- Thuốc chuẩn đoán
CREATE TABLE prescribed_medicines (
  medical_record_id UNIQUEIDENTIFIER NOT NULL,
  medicine_id UNIQUEIDENTIFIER NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  dosage NVARCHAR(255), -- Liều lượng (ví dụ: "1 viên / lần x 2 lần / ngày")
  duration NVARCHAR(255), -- Thời gian dùng (ví dụ: "5 ngày")
  usage_instructions NVARCHAR(MAX), -- Hướng dẫn thêm, ví dụ: uống sau ăn

  PRIMARY KEY (medical_record_id, medicine_id),

  CONSTRAINT FK_prescribed_medical_record FOREIGN KEY (medical_record_id) REFERENCES medical_records(id) ON DELETE CASCADE,
  CONSTRAINT FK_prescribed_medicine FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);


-- 11. Invoices
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

-- 12. Invoice Medicines
CREATE TABLE invoice_medicines (
  invoice_id UNIQUEIDENTIFIER NOT NULL,
  medicine_id UNIQUEIDENTIFIER NOT NULL,
  quantity INT NOT NULL CHECK(quantity > 0),
  price DECIMAL(10, 2) NOT NULL CHECK(price >= 0),

  PRIMARY KEY (invoice_id, medicine_id),
  CONSTRAINT FK_invoice_med FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE,
  CONSTRAINT FK_invoice_medicine FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);



-- 12.1. Sliders (for homepage/banner management)
CREATE TABLE sliders (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  title NVARCHAR(255),
  description NVARCHAR(MAX),
  image_url NVARCHAR(255) NOT NULL,
  link NVARCHAR(255),
  is_active BIT DEFAULT 1,
);

--12.2 Dia chi phong kham

CREATE TABLE clinic_info (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,
  address NVARCHAR(500),
  phone NVARCHAR(20),
  email NVARCHAR(255),
  website NVARCHAR(255),
  working_hours NVARCHAR(255),  -- VD: "Thứ 2 - Thứ 6: 8h00 - 17h00"
  description NVARCHAR(MAX),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE()
);

-- 13. Blogs
CREATE TABLE blogs (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  title NVARCHAR(255) NOT NULL,
  content NVARCHAR(MAX) NOT NULL,
  author NVARCHAR(100),
  published_at DATETIME DEFAULT GETDATE(),
  status NVARCHAR(50) DEFAULT 'draft',
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE()
);

--Contact
CREATE TABLE contacts (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  name NVARCHAR(255) NOT NULL,         
  email NVARCHAR(255) NOT NULL,          
  phone NVARCHAR(20),                    
  message NVARCHAR(MAX) NOT NULL,        
  status NVARCHAR(50) DEFAULT 'pending',
  created_at DATETIME DEFAULT GETDATE(),
);


-- 14. Blog Comments
CREATE TABLE blog_comments (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  blog_id UNIQUEIDENTIFIER NOT NULL,
  commenter_name NVARCHAR(100),
  comment NVARCHAR(MAX),
  commented_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_blog_comments FOREIGN KEY (blog_id) REFERENCES blogs(id) ON DELETE CASCADE
);

-- 15. Chatbot Sessions
CREATE TABLE chatbot_sessions (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  session_start DATETIME DEFAULT GETDATE(),
  session_end DATETIME NULL
);

-- 16. Chatbot Messages
CREATE TABLE chatbot_messages (
  id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  session_id UNIQUEIDENTIFIER NOT NULL,
  sender NVARCHAR(50) NOT NULL, -- 'user' hoặc 'bot'
  message NVARCHAR(MAX) NOT NULL,
  sent_at DATETIME DEFAULT GETDATE(),

  CONSTRAINT FK_chatbot_message FOREIGN KEY (session_id) REFERENCES chatbot_sessions(id) ON DELETE CASCADE
);
