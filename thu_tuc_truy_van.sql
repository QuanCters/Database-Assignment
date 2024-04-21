CREATE PROCEDURE Proc_SelectDoctorsBySpecialty
    @Specialty NVARCHAR(50)
AS
BEGIN
    SELECT DISTINCT nv.Ho,nv.Ten,nv.Gioi_tinh,nv.Dia_chi,nv.Email,bs.Chuc_danh,bs.Bang_cap
    FROM nhan_vien AS nv
    INNER JOIN bac_si AS bs ON nv.Ma_so_nhan_vien = bs.Ma_so_nhan_vien
    WHERE bs.Chuyen_khoa = @Specialty
    ORDER BY nv.Ten;
END;
DROP PROCEDURE IF EXISTS Proc_SelectDoctorsBySpecialty;
 execute Proc_SelectDoctorsBySpecialty @Specialty = N'Nhi khoa'


CREATE PROCEDURE Proc_GetDoctorAppointmentsBySpecialty
    @Specialty NVARCHAR(50)
AS
BEGIN
    SELECT bs.Ma_so_nhan_vien AS DoctorID,
           nv.Ho AS LastName,
           nv.Ten AS FirstName,
           bs.Bang_cap AS BangCap,
           bs.Chuc_vu AS ChucVu,
           COUNT(lhk.Ma_lich_hen_kham) AS AppointmentCount
    FROM nhan_vien nv
    INNER JOIN bac_si bs ON nv.Ma_so_nhan_vien = bs.Ma_so_nhan_vien
    INNER JOIN lich_lam_viec llv on bs.Ma_so_nhan_vien = llv.Ma_so_nhan_vien
    LEFT JOIN lich_hen_kham lhk ON llv.So_hieu_ca_lam_viec = lhk.So_hieu_ca_lam_viec
    WHERE bs.Chuyen_khoa = @Specialty
    GROUP BY bs.Ma_so_nhan_vien, nv.Ho, nv.Ten,bs.Chuc_vu,bs.Bang_cap
    HAVING COUNT(lhk.Ma_lich_hen_kham) > 0
    ORDER BY AppointmentCount DESC;
END;
DROP PROCEDURE IF EXISTS Proc_GetDoctorAppointmentsBySpecialty;
execute Proc_GetDoctorAppointmentsBySpecialty @Specialty = N'Nhi khoa'

