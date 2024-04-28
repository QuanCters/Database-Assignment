USE assignment2;
GO

CREATE PROCEDURE insert_nhan_vien (
	@Ma_so_nhan_vien CHAR(10),
	@CCCD CHAR(12),
	@Ho NCHAR(12),
	@Ten NCHAR(10),
	@Gioi_tinh NVARCHAR(3),
	@Dia_chi NVARCHAR(255),
	@Email NVARCHAR(255),
	@Ngay_ky_hop_dong DATE,
	@Luong INT,
	@Ngay_sinh DATE,
	@SDT CHAR(10)
)
AS
BEGIN
	IF EXISTS (
		SELECT * 
		FROM nhan_vien 
		WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien
	)
	BEGIN
		PRINT 'Them nhân vien khong thanh cong do nhan vien do trung ma so nhan vien.';
		RETURN 0;
	END;

	IF NOT @Dia_chi LIKE '%Viet Nam%'
	BEGIN
		PRINT 'Them nhân vien khong thanh cong do nhan vien do nhan vien khong o Viet Nam.';
		RETURN 0;
	END;

	IF NOT (
		@Email LIKE '%_@__%.__%' 
		AND LEN(@Email) <= 320 
	)
	BEGIN
		PRINT 'Them nhân vien khong thanh cong do nhan vien do email khong hop le.';
		RETURN 0;
	END;

	IF DATEDIFF(YEAR, @Ngay_sinh, GETDATE()) < 18
	BEGIN 
		PRINT 'Them nhân vien khong thanh cong do nhan vien do nhan vien chua du 18 tuoi.';
		RETURN 0;
	END;

	IF LEFT(@SDT, 1) != '0' OR PATINDEX('%[^0-9]%', @SDT) > 0
	BEGIN
		PRINT 'Them nhan vien khong thanh cong do so dien thoai khong hop le.';
		RETURN 0;
	END;
	
	INSERT INTO nhan_vien
	VALUES (@Ma_so_nhan_vien, @CCCD, @Ho, @Ten, @Gioi_tinh, @Dia_chi, @Email, @Ngay_ky_hop_dong, @Luong, @Ngay_sinh, @SDT);

	

	PRINT 'Them nhan vien thanh cong';
END;


