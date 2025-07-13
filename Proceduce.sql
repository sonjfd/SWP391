CREATE OR ALTER PROCEDURE sp_generate_doctor_schedule
    @month INT,
    @doctor_id VARCHAR(50)  -- hoặc kiểu phù hợp với cột doctor_id
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @year INT = YEAR(GETDATE());
    DECLARE @startDate DATE = DATEFROMPARTS(@year, @month, 1);
    DECLARE @endDate DATE = EOMONTH(@startDate);

    DECLARE @currentDate DATE = @startDate;

    WHILE @currentDate <= @endDate
    BEGIN
        -- Map weekday: SQL Server -> CN = 1, T2 = 2, ..., T7 = 7
        -- Template dùng: T2 = 2, ..., CN = 8 → cần chuyển CN từ 1 -> 8
        DECLARE @mappedWeekday INT = CASE 
                                        WHEN DATEPART(WEEKDAY, @currentDate) = 1 THEN 8 
                                        ELSE DATEPART(WEEKDAY, @currentDate)
                                     END;

        -- Thêm lịch làm việc nếu chưa có (tránh trùng), chỉ cho doctor_id truyền vào
        INSERT INTO doctor_schedule (doctor_id, work_date, shift_id)
        SELECT doctor_id, @currentDate, shift_id
        FROM weekly_schedule_template
        WHERE weekday = @mappedWeekday
          AND doctor_id = @doctor_id
          AND NOT EXISTS (
              SELECT 1
              FROM doctor_schedule ds
              WHERE ds.doctor_id = weekly_schedule_template.doctor_id
                AND ds.work_date = @currentDate
                AND ds.shift_id = weekly_schedule_template.shift_id
          );

        SET @currentDate = DATEADD(DAY, 1, @currentDate);
    END
END



CREATE TRIGGER trg_AfterDelete_DoctorSchedule
ON doctor_schedule
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DeletedDoctors TABLE (doctor_id UNIQUEIDENTIFIER PRIMARY KEY);

    INSERT INTO @DeletedDoctors(doctor_id)
    SELECT DISTINCT doctor_id FROM DELETED;

    

    DELETE wst
    FROM weekly_schedule_template wst
    INNER JOIN @DeletedDoctors dd ON wst.doctor_id = dd.doctor_id
    WHERE NOT EXISTS (
        SELECT 1 FROM doctor_schedule ds WHERE ds.doctor_id = dd.doctor_id
    );
END;










CREATE OR ALTER TRIGGER trg_insert_invoice_on_appointment_services
ON appointment_services
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Tạo bảng tạm để xử lý nhiều dòng được insert cùng lúc
    DECLARE @AppointmentId UNIQUEIDENTIFIER;

    -- Duyệt từng appointment_id vừa được insert (tránh trường hợp nhiều dòng khác nhau)
    DECLARE inserted_cursor CURSOR FOR
        SELECT DISTINCT appointment_id FROM inserted;

    OPEN inserted_cursor;
    FETCH NEXT FROM inserted_cursor INTO @AppointmentId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
  
        DECLARE @TotalAmount DECIMAL(10,2);

        SELECT @TotalAmount = SUM(price)
        FROM appointment_services
        WHERE appointment_id = @AppointmentId;

        IF EXISTS (
            SELECT 1 FROM invoices WHERE appointment_id = @AppointmentId
        )
        BEGIN
         
            UPDATE invoices
            SET total_amount = @TotalAmount,
                updated_at = GETDATE()
            WHERE appointment_id = @AppointmentId;
        END
        ELSE
        BEGIN
            -- Nếu chưa có → tạo mới
            INSERT INTO invoices (appointment_id, total_amount, payment_status, created_at, updated_at)
            VALUES (@AppointmentId, @TotalAmount, 'pending', GETDATE(), GETDATE());
        END

        FETCH NEXT FROM inserted_cursor INTO @AppointmentId;
    END

    CLOSE inserted_cursor;
    DEALLOCATE inserted_cursor;
END;




CREATE TRIGGER trg_CheckoutCart
ON cart_items
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cart_id INT;
    DECLARE @user_id UNIQUEIDENTIFIER;
    DECLARE @invoice_id UNIQUEIDENTIFIER;
    DECLARE @total_amount DECIMAL(18,2);

    -- Lấy cart_id từ bản ghi vừa xóa
    SELECT TOP 1 @cart_id = d.cart_id FROM DELETED d;

    -- Kiểm tra nếu cart không còn item nào thì tiến hành tạo hóa đơn
    IF NOT EXISTS (SELECT 1 FROM cart_items WHERE cart_id = @cart_id)
    BEGIN
        -- Lấy user_id từ cart
        SELECT @user_id = user_id FROM cart WHERE cart_id = @cart_id;

        -- Tính tổng tiền từ các item vừa xóa
        SELECT @total_amount = SUM(d.quantity * pv.price)
        FROM DELETED d
        JOIN product_variants pv ON d.product_variant_id = pv.product_variant_id;

        -- Tạo invoice mới
        SET @invoice_id = NEWID();
        INSERT INTO sales_invoices (invoice_id, staff_id, total_amount, payment_method, payment_status, created_at, updated_at)
        VALUES (@invoice_id, NULL, @total_amount, 'cash', 'unpaid', GETDATE(), GETDATE());

        -- Thêm các chi tiết hóa đơn từ item vừa xóa
        INSERT INTO sales_invoice_items (invoice_id, product_variant_id, quantity, price)
        SELECT
            @invoice_id,
            d.product_variant_id,
            d.quantity,
            pv.price
        FROM DELETED d
        JOIN product_variants pv ON d.product_variant_id = pv.product_variant_id;

        -- Xóa giỏ hàng nếu không muốn giữ cart rỗng
        DELETE FROM cart WHERE cart_id = @cart_id;
    END
END;
GO


CREATE TRIGGER trg_UpdateLastMessageTime
ON messages
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET c.last_message_time = (
        SELECT MAX(m.sent_at)
        FROM messages m
        WHERE m.conversation_id = c.conversation_id
    )
    FROM conversations c
    INNER JOIN (
        SELECT DISTINCT conversation_id
        FROM inserted
    ) i ON c.conversation_id = i.conversation_id;
END;
