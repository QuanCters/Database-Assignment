SELECT * FROM thuoc

SELECT * FROM don_thuoc

SELECT * FROM don_thuoc_gom_thuoc
SELECT * FROM lan_di_benh_vien

SELECT * FROM benh_nhan
SELECT * FROM lan_di_benh_vien
SELECT * FROM lan_su_dung_dich_vu WHERE Ma_loai_dich_vu = 'KB'
SELECT * FROM dich_vu_kham_benh
SELECT * FROM don_thuoc
SELECT * FROM don_thuoc_gom_thuoc

DELETE don_thuoc
WHERE Tong_tien_thuoc = 0

INSERT INTO benh_nhan (Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh)
VALUES ('BN001111', '376589123012', N'Trần ', N'Duy', N'Thanh Hóa', 'tranduy@example.com', N'Nam', '1980-03-15'),
	   ('BN001112', '354909123012', N'Lê ', N' Duy Khánh', N'Quảng Bình', 'ldkhanh@example.com', N'Nam', '2004-11-23'),
	   ('BN001113', '384950596023', N'Nguyễn', N'Trọng Thắng', N'Đồng Nai', 'ntthangg@example.com', N'Nam', '1995-01-31'),
	   ('BN001114', '249573958365', N'Cao', N'Bích Trà', N'Xuân Lộc', 'bichtra@example.com', N'Nữ', '2001-04-24'),
	   ('BN001115', '094384857291', N'Võ', N'Đăng Khôi', N'Vũng Tàu', 'vdkhoi@example.com', N'Nam', '2003-02-28');

INSERT INTO lan_di_benh_vien (Ma_so_lan_di_benh_vien, Gio, Ngay, Tong_chi_phi, Ma_benh_nhan)
VALUES ('LDBV01111', '08:20:00', '2024-04-20', 675000, 'BN001111'),
	   ('LDBV01112', '09:00:00', '2024-05-06', 925000, 'BN001112'),
	   ('LDBV01113', '09:40:00', '2024-05-06', 925000, 'BN001113'),
	   ('LDBV01114', '14:40:00', '2024-05-06', 1225000, 'BN001114'),
	   ('LDBV01115', '15:20:00', '2024-05-07', 1325000, 'BN001115');

INSERT INTO lan_su_dung_dich_vu (Ma_so, Ma_so_nhan_vien, Ma_so_lan_di_benh_vien, Ma_loai_dich_vu)
VALUES ('KB01111', 'BS10001', 'LDBV01111', 'KB'),
	   ('KB01112', 'BS10001', 'LDBV01112', 'KB'),
	   ('KB01113', 'BS10001', 'LDBV01113', 'KB'),
	   ('KB01114', 'BS10001', 'LDBV01114', 'KB'),
	   ('KB01115', 'BS10001', 'LDBV01115', 'KB');

INSERT INTO dich_vu_kham_benh(Ma_so, Ket_qua, Chi_phi, Ngay_hen_tiep_theo, Gio_hen_tiep_theo)
VALUES ('KB01111', N'Sốt phát ban', 46000, '2024-04-27', '08:20:00'),
	   ('KB01112', N'Đau bao tử', 46000, '2024-05-13', '09:00:00'),
	   ('KB01113', N'Đau bụng dưới', 46000, '2024-05-13', '09:40:00'),
	   ('KB01114', N'Rối loạn tiêu hóa', 46000, '2024-05-13', '14:40:00'),
	   ('KB01115', N'Dị ứng da', 46000, '2024-05-13', '15:20:00');

INSERT INTO don_thuoc (Ma_don_thuoc, Tong_tien_thuoc, Ma_so)
VALUES ('DT01111', 0, 'KB01111'),
	   ('DT01112', 0, 'KB01112'),
	   ('DT01113', 0, 'KB01113'),
	   ('DT01114', 0, 'KB01114'),
	   ('DT01115', 0, 'KB01115');


--Trường hợp 1: Thêm thuốc vào đơn thuốc không vượt quá 7 ngày
SELECT * FROM don_thuoc

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00002', 'DT01112', 7, N'Uống 1 viên mỗi lần'),
	   ('TH00004', 'DT01112', 14, N'Uống 2 viên mỗi lần');
INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00003', 'DT01113', 7, N'Uống 0.5 viên mỗi lần'),
	   ('TH00005', 'DT01113', 14, N'Uống 2 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00004', 'DT01114', 14, N'Uống 2 viên mỗi lần'),
	   ('TH00006', 'DT01114', 14, N'Uống 2 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00005', 'DT01115', 28, N'Uống 1 viên mỗi lần');

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00002', 'DT01111', 14, N'Uống 2 viên mỗi lần'),
	   ('TH00002', 'DT01111', 16, N'Uống 2 viên mỗi lần');

SELECT * FROM don_thuoc

--DELETE don_thuoc_gom_thuoc
--WHERE Ma_don_thuoc = 'DT01115'   

--Trường hợp 2: Thêm thuốc vào đơn thuốc vượt quá 7 ngày
SELECT * FROM don_thuoc





DELETE don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT01111' 

SELECT * FROM don_thuoc


--Trường hợp 3: Thêm thuốc có số lượng âm / 0  vào đơn thuốc không vượt quá 7 ngày
SELECT * FROM don_thuoc

INSERT INTO don_thuoc_gom_thuoc (Ma_thuoc, Ma_don_thuoc, So_luong, Lieu_luong)
VALUES ('TH00009', 'DT01113', -2, N'Uống 0.5 viên mỗi lần');

SELECT * FROM don_thuoc


--Trường hợp 4: Xóa 1 số loại thuốc khỏi đơn thuốc trước 7 ngày kể từ ngày đi khám
SELECT * FROM don_thuoc

DELETE don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT01112' AND Ma_thuoc = 'TH00004'

SELECT * FROM don_thuoc

--Trường hợp 5: Xóa thuốc không tồn tại trong đơn thuốc trước 7 ngày kể từ ngày đi khám
SELECT * FROM don_thuoc

DELETE don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT01113' AND Ma_thuoc = 'TH00020'

SELECT * FROM don_thuoc


--Trường hợp 6: Xóa 1 số loại thuốc khỏi đơn thuốc đã vượt 7 ngày kể từ ngày đi khám
SELECT * FROM don_thuoc;

DELETE don_thuoc_gom_thuoc
WHERE Ma_don_thuoc = 'DT10001' AND Ma_thuoc = 'TH00001';   

SELECT * FROM don_thuoc;


--Trường hợp 7: Thay đổi 1 số loại thuốc trong đơn thuốc trước 7 ngày kể từ ngày đi khám
SELECT * FROM don_thuoc;

UPDATE dbo.don_thuoc_gom_thuoc
SET So_luong = 4
WHERE Ma_don_thuoc = 'DT01113' AND Ma_thuoc = 'TH00003';

SELECT * FROM don_thuoc;


--Trường hợp 8: Thay đổi số lượng một loại thuốc thành số âm hoặc 0
SELECT * FROM don_thuoc;

UPDATE dbo.don_thuoc_gom_thuoc
SET So_luong = -5
WHERE Ma_don_thuoc = 'DT01114' AND Ma_thuoc = 'TH00006';

SELECT * FROM don_thuoc;


--Trường hợp 9: Thay đổi 1 số loại thuốc trong đơn thuốc đã vượt 7 ngày kể từ ngày đi khám
SELECT * FROM thuoc

UPDATE dbo.don_thuoc_gom_thuoc
SET So_luong = 5
WHERE Ma_don_thuoc = 'DT10001' AND Ma_thuoc = 'TH00001';

SELECT * FROM thuoc


--Trường hợp 10: Thay đổi mã thuốc một loại thuốc trong đơn thuốc trước 7 ngày kể từ ngày đi khám
SELECT * FROM don_thuoc;

UPDATE dbo.don_thuoc_gom_thuoc
SET Ma_thuoc = 'TH00018'
WHERE Ma_don_thuoc = 'DT01114' AND Ma_thuoc = 'TH00004';

SELECT * FROM don_thuoc;
