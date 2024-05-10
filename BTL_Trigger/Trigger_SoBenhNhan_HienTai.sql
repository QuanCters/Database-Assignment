DROP TRIGGER UpdateSoLuongBenhNhan_phongBenh
DROP TRIGGER UpdateDeleteSoLuongBenhNhan_phongBenh

DROP TRIGGER SoLuongBN_HienTai_NgayKetThuc
GO 
USE assignment2

------ TỰ ĐỘNG TĂNG SoLuongBN_HienTai khi insert đúng vào table dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
CREATE TRIGGER UpdateSoLuongBenhNhan_phongBenh
ON dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
FOR INSERT
AS
BEGIN
    DECLARE @SoBenhNhan INT;
    DECLARE @LoaiPhong INT;
    DECLARE @NgayKetThuc DATE;
    
    SELECT @SoBenhNhan = pb.So_luong_benh_nhan_hien_tai, 
           @LoaiPhong = pb.Loai_phong,
           @NgayKetThuc = dvlt.Ngay_ket_thuc
    FROM dbo.phong_benh pb
    INNER JOIN inserted i ON i.So_phong = pb.So_phong
    INNER JOIN dbo.dich_vu_luu_tru dvlt ON dvlt.Ma_so = i.Ma_so_dich_vu_luu_tru;

    IF @NgayKetThuc < GETDATE()
    BEGIN
        PRINT N'Không thể thêm bệnh nhân vào phòng bệnh do đã hết hạn DV lưu trú';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Check phòng bệnh đã full ch? 
    IF @SoBenhNhan >= @LoaiPhong
    BEGIN
        RAISERROR(N'Phòng đã đủ số lượng - Vui lòng chọn phòng khác', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Update bệnh nhân nếu thỏa hết đkien ở trên
    ELSE
    BEGIN
        UPDATE dbo.phong_benh
        SET So_luong_benh_nhan_hien_tai = So_luong_benh_nhan_hien_tai + 1
        WHERE So_phong = (SELECT So_phong FROM inserted);
        PRINT N'Lệnh thêm bệnh nhân vào phòng bệnh hợp lệ';
    END
END;





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
		DECLARE @NgayKetThuc DATE;
   SELECT @NgayKetThuc = dvlt.Ngay_ket_thuc 
   FROM dbo.dich_vu_luu_tru dvlt 
   INNER JOIN deleted d ON d.Ma_so_dich_vu_luu_tru = dvlt.Ma_so;

		   IF @NgayKetThuc < GETDATE()
		   BEGIN
			   PRINT N'Không thể xóa/thay đổi bệnh nhân khỏi phòng bệnh do đã hết hạn DV lưu trú';
			   ROLLBACK TRANSACTION;
			   RETURN;
		   END
        IF NOT EXISTS (SELECT * FROM inserted) 
        BEGIN
            DECLARE @SoPhong_DEL CHAR(10);
			DECLARE @SoLuongBN_HienTai INT;
            SELECT @SoPhong_DEL = So_phong FROM deleted;
			SELECT @SoLuongBN_HienTai = So_luong_benh_nhan_hien_tai FROM dbo.phong_benh WHERE So_phong = @SoPhong_DEL;
			IF(@SoLuongBN_HienTai > 0)
				BEGIN
					 UPDATE dbo.phong_benh
					 SET So_luong_benh_nhan_hien_tai = So_luong_benh_nhan_hien_tai - 1
					 WHERE So_phong = @SoPhong_DEL;
					 PRINT N'Xóa bệnh nhân khỏi phòng bệnh thành công!';
				END
			ELSE IF(@SoLuongBN_HienTai <= 0)
				BEGIN
					UPDATE dbo.phong_benh
					SET So_luong_benh_nhan_hien_tai = 0
					WHERE So_phong = @SoPhong_DEL;
					RAISERROR(N'Xoá thất bại hoặc phòng bệnh hiện đang trống!', 16,1)
				END
        END
    END
    
    -- Trường hợp 2: Cập nhật số lượng khi có sự thay đổi vị trí dịch vụ lưu trú
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        DECLARE @SoPhong_OLD CHAR(10), @SoPhong_NEW CHAR(10);
        DECLARE @SoBenhNhan INT, @LoaiPhong INT;
        
        SELECT @SoPhong_OLD = So_phong FROM deleted;
        SELECT @SoPhong_NEW = So_phong FROM inserted;
        SELECT @SoBenhNhan = So_luong_benh_nhan_hien_tai, @LoaiPhong = Loai_phong FROM dbo.phong_benh WHERE So_phong = @SoPhong_NEW;

        IF @SoBenhNhan >= @LoaiPhong
        BEGIN
            RAISERROR(N'Phòng đã đủ số lượng - Vui lòng chọn phòng khác', 16, 1)
            ROLLBACK TRANSACTION;
        END
        ELSE
        BEGIN
            -- Giảm Số lượng BN hiện tại của phòng cũ
            UPDATE dbo.phong_benh
            SET So_luong_benh_nhan_hien_tai = CASE 
                WHEN So_luong_benh_nhan_hien_tai > 0 THEN So_luong_benh_nhan_hien_tai - 1
                ELSE 0
            END
            WHERE So_phong = @SoPhong_OLD;

            -- Tăng số lượng BN hiện tại ở phòng mới 
            UPDATE dbo.phong_benh
            SET So_luong_benh_nhan_hien_tai = So_luong_benh_nhan_hien_tai + 1
            WHERE So_phong = @SoPhong_NEW;

            PRINT N'Thay đổi phòng cho bệnh nhân thành công!';
        END
    END
END;
GO






------------------------------------------------------------------
------ TỰ ĐỘNG TĂNG/GIẢM/THAY ĐỔI SoLuongBN_HienTai khi có thao tác đến Ngay_ket_thuc của table dbo.dich_vu_luu_tru 
CREATE TRIGGER SoLuongBN_HienTai_NgayKetThuc
ON dbo.dich_vu_luu_tru
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        DECLARE @phong CHAR(10), @ngayKetThuc DATE, @soBN INT, @loaiPhong INT, @maSo CHAR(10);

        DECLARE cursor_services CURSOR FOR
        SELECT i.Ma_so, i.Ngay_ket_thuc, pbdsd.So_phong
        FROM inserted i
        INNER JOIN phong_benh_duoc_su_dung_tai_dich_vu_luu_tru pbdsd ON i.Ma_so = pbdsd.Ma_so_dich_vu_luu_tru;

        OPEN cursor_services
        FETCH NEXT FROM cursor_services INTO @maSo, @ngayKetThuc, @phong

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @soBN = So_luong_benh_nhan_hien_tai, @loaiPhong = Loai_phong FROM phong_benh WHERE So_phong = @phong;

            IF (@ngayKetThuc > GETDATE() AND @soBN < @loaiPhong)
            BEGIN
                UPDATE phong_benh
                SET So_luong_benh_nhan_hien_tai = So_luong_benh_nhan_hien_tai + 1
                WHERE So_phong = @phong;
                PRINT N'Gia hạn thành công dịch vụ lưu trú - Vui lòng kiểm tra lại trong phòng bệnh hiện tại';
            END
            ELSE IF (@ngayKetThuc > GETDATE() AND @soBN >= @loaiPhong)
            BEGIN
                PRINT N'Phòng bệnh trước đây bạn từng lưu trú hiện đã đầy, vui lòng chọn phòng khác';
				ROLLBACK TRANSACTION;
				RETURN;
            END


            IF (@ngayKetThuc <= GETDATE())
            BEGIN
                UPDATE phong_benh
                SET So_luong_benh_nhan_hien_tai = CASE 
                    WHEN So_luong_benh_nhan_hien_tai - 1 < 0 THEN 0
                    ELSE So_luong_benh_nhan_hien_tai - 1
                END
                WHERE So_phong = @phong;
                PRINT N'Kết thúc DV lưu trú thành công! - Vui lòng kiểm tra lại trong phòng bệnh hiện tại';
            END

            FETCH NEXT FROM cursor_services INTO @maSo, @ngayKetThuc, @phong
        END

        CLOSE cursor_services;
        DEALLOCATE cursor_services;
    END
END;
GO





------------------------------------------------------------------
------ TỰ ĐỘNG TĂNG/GIẢM/THAY ĐỔI SoLuongBN_HienTai khi có thao tác đến Ngay_ket_thuc của table dbo.dich_vu_luu_tru 

	
CREATE TRIGGER SoLuongBN_HienTai_NgayKetThuc
ON dbo.dich_vu_luu_tru
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        DECLARE @phong CHAR(10), @ngayKetThuc DATE, @soBN INT, @loaiPhong INT, @maSo CHAR(10);

        DECLARE cursor_services CURSOR FOR
        SELECT i.Ma_so, i.Ngay_ket_thuc, pbdsd.So_phong
        FROM inserted i
        INNER JOIN phong_benh_duoc_su_dung_tai_dich_vu_luu_tru pbdsd ON i.Ma_so = pbdsd.Ma_so_dich_vu_luu_tru;

        OPEN cursor_services
        FETCH NEXT FROM cursor_services INTO @maSo, @ngayKetThuc, @phong

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @soBN = So_luong_benh_nhan_hien_tai, @loaiPhong = Loai_phong FROM phong_benh WHERE So_phong = @phong;

            IF @ngayKetThuc > GETDATE() AND @soBN < @loaiPhong
            BEGIN
                UPDATE phong_benh
                SET So_luong_benh_nhan_hien_tai = So_luong_benh_nhan_hien_tai + 1
                WHERE So_phong = @phong;
                PRINT N'Gia hạn thành công dịch vụ lưu trú - Vui lòng kiểm tra lại trong phòng bệnh hiện tại';
            END
            ELSE IF @ngayKetThuc > GETDATE() AND @soBN >= @loaiPhong
            BEGIN
                PRINT N'Phòng bệnh trước đây bạn từng lưu trú hiện đã đầy, vui lòng chọn phòng khác';
				ROLLBACK TRANSACTION;
				RETURN;
            END


            IF @ngayKetThuc <= GETDATE()
            BEGIN
                UPDATE phong_benh
                SET So_luong_benh_nhan_hien_tai = CASE 
                    WHEN So_luong_benh_nhan_hien_tai - 1 < 0 THEN 0
                    ELSE So_luong_benh_nhan_hien_tai - 1
                END
                WHERE So_phong = @phong;
                PRINT N'Kết thúc DV lưu trú thành công! - Vui lòng kiểm tra lại trong phòng bệnh hiện tại';
            END

            FETCH NEXT FROM cursor_services INTO @maSo, @ngayKetThuc, @phong
        END

        CLOSE cursor_services;
        DEALLOCATE cursor_services;
    END
END;
GO




