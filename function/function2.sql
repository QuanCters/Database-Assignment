USE assignment2;
GO
DROP FUNCTION IF EXISTS f_calculateBMI;
GO
CREATE FUNCTION f_calculateBMI (@Can_nang FLOAT, @Chieu_cao INT)
RETURNS FLOAT AS 
BEGIN 
	DECLARE @bmi AS FLOAT;
	SET @bmi = -1;
	SELECT @bmi = @Can_nang / POWER(@Chieu_cao / 100.0,2);
	RETURN @bmi;
END;
GO
-- testcase 
SELECT assignment2.dbo.f_calculateBMI(59,173) as bmi;

