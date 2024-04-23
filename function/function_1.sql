use assignment2
go
SET DATEFORMAT dmy;
Go
CREATE FUNCTION Danh_Sach_Benh_Nhan_Theo_Do_Tuoi(@Min_Age INT, @Max_Age INT)
RETURNS @Thong_Tin_Benh_Nhan TABLE 
(
	Ma_benh_nhan CHAR(10) PRIMARY KEY,
	CCCD CHAR(12),
	Ho NVARCHAR(20),
    Ten NVARCHAR(30),
    Dia_chi NVARCHAR(255),
    Email VARCHAR(100),
	Gioi_tinh NVARCHAR(3),
	Ngay_sinh DATE
)
AS
BEGIN
	DECLARE @Ma_benh_nhan CHAR(10)
	DECLARE @CCCD CHAR(12)
	DECLARE @Ho NVARCHAR(20)
    DECLARE @Ten NVARCHAR(30)
    DECLARE @Dia_chi NVARCHAR(255)
    DECLARE @Email VARCHAR(100)
	DECLARE @Gioi_tinh NVARCHAR(3)
	DECLARE @Ngay_sinh DATE

	DECLARE Age_Cursor CURSOR FOR 
	SELECT	Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh
	FROM benh_nhan
	WHERE DATEDIFF(YEAR, Ngay_sinh, GETDATE()) BETWEEN @Min_Age AND @Max_Age

	OPEN Age_Cursor
	FETCH NEXT FROM Age_Cursor INTO @Ma_benh_nhan, @CCCD, @Ho, @Ten, @Dia_chi, @Email, @Gioi_tinh, @Ngay_sinh

	WHILE @@FETCH_STATUS = 0
	BEGIN 
		INSERT INTO @Thong_Tin_Benh_Nhan (Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh)
		VALUES (@Ma_benh_nhan, @CCCD, @Ho, @Ten, @Dia_chi, @Email, @Gioi_tinh, @Ngay_sinh)

		FETCH NEXT FROM Age_Cursor INTO @Ma_benh_nhan, @CCCD, @Ho, @Ten, @Dia_chi, @Email, @Gioi_tinh, @Ngay_sinh
	END

	CLOSE Age_Cursor
	DEALLOCATE Age_Cursor

	RETURN
END
GO


