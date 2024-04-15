use assignment2 
go
DROP FUNCTION IF EXISTS Thoi_Han_Luu_Tru;
go
CREATE FUNCTION Thoi_Han_Luu_Tru(@id_benh_nhan char(10))
RETURNS VARCHAR(50)
AS 
BEGIN 
	DECLARE @result VARCHAR(50);
	DECLARE @ngay_ket_thuc DATE;
	DECLARE @ngay_bat_dau DATE;
	DECLARE @thoi_gian_con_lai VARCHAR(50);

	SELECT @ngay_bat_dau = dich_vu_luu_tru.Ngay_bat_dau, @ngay_ket_thuc = dich_vu_luu_tru.Ngay_ket_thuc
	FROM dich_vu_luu_tru, lan_su_dung_dich_vu, lan_di_benh_vien, benh_nhan
	WHERE 
	dich_vu_luu_tru.Ma_so = lan_su_dung_dich_vu.Ma_so 
	AND lan_su_dung_dich_vu.Ma_so_lan_di_benh_vien = lan_di_benh_vien.Ma_so
	AND	lan_di_benh_vien.Ma_benh_nhan = benh_nhan.Ma_benh_nhan

	SET @thoi_gian_con_lai = DATEDIFF(MONTH, GETDATE(), @ngay_ket_thuc)

	IF @thoi_gian_con_lai < 0
		SET @result = 'Dich vu luu tru da het han';
	ELSE IF @thoi_gian_con_lai = 0
		SET @result = 'Dich vu luu tru sap het han';
	ELSE 
		SET @result = 'Con lai' + CAST( @thoi_gian_con_lai AS VARCHAR(10)) + 'thang';
	RETURN @result;
END
go

--testcase
SELECT dbo.Thoi_Han_Luu_Tru(0000000001) as result1;