USE assignment2;
GO

CREATE PROCEDURE delete_nhan_vien (
    @Ma_so_nhan_vien CHAR(10),
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
        SET @Error = N'Xóa nhân viên không thành công do không tìm thấy nhân viên.';
		PRINT @Error;
        RETURN 0;
    END;

    DELETE FROM nhan_vien
    WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien;

    PRINT N'Xóa nhân viên thành công.';
END;