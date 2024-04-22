use assignment2
go

CREATE FUNCTION Tim_Lich_Trong ( @Ho NCHAR(20), @Ten NCHAR(10), @Ngay DATE )
RETURNS TABLE
AS 
RETURN (
	DECLARE @So_hieu_ca_lam_viec CHAR(10)
	DECLARE @Gio_vao TIME
	DECLARE @Gio_tan_ca TIME

	DECLARE Lich_Trong_Cursor CURSOR FOR 
	SELECT So_hieu_ca_lam_viec, Gio_vao, Gio_tan_ca
	FROM nhan_vien, lich_lam_viec
	WHERE nhan_vien.Ten = @Ten AND nhan_vien.Ho = @Ho AND lich_lam_viec.Ngay = @Ngay

	OPEN Lich_Trong_Cursor
	FETCH NEXT FROM Lich_Trong_Cursor INTO @So_hieu_ca_lam_viec, @Gio_vao, @Gio_tan_ca

)