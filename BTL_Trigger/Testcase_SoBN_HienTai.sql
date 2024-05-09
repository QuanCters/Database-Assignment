USE assignment2
GO

SELECT * FROM dbo.phong_benh

SELECT * FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru

--Thực hiện tạo dữ liệu trong bảng lan_su_dung_dich_vu và bảng dich_vu_luu_tru trước khi kiểm tra từng trường hợp bên dưới. 
INSERT INTO lan_su_dung_dich_vu (Ma_so, Ma_so_lan_di_benh_vien, Ma_loai_dich_vu, Ma_so_nhan_vien)
VALUES ('LT12007', 'LDBV10050', 'LT', 'BS10002'),
	   ('LT12008', 'LDBV10051', 'LT', 'BS10002'),
	   ('LT12009', 'LDBV10052', 'LT', 'BS10003'),
	   ('LT12010', 'LDBV10053', 'LT', 'BS10003'),
	   ('LT12011', 'LDBV10054', 'LT', 'BS10004'),
	   ('LT12012', 'LDBV10055', 'LT', 'BS10004'),
	   ('LT14005', 'LDBV10056', 'LT', 'BS10005'),
	   ('LT14006', 'LDBV10057', 'LT', 'BS10005'), 
	   ('LT14007', 'LDBV10058', 'LT', 'BS10005');

INSERT INTO dich_vu_luu_tru (Ma_so, Ngay_bat_dau, Ngay_ket_thuc, Tong_chi_phi)
VALUES 
('LT12007', '2024-04-19', '2024-04-30', 2150000),
('LT12008', '2024-04-22', '2024-05-01', 2580000),
('LT12009', '2024-05-02', '2024-05-20', 3870000),
('LT12010', '2024-05-03', '2024-05-24', 5160000),
('LT12011', '2024-05-03', '2024-05-24', 5160000),
('LT12012', '2024-05-03', '2024-05-24', 5160000),
('LT14005', '2024-05-03', '2024-05-24', 5160000),
('LT14006', '2024-05-03', '2024-05-24', 5160000),
('LT14007', '2024-05-03', '2024-05-24', 5160000);


   
-- Trường hợp 1: Bệnh nhân vẫn còn hạn sử dụng DV lưu trú, phòng bệnh muốn thêm còn chỗ.
SELECT * FROM phong_benh;

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT12009');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT12010');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB22001', 'LT12011');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB22001', 'LT12012');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB41001', 'LT14005');
SELECT * FROM phong_benh;

--Trường hợp 2: Bệnh nhân vẫn còn hạn sử dụng DV lưu trú, phòng bệnh muốn thêm hết chỗ.
SELECT * FROM phong_benh;

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT14006');

SELECT * FROM phong_benh;


--Trường hợp 3: Bệnh nhân hết hạn sử dụng DV lưu trú, phòng bệnh muốn thêm còn chỗ.
SELECT * FROM phong_benh;

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT12007');

SELECT * FROM phong_benh;


--Trường hợp 4: Bệnh nhân hết hạn sử dụng DV lưu trú, phòng bệnh muốn thêm hết chỗ.
SELECT * FROM phong_benh;
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB22001', 'LT12008');
SELECT * FROM phong_benh;


--Trường hợp 5: Xóa bệnh nhân khỏi phòng bệnh nếu bệnh nhân còn hạn sử dụng dịch vụ lưu trú.
SELECT * FROM phong_benh;

DELETE phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru = 'LT14005'

SELECT * FROM phong_benh;


--Trường hợp 6: Xóa bệnh nhân khỏi phòng bệnh nếu bệnh nhân đã hết hạn dịch vụ lưu trú.
SELECT * FROM phong_benh;

DELETE ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru = 'LT16011'

DELETE phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru = 'LT16011';

SELECT * FROM phong_benh;


--Trường hợp 7: Chuyển bệnh nhân từ phòng này sang phòng khác vẫn còn chỗ.
SELECT * FROM phong_benh;

UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB42001'
WHERE Ma_so_dich_vu_luu_tru = 'LT12012';

SELECT * FROM phong_benh;


--Trường hợp 8: Chuyển bệnh nhân từ phòng này sang phòng khác (đã đầy).
SELECT * FROM phong_benh;

UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB21001'
WHERE Ma_so_dich_vu_luu_tru = 'LT14005';

SELECT * FROM phong_benh;

