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

SELECT * FROM dich_vu_luu_tru
--TH1: Bệnh nhân vẫn còn hạn sử dụng DV lưu trú, phòng bệnh muốn thêm còn chỗ
SELECT * FROM phong_benh

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT12009');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT12010');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB22001', 'LT12011');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB22001', 'LT12012');
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB41001', 'LT14005');


SELECT * FROM phong_benh


--Trường hợp 2: Bệnh nhân vẫn còn hạn sử dụng DV lưu trú, phòng bệnh muốn thêm hết chỗ.
SELECT * FROM phong_benh

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT14006');

SELECT * FROM phong_benh

--Trường hợp 3: Bệnh nhân hết hạn sử dụng DV lưu trú, phòng bệnh muốn thêm còn chỗ.
SELECT * FROM phong_benh

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB21001', 'LT12007');

SELECT * FROM phong_benh


--Trường hợp 4: Bệnh nhân hết hạn sử dụng DV lưu trú, phòng bệnh muốn thêm hết chỗ.
SELECT * FROM phong_benh

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru) VALUES ('PB22001', 'LT12008');

SELECT * FROM phong_benh

SELECT * FROM phong_benh_duoc_su_dung_tai_dich_vu_luu_tru

--Trường hợp 5: Xóa bệnh nhân khỏi phòng bệnh nếu bệnh nhân có sử dụng dịch vụ lưu trú.
SELECT * FROM phong_benh

DELETE phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru = 'LT14005'

SELECT * FROM ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru

--Trường hợp 6: Xóa bệnh nhân khỏi phòng bệnh nếu bệnh nhân có sử dụng dịch vụ lưu trú.
SELECT * FROM phong_benh

DELETE ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru = 'LT14001'

DELETE phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru = 'LT14001'
SELECT * FROM phong_benh



/*
INSERT INTO dich_vu_luu_tru (Ma_so, Ngay_bat_dau, Ngay_ket_thuc, Tong_chi_phi)
VALUES ('LT16011', '2024-04-28', '2024-05-06', 1935000);

INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru)
VALUES('PB63001', 'LT16011');

INSERT INTO ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru, Ngay_su_dung)
VALUES ('PB63001', 'LT16011', '2024-04-28');


----------------
INSERT INTO phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru)
VALUES ('PB41001', 'LT14001')

INSERT INTO ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (So_phong, Ma_so_dich_vu_luu_tru, Ngay_su_dung)
VALUES ('PB41001', 'LT14001', '2024-04-01')

*/

SELECT * FROM dich_vu_luu_tru
SELECT * FROM phong_benh_duoc_su_dung_tai_dich_vu_luu_tru WHERE Ma_so_dich_vu_luu_tru = 'LT14001'
SELECT * FROM ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru


--Trường hợp 7: Chuyển bệnh nhân từ phòng này sang phòng khác (vẫn còn chỗ)
SELECT * FROM phong_benh

UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB42001'
WHERE Ma_so_dich_vu_luu_tru = 'LT12012'  

SELECT * FROM phong_benh

--Trường hợp 8: Chuyển bệnh nhân từ phòng này sang phòng khác (đã đầy)
SELECT * FROM phong_benh

UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB21001'
WHERE Ma_so_dich_vu_luu_tru = 'LT14005'

SELECT * FROM phong_benh


--Trường hợp 9: Insert vào bảng dich_vu_luu_tru
select * FROM dbo.benh_nhan
select * FROM dbo.lan_di_benh_vien
select * FROM dbo.lan_su_dung_dich_vu
select * FROM dbo.dich_vu_luu_tru
select * FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
select * FROM dbo.phong_benh

INSERT INTO dbo.benh_nhan(Ma_benh_nhan, CCCD,Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh)
VALUES('BN11111', '432653456012', N'Vũ', N'Dũng', N'Đồng Tháp', 'vudung1@gmail.com', 'Nam', '1992-07-25')


INSERT INTO dbo.lan_di_benh_vien(Ma_so_lan_di_benh_vien, Gio, Ngay, Tong_chi_phi, Ma_benh_nhan)
VALUES('LDBV11111', '13:00:00', '2024-04-25', 700000,'BN11111')

INSERT INTO dbo.lan_su_dung_dich_vu(Ma_so, Ma_so_nhan_vien, Ma_so_lan_di_benh_vien, Ma_loai_dich_vu)
VALUES('LT11111', 'BS10001', 'LDBV11111', 'LT')

INSERT INTO dbo.dich_vu_luu_tru(Ma_so, Ngay_bat_dau, Ngay_ket_thuc, Tong_chi_phi)
VALUES ('LT11111', '2024-04-25', '2024-04-30',2500000)

UPDATE dbo.dich_vu_luu_tru
SET Ngay_ket_thuc = '2024-05-30'
WHERE Ma_so = 'LT11111'
(QUá ngày - quá hạn DV lưu trú) 
INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru(So_phong, Ma_so_dich_vu_luu_tru)
VALUES('PB41001', 'LT11111')


SELECT * FROM dbo.phong_benh;

UPDATE dbo.dich_vu_luu_tru
SET Ngay_ket_thuc = '2024-04-30'
WHERE Ma_so = 'LT11111';

SELECT * FROM dbo.phong_benh;
