	use assignment2;
 go
SET DATEFORMAT mdy;
GO
DROP FUNCTION IF EXISTS lich_su_kham_benh
GO

GO
CREATE FUNCTION lich_su_kham_benh(@Ma_benh_nhan CHAR(10))
RETURNS @Lich_su TABLE(
	Ma_lan_su_dung_dich_vu CHAR(10),
	Ten_bac_si NVARCHAR(250),
	Ten_dich_vu NVARCHAR(100),
	Ngay DATE
)
AS
BEGIN
	DECLARE @Ten_dich_vu NVARCHAR(100);
	DECLARE @Ngay DATE;
	DECLARE @MaBN CHAR(10);
	DECLARE @Ma_so_lan_di_BV CHAR(10);
	DECLARE @Ma_loai_dich_vu CHAR(10);
	DECLARE @Ma_bac_si CHAR(10);
	DECLARE @Ho NVARCHAR(10);
	DECLARE @Ten NVARCHAR(20);
	DECLARE @Ten_bac_si NVARCHAR(30);
	DECLARE @Ma_lan_su_dung_dich_vu CHAR(10);

	SET @MaBN = @Ma_benh_nhan;

	IF @MaBN IS NULL
		RETURN
	ELSE
	BEGIN
		DECLARE LDBV_Cursor CURSOR FOR
		SELECT ldbv.Ma_so_lan_di_benh_vien
		FROM lan_di_benh_vien ldbv 
		WHERE ldbv.Ma_benh_nhan = @Ma_benh_nhan;	

		OPEN LDBV_Cursor;
		FETCH NEXT FROM LDBV_Cursor INTO @Ma_so_lan_di_BV;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @Ngay = Ngay 
			FROM lan_di_benh_vien 
			WHERE lan_di_benh_vien.Ma_so_lan_di_benh_vien = @Ma_so_lan_di_BV

			DECLARE LSD_Cursor CURSOR FOR
			SELECT  Ma_loai_dich_vu, Ma_so
			FROM lan_su_dung_dich_vu lsddv
			WHERE lsddv.Ma_so_lan_di_benh_vien = @Ma_so_lan_di_BV;

			OPEN LSD_Cursor;
			FETCH NEXT FROM LSD_Cursor INTO @Ma_loai_dich_vu, @Ma_lan_su_dung_dich_vu;

			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @Ten_dich_vu = Ten_dich_vu 
				FROM loai_dich_vu ldv
				WHERE ldv.Ma_loai_dich_vu = @Ma_loai_dich_vu;

				SELECT @Ma_bac_si = Ma_so_nhan_vien
				FROM lan_su_dung_dich_vu 
				WHERE Ma_loai_dich_vu = @Ma_loai_dich_vu;

				SELECT @Ho = RTRIM(Ho)
				FROM nhan_vien
				WHERE Ma_so_nhan_vien = @Ma_bac_si;

				SELECT @Ten = RTRIM(Ten)
				FROM nhan_vien
				WHERE Ma_so_nhan_vien = @Ma_bac_si;

				SET @Ten_bac_si = @Ho + ' ' + @Ten;

				INSERT INTO @Lich_su VALUES( @Ma_lan_su_dung_dich_vu, @Ten_bac_si, @Ten_dich_vu, @Ngay);
				FETCH NEXT FROM LSD_Cursor INTO @Ma_loai_dich_vu, @Ma_lan_su_dung_dich_vu;
			END
				
			CLOSE LSD_Cursor;
			DEALLOCATE LSD_Cursor;
			FETCH NEXT FROM LDBV_Cursor INTO @Ma_so_lan_di_BV;
		END
		CLOSE LDBV_Cursor;
		DEALLOCATE LDBV_Cursor;
	END
	RETURN
END
GO

SELECT * FROM lich_su_kham_benh('BN10001')