--Trường hợp 9: Tạo và thêm một bệnh nhân hoàn toàn mới, hết hạn dịch vụ lưu trú.
INSERT INTO dbo.benh_nhan(Ma_benh_nhan, CCCD,Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh)
VALUES('BN11111', '432653456012', N'Vũ', N'Dũng', N'Đồng Tháp', 'vudung1@gmail.com', 'Nam', '1992-07-25');

INSERT INTO dbo.lan_di_benh_vien(Ma_so_lan_di_benh_vien, Gio, Ngay, Tong_chi_phi, Ma_benh_nhan)
VALUES('LDBV11111', '13:00:00', '2024-04-25', 700000,'BN11111');

INSERT INTO dbo.lan_su_dung_dich_vu(Ma_so, Ma_so_nhan_vien, Ma_so_lan_di_benh_vien, Ma_loai_dich_vu)
VALUES('LT11111', 'BS10001', 'LDBV11111', 'LT');

INSERT INTO dbo.dich_vu_luu_tru(Ma_so, Ngay_bat_dau, Ngay_ket_thuc, Tong_chi_phi)
VALUES ('LT11111', '2024-04-25', '2024-04-30',2500000);

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru(So_phong, Ma_so_dich_vu_luu_tru)
VALUES('PB41001', 'LT11111');

SELECT * FROM dbo.phong_benh;



--Trường hợp 10: Điều chỉnh Ngay_ket_thuc từ hết hạn thành còn hạn DV lưu trú.
SELECT * FROM dbo.phong_benh;

UPDATE dbo.dich_vu_luu_tru
SET Ngay_ket_thuc = '2024-05-30'
WHERE Ma_so = 'LT11111';

SELECT * FROM dbo.phong_benh;


--Trường hợp 11: Điều chỉnh Ngay_ket_thuc từ còn hạn thành hết hạn DV lưu trú.
SELECT * FROM dbo.phong_benh;

UPDATE dbo.dich_vu_luu_tru
SET Ngay_ket_thuc = '2024-05-30'
WHERE Ma_so = 'LT11111';

SELECT * FROM dbo.phong_benh;





--Trường hợp 12: Điều chỉnh Ngay_ket_thuc từ hết hạn thành còn hạn DV lưu trú 
--khi phòng bệnh lưu trú trước đó của bệnh nhân hiện tại đã đầy.

SELECT * FROM dbo.phong_benh;

INSERT INTO dbo.benh_nhan(Ma_benh_nhan, CCCD,Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh)
VALUES('BN11112', '447653456012', N'Đinh', N'Hoàng', N'Đồng Nai', 'dhoang1@gmail.com', 'Nam', '1992-07-25'),
	  ('BN11113', '447653456012', N'Nguyễn', N'Đức Đại', N'Thái Nguyên', 'nddai@gmail.com', 'Nam', '2000-08-03');


INSERT INTO dbo.lan_di_benh_vien(Ma_so_lan_di_benh_vien, Gio, Ngay, Tong_chi_phi, Ma_benh_nhan)
VALUES('LDBV11112', '13:00:00', '2024-03-25', 700000,'BN11112'),
	  ('LDBV11113', '13:00:00', '2024-05-07', 700000,'BN11113');

INSERT INTO dbo.lan_su_dung_dich_vu(Ma_so, Ma_so_nhan_vien, Ma_so_lan_di_benh_vien, Ma_loai_dich_vu)
VALUES('LT11112', 'BS10002', 'LDBV11112', 'LT'),
	  ('LT11113', 'BS10003', 'LDBV11113', 'LT');
INSERT INTO dbo.dich_vu_luu_tru(Ma_so, Ngay_bat_dau, Ngay_ket_thuc, Tong_chi_phi)
VALUES ('LT11112', '2024-03-25', '2024-05-30',7740000);

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru(So_phong, Ma_so_dich_vu_luu_tru)
VALUES('PB22001', 'LT11112')

SELECT * FROM dbo.phong_benh;

UPDATE dich_vu_luu_tru
SET Ngay_ket_thuc = '2024-04-30'
WHERE Ma_so = 'LT11112';

SELECT * FROM dbo.phong_benh;	   

INSERT INTO dbo.dich_vu_luu_tru(Ma_so, Ngay_bat_dau, Ngay_ket_thuc, Tong_chi_phi)
VALUES ('LT11113', '2024-05-07', '2024-05-30',4945000);

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru(So_phong, Ma_so_dich_vu_luu_tru)
VALUES('PB22001', 'LT11113');

SELECT * FROM dbo.phong_benh;

UPDATE dich_vu_luu_tru
SET Ngay_ket_thuc = '2024-05-30'
WHERE Ma_so = 'LT11112';

SELECT * FROM dbo.phong_benh;
