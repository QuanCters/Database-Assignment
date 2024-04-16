USE assignment2;
GO

CREATE PROCEDURE delete_nhan_vien (
    @Ma_so_nhan_vien CHAR(10)
)
AS
BEGIN
    IF NOT EXISTS (
        SELECT * 
        FROM nhan_vien 
        WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien
    )
    BEGIN
        PRINT 'Xoa nhan viên khong thanh cong do khong tim thay nhan vien.';
        RETURN;
    END;

    DELETE FROM nhan_vien
    WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien;

    PRINT 'Xoa nhan vien thanh cong.';
END;