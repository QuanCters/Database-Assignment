use assignment2 
go
CREATE FUNCTION Han_Su_Dung_BHYT (@ma_bhyt char(13))
RETURNS BIT
AS 
BEGIN
	
	DECLARE @Con_Han BIT
	DECLARE @Khoang_Thoi_Gian INT
	DECLARE @Ngay_het_han DATE
	SELECT @Ngay_het_han = the_bhyt.Ngay_dang_ky FROM the_bhyt WHERE @ma_bhyt = the_bhyt.Ma_bhyt;
	SET @Khoang_Thoi_Gian = DATEDIFF(YEAR, @Ngay_het_han, GETDATE())
	IF @Khoang_Thoi_Gian <= 5
		SET @Con_Han = 1
	ELSE 
		SET @Con_Han = 0

	RETURN @Con_Han
END;
GO
--testcase 
SELECT dbo.Han_Su_Dung_BHYT('SV00000000001') as Result1;
SELECT dbo.Han_Su_Dung_BHYT('SV00000000002') as Result2;
SELECT dbo.Han_Su_Dung_BHYT('SV00000000003') as Result3;
SELECT dbo.Han_Su_Dung_BHYT('SV00000000004') as Result4;
SELECT dbo.Han_Su_Dung_BHYT('SV00000000005') as Result5;