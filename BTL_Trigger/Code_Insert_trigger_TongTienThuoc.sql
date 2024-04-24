-- Thêm dữ liệu vào bảng nhan_vien
INSERT INTO nhan_vien (Ma_so_nhan_vien, CCCD, Ho, Ten, Gioi_tinh, Dia_chi, Email, Ngay_ky_hop_dong, Luong, Ngay_sinh)
VALUES ('BS00001', '123456789012', N'Nguyễn', N'Văn A', 'Nam', N'Hà Nội', 'nguyenvana@example.com', '2023-01-15', 5000000, '1990-05-20'),
       ('DD00001', '987654321012', N'Nguyễn', N'Thị B', 'Nu', N'Hồ Chí Minh', 'nguyenthib@example.com', '2023-02-20', 3500000, '1995-08-10');

-- Thêm dữ liệu vào bảng bac_si
INSERT INTO bac_si (Ma_so_nhan_vien, Chuc_vu, Bang_cap, Chuyen_khoa, Chuc_danh, Ma_so_quan_ly)
VALUES ('BS00001', N'Bác sĩ chính', N'Tiến sĩ', N'Nội khoa', N'Giáo sư', NULL);

-- Thêm dữ liệu vào bảng benh_nhan
INSERT INTO benh_nhan (Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh)
VALUES ('BN00001', '456789123012', N'Nguyễn', N'Thị C', N'Hải Phòng', 'nguyenthic@example.com', N'Nu', '1980-03-15'),
       ('BN00002', '789123456012', N'Trần', N'Văn D', N'Hồ Chí Minh', 'tranvand@example.com', N'Nam', '1992-07-25');

-- Thêm dữ liệu vào bảng lan_di_benh_vien

SELECT * FROM  dbo.lan_di_benh_vien
INSERT INTO lan_di_benh_vien (Ma_so_lan_di_benh_vien, Gio, Ngay, Tong_chi_phi, Ma_benh_nhan)
VALUES ('LDBV00001', '08:30:00', '2024-04-23', 300000, 'BN00001'),
       ('LDBV00002', '10:00:00', '2024-04-24', 450000, 'BN00002');

-- Thêm dữ liệu vào bảng dich_vu_kham_benh và lan_su_dung_dich_vu
INSERT INTO dich_vu_kham_benh (Ma_so, Ket_qua, Chi_phi, Ngay_hen_tiep_theo, Gio_hen_tiep_theo)
VALUES ('KB00001', N'Kết quả 1', 200000, '2024-04-25', '08:00:00'),
       ('KB00002', N'Kết quả 2', 250000, '2024-04-26', '09:30:00'),
       ('KB00003', N'Kết quả 3', 300000, '2024-04-27', '10:15:00');

INSERT INTO lan_su_dung_dich_vu (Ma_so, Ma_so_nhan_vien, Ma_so_lan_di_benh_vien, Ma_loai_dich_vu)
VALUES ('KB00001', 'BS00001', 'LDBV00001', 'KB'),
       ('KB00002', 'BS00001', 'LDBV00002', 'KB'),
       ('KB00003', 'DD00001', 'LDBV00001', 'KB');

	   SELECT * FROM dbo.loai_dich_vu

-- Thêm dữ liệu vào bảng don_thuoc
SELECT * FROM don_thuoc


INSERT INTO don_thuoc (Ma_don_thuoc, Tong_tien_thuoc, Ma_so)
VALUES ('DT001', 0, 'KB00001'),
       ('DT002', 0, 'KB00002'),
       ('DT003', 0, 'KB00003');

UPDATE dbo.don_thuoc
SET Tong_tien_thuoc = 0


DELETE FROM dbo.don_thuoc
WHERE Ma_don_thuoc = 'DT001'

DELETE FROM dbo.don_thuoc
WHERE Ma_don_thuoc = 'DT002'

DELETE FROM dbo.don_thuoc
WHERE Ma_don_thuoc = 'DT003'



