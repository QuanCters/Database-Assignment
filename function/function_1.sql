use assignment2;
 go
SET DATEFORMAT dmy;
GO
DROP FUNCTION IF EXISTS lich_su_kham_benh
GO
CREATE FUNCTION lich_su_kham_benh(@Ma_benh_nhan CHAR(10))
RETURNS @Lich_su TABLE(
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
	DECLARE @Ho NCHAR(20);
	DECLARE @Ten NCHAR(10);
	DECLARE @Ten_bac_si NCHAR(30);

	SET @MaBN = @Ma_benh_nhan;

	IF @MaBN IS NULL
		RETURN
	ELSE
	BEGIN
		DECLARE LDBV_Cursor CURSOR FOR
		SELECT Ma_so 
		FROM lan_di_benh_vien ldbv 
		WHERE ldbv.Ma_benh_nhan = @Ma_benh_nhan;	

		OPEN LDBV_Cursor;
		FETCH NEXT FROM LDBV_Cursor INTO @Ma_so_lan_di_BV;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @Ngay = Ngay 
			FROM lan_di_benh_vien 
			WHERE lan_di_benh_vien.Ma_so = @Ma_so_lan_di_BV

			DECLARE LSD_Cursor CURSOR FOR
			SELECT  Ma_loai_dich_vu 
			FROM lan_su_dung_dich_vu lsddv
			WHERE lsddv.Ma_so_lan_di_benh_vien = @Ma_so_lan_di_BV;

			OPEN LSD_Cursor;
			FETCH NEXT FROM LSD_Cursor INTO @Ma_loai_dich_vu;

			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @Ten_dich_vu = Ten_dich_vu 
				FROM loai_dich_vu ldv
				WHERE ldv.Ma_loai_dich_vu = @Ma_loai_dich_vu;

				SELECT @Ma_bac_si = Ma_so_nhan_vien
				FROM lan_su_dung_dich_vu 
				WHERE Ma_loai_dich_vu = @Ma_loai_dich_vu;

				SELECT @Ho = Ho
				FROM nhan_vien
				WHERE Ma_so_nhan_vien = @Ma_bac_si;

				SELECT @Ten = Ten
				FROM nhan_vien
				WHERE Ma_so_nhan_vien = @Ma_bac_si;

				SET @Ten_bac_si = @Ho + @Ten;

				INSERT INTO @Lich_su VALUES(@Ten_bac_si, @Ten_dich_vu, @Ngay);
				FETCH NEXT FROM LSD_Cursor INTO @Ma_loai_dich_vu;
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

-- INSERT INTO lan_su_dung_dich_vu VALUES 
-- ('DV001','BS001', 'LDBV001','LDV001'),
-- ('DV002','BS001','LDBV001','LDV002'),
-- ('DV003','BS002','LDBV001','LDV003');

-- INSERT INTO loai_dich_vu VALUES 
-- ('LDV001','Dich vu kham tong quat', 'NULL',250000),
-- ('LDV002','Dich vu sieu am','NULL',200000),
-- ('LDV003','Dich vu chup XQUANG CT', 'NULL',150000);



SELECT * FROM lich_su_kham_benh('BN001')
