USE assignment2;
GO

EXEC insert_nhan_vien 
	@Ma_so_nhan_vien = '0013456709',
	@CCCD = '079304017771',
	@Ho = 'Nguyen',
	@Ten = 'Nhu',
	@Gioi_tinh = 'Nu',
	@Dia_chi = '30/14 XVNT, Phuong 19, Quan	Binh Thanh, TPHCM, Viet Nam',
	@Email = 'nhu.nguyenquynh0109@hcmut.edu.vn',
	@Ngay_ky_hop_dong = '2024-04-16',
	@Luong = 50000000,
	@Ngay_sinh = '2004-08-23',
	@SDT = '0123456789';

EXEC update_luong_nhan_vien 
	@Ma_so_nhan_vien = '0123456789',
	@Muc_tang = 5;

DECLARE @newSalary INT;
EXEC update_luong_nhan_vien 
	@Ma_so_nhan_vien = '0013456789',
	@Muc_tang = 10,
	@Luong_moi=@newSalary OUTPUT;

PRINT @newSalary;

EXEC delete_nhan_vien
	@Ma_so_nhan_vien = '0123456789';

SELECT * FROM nhan_vien;

DELETE FROM nhan_vien;