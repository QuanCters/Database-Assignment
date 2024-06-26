DROP PROCEDURE IF EXISTS Proc_SelectDoctorsBySpecialty;
Go
CREATE PROCEDURE Proc_SelectDoctorsBySpecialty
    @Specialty NVARCHAR(50)
AS
BEGIN
    SELECT DISTINCT nv.Ho,nv.Ten,nv.Gioi_tinh,nv.Dia_chi,nv.Email,bs.Chuc_danh
    FROM nhan_vien AS nv
    INNER JOIN bac_si AS bs ON nv.Ma_so_nhan_vien = bs.Ma_so_nhan_vien
    WHERE bs.Chuyen_khoa = @Specialty
    ORDER BY nv.Ten;
END;
GO
 execute Proc_SelectDoctorsBySpecialty @Specialty = N'Nội Khoa'


