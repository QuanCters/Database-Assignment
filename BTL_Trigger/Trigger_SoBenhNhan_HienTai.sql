DROP TRIGGER UpdateSoLuongBenhNhan_phongBenh
DROP TRIGGER UpdateDeleteSoLuongBenhNhan_phongBenh

------ TỰ ĐỘNG TĂNG SoLuongBN_HienTai khi insert đúng vào table dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
CREATE TRIGGER UpdateSoLuongBenhNhan_phongBenh
ON dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
FOR INSERT
AS
BEGIN
	DECLARE @SoBenhNhan INT;
	DECLARE @LoaiPhong INT;
	SELECT @SoBenhNhan = dbo.phong_benh.So_luong_benh_nhan_hien_tai, @LoaiPhong = CAST(SUBSTRING(dbo.phong_benh.Loai_phong, 1, 1) AS INT)
	FROM dbo.phong_benh, inserted
	WHERE inserted.So_phong = dbo.phong_benh.So_phong

	IF @SoBenhNhan >= @LoaiPhong
	BEGIN
		RAISERROR(N'Phòng đã đủ số lượng - Vui lòng chọn phòng khác', 16,1)
		ROLLBACK TRANSACTION
	END

	ELSE
	BEGIN
		UPDATE dbo.phong_benh
		SET So_luong_benh_nhan_hien_tai = So_luong_benh_nhan_hien_tai + 1
		FROM inserted, dbo.phong_benh
		WHERE inserted.So_phong = dbo.phong_benh.So_phong
	END
END

DROP TRIGGER TuDongGiamSoLuongBenhNhan
GO







----------------------------------------------------------------------------
------ TỰ ĐỘNG GIẢM hoặc THAY ĐỔI SoLuongBN_HienTai khi delete/update đúng vào table dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
CREATE TRIGGER UpdateDeleteSoLuongBenhNhan_phongBenh
ON dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Trường hợp 1: Giảm số lượng khi xóa ma_so_dich_vu_luu_tru
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        IF NOT EXISTS (SELECT * FROM inserted) -- Dấu hiệu không phải là UPDATE
        BEGIN
            DECLARE @SoPhong_DEL CHAR(10);
            SELECT @SoPhong_DEL = So_phong FROM deleted;

            UPDATE dbo.phong_benh
            SET So_luong_benh_nhan_hien_tai = CASE 
                WHEN So_luong_benh_nhan_hien_tai > 0 THEN So_luong_benh_nhan_hien_tai - 1
                ELSE 0
            END
            WHERE So_phong = @SoPhong_DEL;
        END
    END
    
    -- Trường hợp 2: Cập nhật số lượng khi có sự thay đổi vị trí dịch vụ lưu trú
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        DECLARE @SoPhong_OLD CHAR(10), @SoPhong_NEW CHAR(10), @Ma_DVLT_OLD CHAR(10), @Ma_DVLT_NEW CHAR(10);
        SELECT @SoPhong_OLD = So_phong, @Ma_DVLT_OLD = Ma_so_dich_vu_luu_tru FROM deleted;
        SELECT @SoPhong_NEW = So_phong, @Ma_DVLT_NEW = Ma_so_dich_vu_luu_tru FROM inserted;

        IF @Ma_DVLT_OLD = @Ma_DVLT_NEW AND @SoPhong_OLD <> @SoPhong_NEW
        BEGIN
            -- Giảm số lượng bệnh nhân ở So_phong cũ
            UPDATE dbo.phong_benh
            SET So_luong_benh_nhan_hien_tai = CASE 
                WHEN So_luong_benh_nhan_hien_tai > 0 THEN So_luong_benh_nhan_hien_tai - 1
                ELSE 0
            END
            WHERE So_phong = @SoPhong_OLD;

            -- Tăng số lượng bệnh nhân ở So_phong mới
            UPDATE dbo.phong_benh
            SET So_luong_benh_nhan_hien_tai = So_luong_benh_nhan_hien_tai + 1
            WHERE So_phong = @SoPhong_NEW;
        END
    END
END;
GO



------------------------------------------------------------------
------ TỰ ĐỘNG TĂNG/GIẢM/THAY ĐỔI SoLuongBN_HienTai khi có thao tác đến Ngay_ket_thuc của table dbo.dich_vu_luu_tru 
CREATE TRIGGER trg_SyncPatientCount
ON dbo.dich_vu_luu_tru
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Xử lý trong trường hợp INSERT 
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN 
        UPDATE pb
        SET pb.So_luong_benh_nhan_hien_tai = pb.So_luong_benh_nhan_hien_tai + 1
        FROM phong_benh pb
        INNER JOIN phong_benh_duoc_su_dung_tai_dich_vu_luu_tru pbd ON pb.So_phong = pbd.So_phong
        INNER JOIN inserted i ON i.Ma_so = pbd.Ma_so_dich_vu_luu_tru
        WHERE i.Ngay_ket_thuc > GETDATE();
    END

    -- Xử lý trong trường hợp DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE pb
        SET pb.So_luong_benh_nhan_hien_tai = pb.So_luong_benh_nhan_hien_tai - 1
        FROM phong_benh pb
        INNER JOIN phong_benh_duoc_su_dung_tai_dich_vu_luu_tru pbd ON pb.So_phong = pbd.So_phong
        INNER JOIN deleted d ON d.Ma_so = pbd.Ma_so_dich_vu_luu_tru;
    END

    -- Xử lý trong trường hợp UPDATE 
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Chỉnh từ [Còn hạn lưu trú] thành hết hạn :V 
        UPDATE pb
        SET pb.So_luong_benh_nhan_hien_tai = CASE 
             WHEN i.Ngay_ket_thuc <= GETDATE() THEN pb.So_luong_benh_nhan_hien_tai - 1
             ELSE pb.So_luong_benh_nhan_hien_tai
        END
        FROM phong_benh pb
        INNER JOIN phong_benh_duoc_su_dung_tai_dich_vu_luu_tru pbd ON pb.So_phong = pbd.So_phong
        INNER JOIN inserted i ON i.Ma_so = pbd.Ma_so_dich_vu_luu_tru
        INNER JOIN deleted d ON d.Ma_so = pbd.Ma_so_dich_vu_luu_tru
        WHERE d.Ngay_ket_thuc <> i.Ngay_ket_thuc;

        -- Chỉnh từ [hết hạn] thành  [Còn hạn lưu trú] :V 
        UPDATE pb
        SET pb.So_luong_benh_nhan_hien_tai = CASE 
             WHEN i.Ngay_ket_thuc > GETDATE() THEN pb.So_luong_benh_nhan_hien_tai + 1
             ELSE pb.So_luong_benh_nhan_hien_tai
        END
        FROM phong_benh pb
        INNER JOIN phong_benh_duoc_su_dung_tai_dich_vu_luu_tru pbd ON pb.So_phong = pbd.So_phong
        INNER JOIN inserted i ON i.Ma_so = pbd.Ma_so_dich_vu_luu_tru
        INNER JOIN deleted d ON d.Ma_so = pbd.Ma_so_dich_vu_luu_tru
        WHERE d.Ngay_ket_thuc <> i.Ngay_ket_thuc;
    END
END;