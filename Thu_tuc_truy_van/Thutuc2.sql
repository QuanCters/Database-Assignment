DROP PROCEDURE IF EXISTS Proc_GetDoctorAppointmentsAndServices;
GO

CREATE PROCEDURE Proc_GetDoctorAppointmentsAndServices
    @AppointmentMonth INT
AS
BEGIN
    SELECT
        bs.Ma_so_nhan_vien AS DoctorID,
        nv.Ho AS LastName,
        nv.Ten AS FirstName,
        bs.Bang_cap AS BangCap,
        bs.Chuc_vu AS ChucVu,
        COUNT(DISTINCT lhk.Ma_lich_hen_kham) AS AppointmentCount,
        COUNT(DISTINCT lsddv.Ma_so) AS ServiceCount,
        COUNT(DISTINCT lhk.Ma_lich_hen_kham) + COUNT(DISTINCT lsddv.Ma_so) AS TotalCount
    FROM
        bac_si bs
    INNER JOIN
        nhan_vien nv ON nv.Ma_so_nhan_vien = bs.Ma_so_nhan_vien
    LEFT JOIN
        lich_lam_viec llv ON bs.Ma_so_nhan_vien = llv.Ma_so_nhan_vien
    LEFT JOIN
        lich_hen_kham lhk ON llv.So_hieu_ca_lam_viec = lhk.So_hieu_ca_lam_viec
    LEFT JOIN
        lan_su_dung_dich_vu lsddv ON bs.Ma_so_nhan_vien = lsddv.Ma_so_nhan_vien
    LEFT JOIN
        lan_di_benh_vien ldbv ON lsddv.Ma_so_lan_di_benh_vien = ldbv.Ma_so
    WHERE
        MONTH(lhk.Ngay_dat_lich) = @AppointmentMonth OR MONTH(ldbv.Ngay) = @AppointmentMonth
    GROUP BY
        bs.Ma_so_nhan_vien, nv.Ho, nv.Ten, bs.Chuc_vu, bs.Bang_cap
    HAVING
        (COUNT(DISTINCT lhk.Ma_lich_hen_kham) + COUNT(DISTINCT lsddv.Ma_so)) > 0
    ORDER BY
        TotalCount DESC;
END;

GO
EXECUTE Proc_GetDoctorAppointmentsAndServices @AppointmentMonth = 04