DROP TRIGGER trg_Insert_don_thuoc_gom_thuoc
DROP TRIGGER trg_Delete_don_thuoc_gom_thuoc
DROP TRIGGER trg_Update_don_thuoc_gom_thuoc


CREATE TRIGGER trg_Insert_don_thuoc_gom_thuoc
ON don_thuoc_gom_thuoc
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @today DATE = GETDATE();
    DECLARE @visitDate DATE;

    -- Check the visit date
    SELECT @visitDate = l.Ngay
    FROM inserted i
    INNER JOIN dich_vu_kham_benh dvk ON i.Ma_don_thuoc = dvk.Ma_so
    INNER JOIN lan_su_dung_dich_vu lsdd ON dvk.Ma_so = lsdd.Ma_so
    INNER JOIN lan_di_benh_vien l ON lsdd.Ma_so_lan_di_benh_vien = l.Ma_so_lan_di_benh_vien;

    IF DATEDIFF(day, @visitDate, @today) > 7
    BEGIN
        RAISERROR(N'Không được phép thêm đơn thuốc sau 7 ngày kể từ ngày khám bệnh!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    DECLARE @totalCost INT;

    -- Check for positive integer in So_luong
    IF EXISTS (SELECT 1 FROM inserted WHERE So_luong <= 0)
    BEGIN
        RAISERROR(N'Số lượng phải là số nguyên dương!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Calculate the total cost of the inserted medicine
    SELECT @totalCost = SUM(i.So_luong * t.Gia_ban)
    FROM inserted i
    INNER JOIN thuoc t ON i.Ma_thuoc = t.Ma_thuoc;

    -- Update the total cost in the don_thuoc table
    UPDATE don_thuoc
    SET Tong_tien_thuoc = ISNULL(Tong_tien_thuoc, 0) + @totalCost
    WHERE Ma_don_thuoc IN (SELECT Ma_don_thuoc FROM inserted);
END;

--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER trg_Delete_don_thuoc_gom_thuoc
ON don_thuoc_gom_thuoc
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @today DATE = GETDATE();
    DECLARE @visitDate DATE;
    
    -- Check the visit date
    SELECT @visitDate = l.Ngay
    FROM deleted d
    INNER JOIN don_thuoc dt ON d.Ma_don_thuoc = dt.Ma_don_thuoc
    INNER JOIN dich_vu_kham_benh dvk ON dt.Ma_so = dvk.Ma_so
    INNER JOIN lan_su_dung_dich_vu lsdd ON dvk.Ma_so = lsdd.Ma_so
    INNER JOIN lan_di_benh_vien l ON lsdd.Ma_so_lan_di_benh_vien = l.Ma_so_lan_di_benh_vien;

    IF DATEDIFF(day, @visitDate, @today) > 7
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

    DECLARE @totalCost INT;

    -- Calculate the cost to be deducted
    SELECT @totalCost = SUM(d.So_luong * t.Gia_ban)
    FROM deleted d
    INNER JOIN thuoc t ON d.Ma_thuoc = t.Ma_thuoc;

    -- Update the total cost in the don_thuoc table
    UPDATE don_thuoc
    SET Tong_tien_thuoc = CASE 
	WHEN (Tong_tien_thuoc - @totalCost) < 0 THEN 0 
	ELSE (Tong_tien_thuoc - @totalCost) END
    WHERE Ma_don_thuoc IN (SELECT Ma_don_thuoc FROM deleted);
END;

---------------------------------------------------------------------------------------------------------
CREATE TRIGGER trg_Update_don_thuoc_gom_thuoc
ON don_thuoc_gom_thuoc
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @today DATE = GETDATE();
    DECLARE @visitDate DATE;

    -- Check the visit date
    SELECT @visitDate = l.Ngay
    FROM inserted i
    INNER JOIN dich_vu_kham_benh dvk ON i.Ma_don_thuoc = dvk.Ma_so
    INNER JOIN lan_su_dung_dich_vu lsdd ON dvk.Ma_so = lsdd.Ma_so
    INNER JOIN lan_di_benh_vien l ON lsdd.Ma_so_lan_di_benh_vien = l.Ma_so_lan_di_benh_vien;

    IF DATEDIFF(day, @visitDate, @today) > 7
    BEGIN
        RAISERROR(N'Không được phép thay đổi đơn thuốc sau 7 ngày kể từ ngày khám bệnh!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END



	IF NOT EXISTS (SELECT 1 FROM thuoc WHERE Ma_thuoc IN (SELECT Ma_thuoc FROM inserted))
    BEGIN
        RAISERROR(N'Không thể thay đổi thuốc không tồn tại trong đơn thuốc', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

	IF EXISTS (SELECT 1 FROM inserted WHERE So_luong <= 0)
    BEGIN
        RAISERROR(N'Số lượng phải là số nguyên dương!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Variables to store costs
    DECLARE @oldCost INT, @newCost INT;

    -- Calculate old costs (before the update)
    SELECT @oldCost = SUM(d.So_luong * t.Gia_ban)
    FROM deleted d
    INNER JOIN thuoc t ON d.Ma_thuoc = t.Ma_thuoc;

    -- Calculate new costs (after the update)
    SELECT @newCost = SUM(i.So_luong * t.Gia_ban)
    FROM inserted i
    INNER JOIN thuoc t ON i.Ma_thuoc = t.Ma_thuoc;

    -- Update the don_thuoc table
    UPDATE don_thuoc
    SET Tong_tien_thuoc = CASE 
		WHEN (Tong_tien_thuoc - @oldCost + @newCost) < 0 THEN 0 
		ELSE (Tong_tien_thuoc - @oldCost + @newCost) END
    WHERE Ma_don_thuoc IN (SELECT Ma_don_thuoc FROM inserted);
END;
