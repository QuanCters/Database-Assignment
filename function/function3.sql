use assignment2 
go
DROP FUNCTION IF EXISTS Danh_Sach_Benh_Nhan_Theo_Ten;
go
CREATE FUNCTION Danh_Sach_Benh_Nhan_Theo_Ten(@ten varchar(10))
RETURNS TABLE
AS 
RETURN (
	SELECT * FROM dbo.benh_nhan WHERE benh_nhan.Ten LIKE '%' + @ten + '%'
);
go

--testcase 1
SELECT * FROM Danh_Sach_Benh_Nhan_Theo_Ten('Quan');
--testcase 2
SELECT * FROM Danh_Sach_Benh_Nhan_Theo_Ten('Nhu');