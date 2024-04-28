DROP PROCEDURE IF EXISTS Proc_GetDoctorAppointmentsAndServices;
GO

CREATE PROCEDURE Proc_GetDoctorAppointmentsAndServices
    @AppointmentMonth INT
AS
BEGIN
    -- Tính số lần đặt lịch hẹn khám và đảm nhiệm dịch vụ cho mỗi bác sĩ trong tháng
    SELECT
        bs.Ma_so_nhan_vien AS DoctorID,
        nv.Ho AS LastName,
        nv.Ten AS FirstName,
        bs.Bang_cap AS BangCap,
        bs.Chuc_vu AS ChucVu,
        COUNT(DISTINCT CASE WHEN MONTH(lhk.Ngay_dat_lich) = @AppointmentMonth THEN lhk.Ma_lich_hen_kham END) AS AppointmentCount,
        COUNT(DISTINCT CASE WHEN MONTH(ldbv.Ngay) = @AppointmentMonth THEN lsddv.Ma_so END) AS ServiceCount,
        COUNT(DISTINCT CASE WHEN MONTH(lhk.Ngay_dat_lich) = @AppointmentMonth THEN lhk.Ma_lich_hen_kham END) +
        COUNT(DISTINCT CASE WHEN MONTH(ldbv.Ngay) = @AppointmentMonth THEN lsddv.Ma_so END) AS TotalCount
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
        MONTH(lhk.Ngay_dat_lich) = @AppointmentMonth OR MONTH(ldbv.Ngay) = @AppointmentMonth OR (lhk.Ma_lich_hen_kham IS NULL AND lsddv.Ma_so IS NULL)
    GROUP BY
        bs.Ma_so_nhan_vien, nv.Ho, nv.Ten, bs.Chuc_vu, bs.Bang_cap
    HAVING
        COUNT(DISTINCT CASE WHEN MONTH(lhk.Ngay_dat_lich) = @AppointmentMonth THEN lhk.Ma_lich_hen_kham END) +
        COUNT(DISTINCT CASE WHEN MONTH(ldbv.Ngay) = @AppointmentMonth THEN lsddv.Ma_so END) > 0
    ORDER BY
        TotalCount DESC;
END;
GO

EXECUTE Proc_GetDoctorAppointmentsAndServices @AppointmentMonth =05;
