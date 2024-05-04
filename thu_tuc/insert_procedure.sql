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
    @SDT CHAR(10),
    @Error NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET @Error = '';

    IF EXISTS (
        SELECT * 
        FROM nhan_vien 
        WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien
    )
    BEGIN
        SET @Error = N'Thêm nhân viên không thành công do nhân viên đó trùng mã số nhân viên.'
    END;

    IF NOT (@Dia_chi LIKE N'%Việt Nam%' OR @Dia_chi LIKE '% VN%')
    BEGIN
        SET @Error = @Error + CHAR(13) + CHAR(10) + N'Thêm nhân viên không thành công do nhân viên đó không ở Việt Nam.';
    END;

    IF NOT (
        @Email LIKE '%_@__%.__%' 
        AND LEN(@Email) <= 320 
    )
    BEGIN
        SET @Error = @Error + CHAR(13) + CHAR(10) + N'Thêm nhân viên không thành công do nhân viên đó email không hợp lệ.';
    END;

    IF DATEDIFF(YEAR, @Ngay_sinh, GETDATE()) < 18
    BEGIN 
        SET @Error = @Error + CHAR(13) + CHAR(10) + N'Thêm nhân viên không thành công do nhân viên đó chưa đủ 18 tuổi.';
    END;

    IF LEFT(@SDT, 1) != '0' OR PATINDEX('%[^0-9]%', @SDT) > 0
    BEGIN
        SET @Error = @Error + CHAR(13) + CHAR(10) + N'Thêm nhân viên không thành công do số điện thoại không hợp lệ.';
    END;
    
    IF NOT (@Error = '')
    BEGIN
        PRINT @Error;
        RETURN 0;
    END;

    INSERT INTO nhan_vien
    VALUES (@Ma_so_nhan_vien, @CCCD, @Ho, @Ten, @Gioi_tinh, @Dia_chi, @Email, @Ngay_ky_hop_dong, @Luong, @Ngay_sinh, @SDT);

    PRINT N'Thêm nhân viên thành công';
END;
