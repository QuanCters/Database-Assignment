USE assignment2
DROP FUNCTION IF EXISTS Lich_trong 
GO

CREATE FUNCTION Lich_trong (
@Ho NCHAR(20),
@Ten NCHAR(10),
@Ngay DATE,
@Ca NCHAR(10)
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

		IF @Ca = 'Ca 1'
		BEGIN
			set @Gio_vao = '07:00:00';
			set @Gio_tan_ca = '11:00:00';
		END
		ELSE 
		BEGIN
			set @Gio_vao = '13:00:00';
			set @Gio_tan_ca = '17:00:00';
		END

        DECLARE Lich_Cursor CURSOR FOR
        SELECT  lich_lam_viec.So_hieu_ca_lam_viec ,Gio_den_kham
        FROM lich_hen_kham INNER JOIN  lich_lam_viec 
        ON Ma_so_nhan_vien = @Ma_bac_si AND Ngay= @Ngay AND lich_lam_viec.Gio_vao = @Gio_vao;

        OPEN Lich_Cursor;
        FETCH NEXT FROM Lich_Cursor INTO @So_hieu_ca_lam_viec, @Gio_bat_dau ;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Gio_vao != @Gio_bat_dau AND @Gio_vao < @Gio_tan_ca
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

-- SELECT * FROM Lich_trong(N'Nguyễn', N'Văn A', '2024-04-14','Ca 1');
SELECT * FROM Lich_trong(N'Trần', N'Thị B', '2024-04-14', 'Ca 2');
SELECT * FROM lich_hen_kham