-- Thêm dữ liệu vào bảng thuoc
SELECT * FROM dbo.thuoc





INSERT INTO thuoc (Ma_thuoc, Ten, Gia_ban, HDSD)
VALUES ('TH00001', N'Paracetamol', 5000, N'Dùng theo chỉ dẫn của bác sĩ'),
       ('TH00002', N'Amoxicillin', 10000, N'Uống mỗi 8 giờ'),
       ('TH00003', N'Loperamide', 7000, N'Uống 1 viên mỗi khi tiêu chảy');

INSERT INTO thuoc (Ma_thuoc, Ten, Gia_ban, HDSD)
VALUES ('TH00004', N' Cephalexin', 1300, N'Dùng theo chỉ dẫn của bác sĩ')


-------------------------------------------------------------------------------------------------------
-- Thêm dữ liệu vào bảng don_thuoc_gom_thuoc
SELECT * FROM dbo.don_thuoc_gom_thuoc



INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00001', 'DT001', 2, N'Uống 2 viên mỗi lần');


INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES('TH00002', 'DT002', 3, N'Uống 1 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00003', 'DT003', 4, N'Uống 1 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00001', 'DT002', 4, N'Uống 1 viên mỗi lần'),
		('TH00003', 'DT002', 4, N'Uống 1 viên mỗi lần');

--------------------------------------------------------------------------------------

DELETE FROM dbo.don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT001'

DELETE FROM dbo.don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT002'

DELETE FROM dbo.don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT003'
----------------------------------------------------------------------------------
--Xét riêng Đơn thuốc DT003 
INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00001', 'DT003', 7, N'Uống 1 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00002', 'DT003', 3, N'Uống 1 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00003', 'DT003', 3, N'Uống 1 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00002', 'DT003', -3, N'Uống 1 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00002', 'DT003', 1.35, N'Uống 1 viên mỗi lần');


-----------
-- Đơn thuốc DT003    hoàn toàn ko có thuốc Cephalexin
SELECT * FROM dbo.don_thuoc_gom_thuoc

SELECT * FROM dbo.don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT003';


DELETE FROM dbo.don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT003' AND Ma_thuoc = 'TH00004'

-----------
UPDATE dbo.don_thuoc_gom_thuoc
SET So_luong = -3
WHERE Ma_don_thuoc = 'DT003' AND Ma_thuoc = 'TH00003';

UPDATE dbo.don_thuoc_gom_thuoc
SET So_luong = 4
WHERE Ma_don_thuoc = 'DT003' AND Ma_thuoc = 'TH00001';
----------------------------------------------------------------------------------------------

--Test chức năng ko cho insert/update/delete vs những đơn thuốc đã vượt quá 7 ngày kể từ lần đi khám bệnh
SELECT * FROM  dbo.lan_di_benh_vien
SELECT * FROM dbo.benh_nhan

INSERT INTO benh_nhan (Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh)
VALUES ('BN001111', '376589123012', N'Trần ', N'Duy', N'Thanh Hóa', 'tranduy@example.com', N'Nam', '1980-03-15')

INSERT INTO lan_di_benh_vien (Ma_so_lan_di_benh_vien, Gio, Ngay, Tong_chi_phi, Ma_benh_nhan)
VALUES ('LDBV01111', '08:30:00', '2024-04-10', 300000, 'BN001111')

INSERT INTO lan_su_dung_dich_vu (Ma_so, Ma_so_nhan_vien, Ma_so_lan_di_benh_vien, Ma_loai_dich_vu)
VALUES ('KB01111', 'BS00001', 'LDBV01111', 'KB'),

INSERT INTO dich_vu_kham_benh (Ma_so, Ket_qua, Chi_phi, Ngay_hen_tiep_theo, Gio_hen_tiep_theo)
VALUES ('KB01111', N'Kết quả 1', 200000, '2024-04-17', '08:00:00')
-------------------------------------------------------------------------------

SELECT * FROM don_thuoc