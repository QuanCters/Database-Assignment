USE assignment2
GO

SELECT * FROM dbo.phong_benh

SELECT * FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru



--TH1: INSERT Cơ bản vào bảng phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES('PB40101', 'LT10401')

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES('PB40101', 'LT10402')

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES('PB60101', 'LT10601')

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES('PB60101', 'LT10602')

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES('PB20101', 'LT10201')

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES('PB20101', 'LT10202')




SELECT * FROM dbo.dich_vu_luu_tru
--TH2: Delete bệnh nhân khỏi bảng phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
--Nếu có bệnh nhân đó trong phòng bệnh hiện tại
--> Xóa + hiện thông báo 'Xóa bệnh nhân khỏi phòng bệnh thành công!'

--Không có trường hợp dưới 
--Nếu ko có bệnh nhân đó trong phòng bệnh hoặc phòng hiện đang trống
--> Hiện thông báo 'Xoá thất bại hoặc phòng bệnh hiện đang trống!'

--Do bảng deleted chỉ đc cập nhật khi [Đã có sẵn data] và data đó bị xóa --> Ko có sẵn khi xóa sẽ ko tự động có trong bảng deleted --> Ko có data đc lưu sẵn trong bảng deleted để đối chiếu lấy thông tin ra 

DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru ='LT10401'

DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru ='LT10402'

DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru ='LT10601'

DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru ='LT10602'

DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru ='LT10201'

DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru ='LT10202'


--TH3: Thử insert vào phòng đã đầy 
--> hiện thông báo phòng đã đầy - Vui lòng chọn phòng bệnh khác
SELECT * FROM dbo.phong_benh

SELECT * FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru

DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru ='LT10602'

INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES('PB20101', 'LT10602')

--TH4: Update chuyển bệnh nhân từ phòng này sang phòng khác
UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB20201'
WHERE Ma_so_dich_vu_luu_tru = 'LT10402'  

--TH5: Update chuyển bệnh nhân từ phòng này sang phòng khác (Đã đầy)
UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB20101'
WHERE Ma_so_dich_vu_luu_tru = 'LT10602'

UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB20101'
WHERE Ma_so_dich_vu_luu_tru = 'LT10802'
(Mã số lưu trú bên trên ko tồn tại)


--TH5: Update Bệnh nhân không tồn tại  
--(Ko cần thiết do kiểu j cx (0 rows affected)
-- Khi đó ko có dữ liệu nào đc thêm zo bảng inserted hay bảng deleted 
--> Sẽ chả bao h có trigger nào chạy đc nếu (0 rows affected)
UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET So_phong = 'PB20101'
WHERE Ma_so_dich_vu_luu_tru = 'LT10802'


--TH6: Thêm bệnh nhân (còn hạn DV Lưu trú)
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
VALUES('LT11111', 'BS00001', 'LDBV11111', 'LT')

----Có j update ở đây
INSERT INTO dbo.dich_vu_luu_tru(Ma_so, Ngay_bat_dau, Ngay_ket_thuc, Tong_chi_phi, Tien_nghi)
VALUES ('LT11111', '2024-04-25', '2024-04-30',2500000,'Phòng 4 người')

UPDATE dbo.dich_vu_luu_tru
SET Ngay_ket_thuc = '2024-05-30'
WHERE Ma_so = 'LT11111'
(QUá ngày - quá hạn DV lưu trú) 
INSERT INTO dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru(So_phong, Ma_so_dich_vu_luu_tru)
VALUES('PB40101', 'LT11111')







DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE Ma_so_dich_vu_luu_tru = 'LT11111'

DELETE FROM dbo.dich_vu_luu_tru
WHERE Ma_so = 'LT11111'

DELETE FROM dbo.lan_su_dung_dich_vu
WHERE Ma_so = 'LT11111'

DELETE FROM dbo.lan_di_benh_vien WHERE Ma_so_lan_di_benh_vien = 'LDBV11111'

DELETE FROM dbo.benh_nhan WHERE Ma_benh_nhan = 'BN11111'


--TH7: Xóa bệnh nhân (Tất cả loại Bệnh nhân)

--Th8: Update bệnh nhân còn hạn thành hết hạn 


--TH9: Update Gia hạn (Từ hết hạn thành còn hạn)