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





-- Khi người dùng thả tim
CREATE TRIGGER trg_increase_reaction
ON blog_reactions
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE blogs
    SET reactions_count = reactions_count + 1
    FROM blogs b
    JOIN inserted i ON b.id = i.blog_id
    WHERE i.is_active = 1
      AND (SELECT is_active FROM blog_reactions 
           WHERE blog_id = i.blog_id AND user_id = i.user_id) = 1
END
GO

-- Khi người dùng bỏ tim
CREATE TRIGGER trg_decrease_reaction
ON blog_reactions
AFTER UPDATE
AS
BEGIN
    UPDATE blogs
    SET reactions_count = reactions_count - 1
    FROM blogs b
    JOIN inserted i ON b.id = i.blog_id
    JOIN deleted d ON d.blog_id = i.blog_id AND d.user_id = i.user_id
    WHERE i.is_active = 0 AND d.is_active = 1
END
GO

-- comment
CREATE TRIGGER trg_increase_comment
ON blog_comments
AFTER INSERT
AS
BEGIN
    UPDATE blogs
    SET comments_count = comments_count + 1
    FROM blogs b
    JOIN inserted i ON b.id = i.blog_id
END
GO
-- xóa comment
CREATE TRIGGER trg_decrease_comment
ON blog_comments
AFTER DELETE
AS
BEGIN
    UPDATE blogs
    SET comments_count = comments_count - 1
    FROM blogs b
    JOIN deleted d ON b.id = d.blog_id
END
GO
