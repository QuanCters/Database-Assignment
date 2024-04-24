DROP PROCEDURE IF EXISTS Proc_GetDoctorAppointmentsAndServices;
GO

CREATE PROCEDURE Proc_GetDoctorAppointmentsAndServices
    @AppointmentMonth INT
AS
BEGIN
    -- Lấy số lượng lịch hẹn khám cho từng bác sĩ và số lượng dịch vụ được thực hiện
    SELECT
        bs.Ma_so_nhan_vien AS DoctorID,
        nv.Ho AS LastName,
        nv.Ten AS FirstName,
        bs.Bang_cap AS BangCap,
        bs.Chuc_vu AS ChucVu,
        COUNT(lhk.Ma_lich_hen_kham) AS AppointmentCount,
        COUNT(lsddv.Ma_so) AS ServiceCount,
        COUNT(lhk.Ma_lich_hen_kham) + COUNT(lsddv.Ma_so) AS TotalCount
    FROM
        nhan_vien nv
    INNER JOIN
        bac_si bs ON nv.Ma_so_nhan_vien = bs.Ma_so_nhan_vien
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
        (COUNT(lhk.Ma_lich_hen_kham) + COUNT(lsddv.Ma_so)) > 0
    ORDER BY
        TotalCount DESC;
END;
GO
EXECUTE Proc_GetDoctorAppointmentsAndServices @AppointmentMonth = 04