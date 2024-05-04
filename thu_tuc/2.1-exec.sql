USE assignment2;

DECLARE @error_output NVARCHAR(255);

EXEC insert_nhan_vien 
    @Ma_so_nhan_vien = '0013456703',
    @CCCD = '079304017771',
    @Ho = 'Nguyen',
    @Ten = 'Nhu',
    @Gioi_tinh = N'Nữ',
    @Dia_chi = N'30/14 XVNT, Phuong 19, Quan Binh Thanh, TPHCM, Việt Nam',
    @Email = 'nhu.nguyenquynh0109@hcmut.edu.vn',
    @Ngay_ky_hop_dong = '2024-04-16',
    @Luong = 50000000,
    @Ngay_sinh = '2004-08-23',
    @SDT = '0123456789',
	@Error =  @error_output OUTPUT;

PRINT @error_output;




DECLARE @newSalary INT;
DECLARE @error_output_2 NVARCHAR(255);

EXEC update_luong_nhan_vien 
	@Ma_so_nhan_vien = '0013456703',
	@Muc_tang = 20,
	@Luong_moi=@newSalary OUTPUT,
	@Error = @error_output_2 OUTPUT;

PRINT @newSalary;
PRINT @error_output_2;

DECLARE @error_output_3 NVARCHAR(255);
EXEC delete_nhan_vien
	@Ma_so_nhan_vien = '0123456789',
	@Error = @error_output_3 OUTPUT; 

PRINT @error_output_3;

SELECT * FROM nhan_vien;

DELETE FROM nhan_vien;