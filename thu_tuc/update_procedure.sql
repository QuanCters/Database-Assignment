USE assignment2;
GO

CREATE PROCEDURE update_luong_nhan_vien (
    @Ma_so_nhan_vien CHAR(10),
    @Muc_tang INT,
    @Luong_moi INT OUTPUT,
    @Error NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET @Error = '';

    IF NOT EXISTS (
        SELECT * 
        FROM nhan_vien 
        WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien
    )
    BEGIN
        SET @Error = N'Cập nhật lương nhân viên không thành công do không tìm thấy nhân viên';
        SET @Luong_moi = NULL;
        PRINT @Error;
        RETURN 0;
    END;

    IF @Muc_tang <= 0
    BEGIN
        SET @Error = N'Cập nhật lương nhân viên không thành công do mức tăng lương không thể nhỏ hơn hoặc bằng 0%';
        SET @Luong_moi = NULL;
        PRINT @Error;
        RETURN 0;
    END;

    IF @Muc_tang > 100
    BEGIN
        SET @Error = N'Cập nhật lương nhân viên không thành công do mức tăng lương không thể lớn hơn 100%';
        SET @Luong_moi = NULL;
        PRINT @Error;
        RETURN 0;
    END;

    UPDATE nhan_vien
    SET @Luong_moi = Luong * (1 + (@Muc_tang / 100.0)),
        Luong = @Luong_moi
    WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien;

    PRINT N'Cập nhật lương nhân viên thành công.';
END;
