use assignment2
GO
DROP FUNCTION IF EXISTS Lan_kham_gan_nhat 
go
CREATE FUNCTION Lan_kham_gan_nhat()
RETURNS @Danh_sach TABLE (
	ID CHAR(10),
	Ho_ten NVARCHAR(60),
	SĐT CHAR(10),
	Ngay_hen DATE,
	Gio_hen TIME
)
AS
BEGIN
	DECLARE @ID_benh_nhan CHAR(10);
	DECLARE @Ho NVARCHAR(20);
	DECLARE @Ten NVARCHAR(40);
	DECLARE @SDT CHAR(10);
	DECLARE @Ho_ten NVARCHAR(60);
	DECLARE @Ngay_hen DATE;
	DECLARE @Gio_hen TIME;

	DECLARE ID_Cursor CURSOR FOR
	SELECT Ma_benh_nhan
	FROM benh_nhan;

	OPEN ID_Cursor;
	FETCH NEXT FROM ID_Cursor INTO @ID_benh_nhan;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT 
			@Ho = Ho,
			@Ten = Ten,
			@SDT = SDT
		FROM 
			benh_nhan 
		WHERE 
			Ma_benh_nhan = @ID_benh_nhan;
		SET @Ho_ten = RTRIM(@Ho) + ' ' + RTRIM(@Ten);
		SELECT 
			@Ngay_hen = CONVERT(DATE, MAX(ngay)),
			@Gio_hen = CONVERT(TIME, MAX(Gio))
		FROM 
			lan_di_benh_vien
		WHERE
			Ma_benh_nhan = @ID_benh_nhan;
		INSERT INTO @Danh_sach VALUES (@ID_benh_nhan, @Ho_ten, @SDT, @Ngay_hen, @Gio_hen);
		FETCH NEXT FROM ID_Cursor INTO @ID_benh_nhan;

	END
	CLOSE ID_Cursor
	DEALLOCATE ID_Cursor
	RETURN
END
GO
SELECT * FROM Lan_kham_gan_nhat()