--DATA
/*
INSERT INTO benh_nhan (Ma_benh_nhan, CCCD, Ho, Ten, Dia_chi, Email, Gioi_tinh, Ngay_sinh) VALUES
('BN001', N'Nguyễn', N'An', '2019-03-15'),
('BN002', N'Phạm', N'Bảo', '2018-07-20'),
('BN003', N'Trần', N'Chi', '2017-10-10'),
('BN004', N'Lê', N'Duy', '2016-05-05'),
('BN005', N'Huỳnh', N'Hà', '2015-09-25'),
('BN006', N'Võ', N'Đạt', '2014-12-30'),
('BN007', N'Dương', N'Gia', '2013-02-28'),
('BN008', N'Đặng', N'Hải', '2012-11-12'),
('BN009', N'Bùi', N'Thư', '2011-08-08'),
('BN010', N'Hoàng', N'Trung', '2010-04-01'),
('BN011', '123456789012', N'Nguyễn', N'Văn A', N'Hà Nội', 'nguyenvana@example.com', 'Nam', '1945-05-10'),
('BN012', '234567890123', N'Trần', N'Thị B', N'Hồ Chí Minh', 'tranthib@example.com', 'Nu', '1943-08-22'),
('BN013', '345678901234', N'Lê', N'Tuấn C', N'Đà Nẵng', 'letuanc@example.com', 'Nam', '1940-12-15'),
('BN014', '456789012345', N'Phạm', N'Thị D', N'Hải Phòng', 'phamthid@example.com', 'Nu', '1938-10-30'),
('BN015', '567890123456', N'Ngô', N'Hoàng E', N'Bình Dương', 'ngohoange@example.com', 'Nam', '1937-07-05'),
('BN016', '678901234567', N'Đinh', N'Thị F', N'Đồng Nai', 'dinhthif@example.com', 'Nu', '1935-03-18'),
('BN017', '789012345678', N'Vũ', N'Tuấn G', N'Cần Thơ', 'vutuang@example.com', 'Nam', '1933-11-25'),
('BN018', '890123456789', N'Bùi', N'Thị H', N'Hải Dương', 'buithih@example.com', 'Nu', '1930-09-08'),
('BN019', '901234567890', N'Đặng', N'Hoàng I', N'Thái Nguyên', 'danghoangi@example.com', 'Nam', '1928-04-13'),
('BN020', '012345678901', N'Hồ', N'Thị K', N'Lào Cai', 'hothik@example.com', 'Nu', '1926-01-20'),
('BN021', '123456789111', N'Nguyễn', N'A', N'123 Đường ABC, Quận XYZ, Thành phố HCM', 'nguyenvana3@example.com', N'Nu', '1993-08-17'),
('BN022', '234567890222', N'Trần', N'B', N'456 Đường XYZ, Quận ABC, Thành phố HCM', 'tranthib3@example.com', N'Nu', '1985-09-20'),
('BN023', '345678901333', N'Lê', N'C', N'789 Đường MNO, Quận DEF, Thành phố HCM', 'lethic3@example.com', N'Nu', '1978-11-12'),
('BN024', '456789012444', N'Phạm', N'D', N'101 Đường GHI, Quận JKL, Thành phố HCM', 'phamvand3@example.com', N'Nam', '2000-03-25'),
('BN025', '567890123555', N'Hoàng', N'E', N'111 Đường RST, Quận UVW, Thành phố HCM', 'hoangthie3@example.com', N'Nu', '1995-07-08'),
('BN026', '678901234666', N'Mai', N'F', N'222 Đường QWE, Quận TYU, Thành phố HCM', 'maivanf3@example.com', N'Nam', '1982-02-18'),
('BN027', '789012345777', N'Vũ', N'G', N'333 Đường ZXC, Quận BNM, Thành phố HCM', 'vuthig3@example.com', N'Nu', '1989-04-30'),
('BN028', '890123456888', N'Lý', N'H', N'444 Đường PLK, Quận OIU, Thành phố HCM', 'lyvanh3@example.com', N'Nam', '1976-08-03'),
('BN029', '901234567999', N'Dương', N'I', N'555 Đường YUI, Quận WER, Thành phố HCM', 'duongthii3@example.com', N'Nu', '1992-12-07'),
('BN030', '012345678000', N'Ngô', N'K', N'666 Đường ASD, Quận FGH, Thành phố HCM', 'ngovank3@example.com', N'Nam', '1987-06-10'),
('BN031', '123456789111', N'Nguyễn', N'L', N'123 Đường ABC, Quận XYZ, Thành phố HCM', 'nguyenvana4@example.com', N'Nu', '1993-08-17'),
('BN032', '234567890222', N'Trần', N'M', N'456 Đường XYZ, Quận ABC, Thành phố HCM', 'tranthib4@example.com', N'Nu', '1985-09-20'),
('BN033', '345678901333', N'Lê', N'N', N'789 Đường MNO, Quận DEF, Thành phố HCM', 'lethic4@example.com', N'Nu', '1978-11-12'),
('BN034', '456789012444', N'Phạm', N'O', N'101 Đường GHI, Quận JKL, Thành phố HCM', 'phamvand4@example.com', N'Nam', '2000-03-25'),
('BN035', '567890123555', N'Hoàng', N'P', N'111 Đường RST, Quận UVW, Thành phố HCM', 'hoangthie4@example.com', N'Nu', '1995-07-08'),
('BN036', '678901234666', N'Mai', N'Q', N'222 Đường QWE, Quận TYU, Thành phố HCM', 'maivanf4@example.com', N'Nam', '1982-02-18'),
('BN037', '789012345777', N'Vũ', N'R', N'333 Đường ZXC, Quận BNM, Thành phố HCM', 'vuthig4@example.com', N'Nu', '1989-04-30'),
('BN038', '890123456888', N'Lý', N'S', N'444 Đường PLK, Quận OIU, Thành phố HCM', 'lyvanh4@example.com', N'Nam', '1976-08-03'),
('BN039', '901234567999', N'Dương', N'T', N'555 Đường YUI, Quận WER, Thành phố HCM', 'duongthii4@example.com', N'Nu', '1992-12-07'),
('BN040', '012345678000', N'Ngô', N'U', N'666 Đường ASD, Quận FGH, Thành phố HCM', 'ngovank4@example.com', N'Nam', '1987-06-10');
*/

-- TESTCASE
SELECT * FROM Danh_Sach_Benh_Nhan_Theo_Do_Tuoi(0, 6)
SELECT * FROM Danh_Sach_Benh_Nhan_Theo_Do_Tuoi(75, 100)
SELECT * FROM Danh_Sach_Benh_Nhan_Theo_Do_Tuoi(18,40)