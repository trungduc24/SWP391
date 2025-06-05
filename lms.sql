-- 1. Tạo CSDL và sử dụng
CREATE DATABASE LMS_System;
GO
USE LMS_System;
GO

-- 2. Bảng users (thêm email và avatar_url, email cho phép NULL để không lỗi khi thêm cột nếu bảng có dữ liệu)
CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) CHECK (role IN ('admin', 'student', 'lecturer')) NOT NULL,
    email NVARCHAR(100) NULL,
    avatar_url NVARCHAR(255) NULL
);
GO

-- 3. Bảng admins (thêm avatar_url)
CREATE TABLE admins (
    admin_id INT PRIMARY KEY IDENTITY,
    user_id INT UNIQUE,
    full_name NVARCHAR(100),
    email NVARCHAR(100),
    phone NVARCHAR(20),
    avatar_url NVARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- 4. Bảng students (thêm avatar_url)
CREATE TABLE students (
    student_id INT PRIMARY KEY IDENTITY,
    user_id INT UNIQUE,
    full_name NVARCHAR(100),
    student_code NVARCHAR(20) UNIQUE,
    email NVARCHAR(100),
    avatar_url NVARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- 5. Bảng lecturers (thêm avatar_url)
CREATE TABLE lecturers (
    lecturer_id INT PRIMARY KEY IDENTITY,
    user_id INT UNIQUE,
    full_name NVARCHAR(100),
    email NVARCHAR(100),
    avatar_url NVARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- 6. Bảng semesters
CREATE TABLE semesters (
    semester_id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(50),
    start_date DATE,
    end_date DATE
);
GO

-- 7. Bảng courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(100),
    code NVARCHAR(20),
    room NVARCHAR(50),
    lecturer_id INT,
    semester_id INT,
    total_sessions INT,
    FOREIGN KEY (lecturer_id) REFERENCES lecturers(lecturer_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);
GO

-- 8. Bảng enrollments
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY,
    student_id INT,
    course_id INT,
    current_session INT DEFAULT 0,
    UNIQUE(student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
GO

-- 9. Bảng assignments
CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY IDENTITY,
    course_id INT,
    title NVARCHAR(200),
    description TEXT,
    due_date DATETIME,
    type NVARCHAR(20) CHECK (type IN ('exercise', 'exam')),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
GO

-- 10. Bảng submissions
CREATE TABLE submissions (
    submission_id INT PRIMARY KEY IDENTITY,
    assignment_id INT,
    student_id INT,
    submitted_at DATETIME,
    file_url NVARCHAR(255),
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
GO

-- 11. Bảng grades
CREATE TABLE grades (
    grade_id INT PRIMARY KEY IDENTITY,
    student_id INT,
    course_id INT,
    assignment_id INT,
    score FLOAT CHECK (score BETWEEN 0 AND 10),
    comment NVARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id)
);
GO

-- 12. Bảng course_materials
CREATE TABLE course_materials (
    material_id INT PRIMARY KEY IDENTITY,
    course_id INT,
    title NVARCHAR(100),
    description TEXT,
    file_url NVARCHAR(255),
    uploaded_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
GO

-- 13. Bảng attendance
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY IDENTITY,
    student_id INT,
    course_id INT,
    session_number INT,
    status NVARCHAR(10) CHECK (status IN ('present', 'absent', 'late')),
    date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
GO

-- 14. Bảng announcements
CREATE TABLE announcements (
    announcement_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    title NVARCHAR(200),
    content TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- 15. Bảng messages
CREATE TABLE messages (
    message_id INT PRIMARY KEY IDENTITY,
    sender_id INT,
    receiver_id INT,
    content TEXT,
    sent_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);
GO

-- 16. Bảng notifications
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    title NVARCHAR(200),
    message TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    is_read BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- 17. Bảng forums
CREATE TABLE forums (
    forum_id INT PRIMARY KEY IDENTITY,
    course_id INT,
    title NVARCHAR(100),
    created_by INT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);
GO

-- 18. Bảng forum_posts
CREATE TABLE forum_posts (
    post_id INT PRIMARY KEY IDENTITY,
    forum_id INT,
    user_id INT,
    content TEXT,
    posted_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (forum_id) REFERENCES forums(forum_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- 19. Bảng quizzes
CREATE TABLE quizzes (
    quiz_id INT PRIMARY KEY IDENTITY,
    course_id INT,
    title NVARCHAR(200),
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
GO

-- 20. Bảng questions
CREATE TABLE questions (
    question_id INT PRIMARY KEY IDENTITY,
    quiz_id INT,
    question_text TEXT,
    option_a NVARCHAR(255),
    option_b NVARCHAR(255),
    option_c NVARCHAR(255),
    option_d NVARCHAR(255),
    correct_option CHAR(1) CHECK (correct_option IN ('A','B','C','D')),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id)
);
GO

-- 21. Bảng quiz_submissions
CREATE TABLE quiz_submissions (
    quiz_submission_id INT PRIMARY KEY IDENTITY,
    quiz_id INT,
    student_id INT,
    submitted_at DATETIME,
    score FLOAT,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
GO

-- 22. Bảng password_resets (thêm index idx_token)
CREATE TABLE password_resets (
    reset_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    token NVARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    is_used BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

CREATE INDEX idx_token ON password_resets(token);
GO

CREATE PROCEDURE RegisterUser
    @username NVARCHAR(50),
    @password NVARCHAR(255),
    @role NVARCHAR(20),
    @email NVARCHAR(100) = NULL,
    @full_name NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra role hợp lệ
    IF @role NOT IN ('admin', 'student', 'lecturer')
    BEGIN
        RAISERROR('Role phải là admin, student hoặc lecturer', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Thêm user vào bảng users
        INSERT INTO users (username, password, role, email)
        VALUES (@username, @password, @role, @email);

        DECLARE @newUserId INT = SCOPE_IDENTITY();

        -- Tùy role, thêm bản ghi tương ứng
        IF @role = 'admin'
        BEGIN
            INSERT INTO admins (user_id, full_name, email)
            VALUES (@newUserId, @full_name, @email);
        END
        ELSE IF @role = 'student'
        BEGIN
            INSERT INTO students (user_id, full_name, email)
            VALUES (@newUserId, @full_name, @email);
        END
        ELSE IF @role = 'lecturer'
        BEGIN
            INSERT INTO lecturers (user_id, full_name, email)
            VALUES (@newUserId, @full_name, @email);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
GO

