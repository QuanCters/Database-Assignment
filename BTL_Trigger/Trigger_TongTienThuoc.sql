DROP TRIGGER trg_Insert_don_thuoc_gom_thuoc
DROP TRIGGER trg_Delete_don_thuoc_gom_thuoc
DROP TRIGGER trg_Update_don_thuoc_gom_thuoc


CREATE TRIGGER trg_Insert_don_thuoc_gom_thuoc
ON don_thuoc_gom_thuoc
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Ngay_hom_nay DATE = GETDATE();
    DECLARE @Ngay_di_kham DATE;

	-- Ngày đi khám có thỏa điều kiện vượt quá 7 ngày không?
    SELECT @Ngay_di_kham = l.Ngay
    FROM inserted i
    INNER JOIN dich_vu_kham_benh dvk ON i.Ma_don_thuoc = dvk.Ma_so
    INNER JOIN lan_su_dung_dich_vu lsdd ON dvk.Ma_so = lsdd.Ma_so
    INNER JOIN lan_di_benh_vien l ON lsdd.Ma_so_lan_di_benh_vien = l.Ma_so_lan_di_benh_vien;

    IF DATEDIFF(day, @Ngay_di_kham, @Ngay_hom_nay) > 7
    BEGIN
        RAISERROR(N'Không được phép thêm đơn thuốc sau 7 ngày kể từ ngày khám bệnh!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    DECLARE @Tong_tien_thuoc INT;

    --Số lượng nhập vào không được phép là giá trị  âm
    IF EXISTS (SELECT 1 FROM inserted WHERE So_luong <= 0)
    BEGIN
        RAISERROR(N'Số lượng phải là số nguyên dương!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Tính tổng tiền thuốc khi được insert
    SELECT @Tong_tien_thuoc = SUM(i.So_luong * t.Gia_ban)
    FROM inserted i
    INNER JOIN thuoc t ON i.Ma_thuoc = t.Ma_thuoc;

    -- Update lại tổng tiền thuốc (Thành tiền) trong bảng don_thuoc
    UPDATE don_thuoc
    SET Tong_tien_thuoc = ISNULL(Tong_tien_thuoc, 0) + @Tong_tien_thuoc
    WHERE Ma_don_thuoc IN (SELECT Ma_don_thuoc FROM inserted);
END;



--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER trg_Delete_don_thuoc_gom_thuoc
ON don_thuoc_gom_thuoc
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Ngay_hom_nay DATE = GETDATE();
    DECLARE @Ngay_di_kham DATE;
    
    -- Ko cho phép xoá đơn thuốc sau 7 ngày kể từ Ngày đi khám
    SELECT @Ngay_di_kham = l.Ngay
    FROM deleted d
    INNER JOIN don_thuoc dt ON d.Ma_don_thuoc = dt.Ma_don_thuoc
    INNER JOIN dich_vu_kham_benh dvk ON dt.Ma_so = dvk.Ma_so
    INNER JOIN lan_su_dung_dich_vu lsdd ON dvk.Ma_so = lsdd.Ma_so
    INNER JOIN lan_di_benh_vien l ON lsdd.Ma_so_lan_di_benh_vien = l.Ma_so_lan_di_benh_vien;

    IF DATEDIFF(day, @Ngay_di_kham, @Ngay_hom_nay) > 7
    BEGIN
        RAISERROR(N'Không được phép xóa đơn thuốc sau 7 ngày kể từ ngày khám bệnh!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    IF NOT EXISTS (SELECT 1 FROM thuoc WHERE Ma_thuoc IN (SELECT Ma_thuoc FROM deleted))
    BEGIN
        RAISERROR(N'Không thể xóa thuốc không tồn tại khỏi đơn thuốc', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    DECLARE @Tong_tien_thuoc INT;

    -- Tính sô tiền bị giảm đi khi xoá Số lượng/Giá bán/đơn thuốc 
    SELECT @Tong_tien_thuoc = SUM(d.So_luong * t.Gia_ban)
    FROM deleted d
    INNER JOIN thuoc t ON d.Ma_thuoc = t.Ma_thuoc;

    -- Update lại tổng tiền thuốc (Thành tiền) trong bảng don_thuoc
    UPDATE don_thuoc
    SET Tong_tien_thuoc = CASE 
	WHEN (Tong_tien_thuoc - @Tong_tien_thuoc) < 0 THEN 0 
	ELSE (Tong_tien_thuoc - @Tong_tien_thuoc) END
    WHERE Ma_don_thuoc IN (SELECT Ma_don_thuoc FROM deleted);
END;

---------------------------------------------------------------------------------------------------------

CREATE TRIGGER trg_Update_don_thuoc_gom_thuoc
ON don_thuoc_gom_thuoc
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Ngay_hom_nay DATE = GETDATE();
    DECLARE @Ngay_di_kham DATE;
    DECLARE @dateDifference INT;
    
    -- Ko cho phép thay đổi đơn thuốc sau 7 ngày kể từ Ngày đi khám
    SELECT @Ngay_di_kham = l.Ngay
    FROM inserted i
    INNER JOIN don_thuoc dt ON i.Ma_don_thuoc = dt.Ma_don_thuoc
    INNER JOIN dich_vu_kham_benh dvk ON dt.Ma_so = dvk.Ma_so
    INNER JOIN lan_su_dung_dich_vu lsdv ON dvk.Ma_so = lsdv.Ma_so
    INNER JOIN lan_di_benh_vien l ON lsdv.Ma_so_lan_di_benh_vien = l.Ma_so_lan_di_benh_vien;

    SET @dateDifference = DATEDIFF(day, @Ngay_di_kham, @Ngay_hom_nay);


    IF @dateDifference > 7
    BEGIN
        RAISERROR(N'Không được phép thay đổi đơn thuốc sau 7 ngày kể từ ngày khám bệnh!', 16, 1);
        ROLLBACK TRANSACTION;
    END

    IF EXISTS (SELECT 1 FROM inserted WHERE So_luong <= 0)
    BEGIN
        RAISERROR(N'Số lượng phải là số nguyên dương!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    DECLARE @Tong_tien_thuoc_old INT, @Tong_tien_thuoc_new INT;

    -- Tiền thuốc trước khi thay đổi
    SELECT @Tong_tien_thuoc_old = SUM(d.So_luong * t.Gia_ban)
    FROM deleted d
    INNER JOIN thuoc t ON d.Ma_thuoc = t.Ma_thuoc;

    -- Tiền thuốc sau khi thay đổi
    SELECT @Tong_tien_thuoc_new = SUM(i.So_luong * t.Gia_ban)
    FROM inserted i
    INNER JOIN thuoc t ON i.Ma_thuoc = t.Ma_thuoc;

    -- Update lại Tổng tiền thuốc (Thành tiền)
    UPDATE don_thuoc
    SET Tong_tien_thuoc = CASE 
        WHEN (Tong_tien_thuoc - @Tong_tien_thuoc_old + @Tong_tien_thuoc_new) < 0 THEN 0 
        ELSE (Tong_tien_thuoc - @Tong_tien_thuoc_old + @Tong_tien_thuoc_new) END
    WHERE Ma_don_thuoc IN (SELECT Ma_don_thuoc FROM inserted);
END
