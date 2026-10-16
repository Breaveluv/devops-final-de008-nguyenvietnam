-- =============================================================================
--  database/init.sql - Khởi tạo dữ liệu cho đề 008: Quản lý thư viện
--  MySQL tự chạy file này ở LẦN KHỞI ĐỘNG ĐẦU TIÊN khi được mount vào
--  /docker-entrypoint-initdb.d/  (database và user do biến MYSQL_* tạo sẵn)
-- =============================================================================
SET NAMES utf8mb4;

USE ptit_library_db;

CREATE TABLE IF NOT EXISTS books (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(150) NOT NULL,
    author          VARCHAR(100) NOT NULL,
    category        VARCHAR(50) NOT NULL,
    published_year  INT NOT NULL,
    quantity        INT NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO books (title, author, category, published_year, quantity) VALUES
    ('Clean Code', 'Robert C. Martin', 'Lập trình', 2008, 12),
    ('The Phoenix Project', 'Gene Kim', 'DevOps', 2013, 8),
    ('The DevOps Handbook', 'Gene Kim', 'DevOps', 2016, 6),
    ('Docker Deep Dive', 'Nigel Poulton', 'Container', 2023, 10),
    ('Kubernetes in Action', 'Marko Lukša', 'Container', 2018, 5),
    ('Site Reliability Engineering', 'Betsy Beyer', 'Vận hành', 2016, 7),
    ('Continuous Delivery', 'Jez Humble', 'DevOps', 2010, 4),
    ('Effective Java', 'Joshua Bloch', 'Lập trình', 2018, 9);
