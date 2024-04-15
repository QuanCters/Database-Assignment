use assignment2
go
SET DATEFORMAT dmy;
Go
CREATE FUNCTION Danh_Sach_Benh_Nhan_Theo_Gioi_Tinh(@gioi_tinh nvarchar(3))
RETURNS @Thong_Tin_Benh_Nhan TABLE 
(
	Ma_benh_nhan CHAR(10),
	CCCD CHAR(12),
	Ho NVARCHAR(20),
    Ten NVARCHAR(30),
    Dia_chi NVARCHAR(255),
    Email VARCHAR(100),
	Ngay_sinh DATE
)
AS
BEGIN
    DECLARE @Ma_benh_nhan CHAR(10)
    DECLARE @Ten NVARCHAR(30)
    DECLARE @Dia_chi NVARCHAR(255)
    DECLARE @Email VARCHAR(100)
	DECLARE @Ho NVARCHAR(20)
	DECLARE @Ngay_sinh DATE
	DECLARE @CCCD CHAR(12)

    DECLARE Benh_Nhan CURSOR FOR
    SELECT Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Ngay_sinh
    FROM benh_nhan 
	WHERE Gioi_tinh = @gioi_tinh;

    OPEN Benh_Nhan
    FETCH NEXT FROM Benh_Nhan INTO @Ma_benh_nhan, @CCCD, @Ho, @Ten, @Dia_chi, @Email, @Ngay_sinh

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO @Thong_Tin_Benh_Nhan (Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Ngay_sinh)
        VALUES (@Ma_benh_nhan, @CCCD, @Ho, @Ten, @Dia_chi, @Email, @Ngay_sinh)

        FETCH NEXT FROM Benh_Nhan INTO @Ma_benh_nhan, @CCCD, @Ho, @Ten, @Dia_chi, @Email, @Ngay_sinh
    END

    CLOSE Benh_Nhan
    DEALLOCATE Benh_Nhan

    RETURN
END
GO
--testcase
SELECT * FROM Danh_Sach_Benh_Nhan_Theo_Gioi_Tinh('Nam')
SELECT * FROM Danh_Sach_Benh_Nhan_Theo_Gioi_Tinh('Nu')