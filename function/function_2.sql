USE assignment2
DROP FUNCTION IF EXISTS Lich_trong 
GO

CREATE FUNCTION Lich_trong (
@Ho NCHAR(20),
@Ten NCHAR(10),
@Ngay DATE
) 
RETURNS @Lich_trong TABLE (
So_hieu_ca_lam_viec CHAR(10),
Gio_bat_dau TIME,
Gio_ket_thuc TIME
) 
AS 
BEGIN
    DECLARE @Ma_bac_si CHAR(10);

    SELECT @Ma_bac_si = Ma_so_nhan_vien
    FROM nhan_vien
    WHERE Ho = @Ho AND Ten = @Ten;
    IF @Ma_bac_si IS NULL
    BEGIN
        RETURN
    END
    ELSE
    BEGIN
        DECLARE @So_hieu_ca_lam_viec CHAR(10);
        DECLARE @Gio_vao TIME;
        DECLARE @Gio_bat_dau TIME; 
        DECLARE @Gio_tan_ca TIME;

        DECLARE Lich_Cursor CURSOR FOR
        SELECT  lich_hen_kham.So_hieu_ca_lam_viec ,Gio_den_kham
        FROM lich_hen_kham,  lich_lam_viec 
        WHERE Ma_so_nhan_vien = @Ma_bac_si AND Ngay= @Ngay;

        SELECT @Gio_tan_ca = Gio_tan_ca FROM lich_lam_viec WHERE @Ma_bac_si = Ma_so_nhan_vien AND @Ngay = Ngay;
        SELECT @Gio_vao = Gio_vao FROM lich_lam_viec WHERE @Ma_bac_si = Ma_so_nhan_vien AND @Ngay = Ngay

        OPEN Lich_Cursor;
        FETCH NEXT FROM Lich_Cursor INTO @So_hieu_ca_lam_viec, @Gio_bat_dau ;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Gio_vao != @Gio_bat_dau AND @Gio_vao != @Gio_tan_ca
            BEGIN
                WHILE @Gio_vao < @Gio_bat_dau
                BEGIN
                    INSERT INTO @Lich_trong (So_hieu_ca_lam_viec, Gio_bat_dau, Gio_ket_thuc)
                    VALUES (@So_hieu_ca_lam_viec, @Gio_vao, DATEADD(MINUTE,20,@Gio_vao));
                    SET @Gio_vao = DATEADD(MINUTE, 20, @Gio_vao)
                END
                SET @Gio_vao = DATEADD(MINUTE, 20, @Gio_vao)
            END
            ELSE
                SET @Gio_vao = DATEADD(MINUTE, 20, @Gio_vao);

            FETCH NEXT FROM Lich_Cursor INTO @So_hieu_ca_lam_viec, @Gio_bat_dau;
        END
    END
    RETURN
END

GO

SELECT * FROM Lich_trong('Nguyen', 'Van A', '2023-01-02');