USE assignment2;
GO

CREATE PROCEDURE  update_luong_nhan_vien (
	@Ma_so_nhan_vien CHAR(10),
	@Muc_tang INT,
	@Luong_moi INT OUTPUT
)
AS
BEGIN
	IF NOT EXISTS (
		SELECT * 
		FROM nhan_vien 
		WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien
	)
	BEGIN
		PRINT 'Cap nhat luong nhan viên khong thanh cong do khong tim thay nhan vien';
		SET @Luong_moi = NULL;
		RETURN 0;
	END;

	IF @Muc_tang <= 0
	BEGIN
		PRINT 'Cap nhat luong nhan vien khong thanh cong do muc tang luong khong the nho hon hoac bang 0%';
		SET @Luong_moi = NULL;
		RETURN 0;
	END;

	IF @Muc_tang > 100
	BEGIN
		PRINT 'Cap nhat luong nhan vien khong thanh cong do muc tang luong khong the lon hon 100%';
		SET @Luong_moi = NULL;
		RETURN 0;
	END;

	UPDATE nhan_vien
    SET @Luong_moi = Luong * (1 + (@Muc_tang / 100.0)),
        Luong = @Luong_moi
    WHERE Ma_so_nhan_vien = @Ma_so_nhan_vien;

	PRINT 'Cap nhat luong nhan vien thanh cong.';
END;

