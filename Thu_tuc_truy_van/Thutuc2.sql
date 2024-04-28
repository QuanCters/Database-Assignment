DROP PROCEDURE IF EXISTS Proc_GetDoctorAppointmentsAndServices;
GO

CREATE PROCEDURE Proc_GetDoctorAppointmentsAndServices
    @AppointmentMonth INT
AS
BEGIN
    -- Tính số lần đặt lịch hẹn khám cho mỗi bác sĩ trong tháng
    SELECT
        bs.Ma_so_nhan_vien AS DoctorID,
        nv.Ho AS LastName,
        nv.Ten AS FirstName,
        bs.Bang_cap AS BangCap,
        bs.Chuc_vu AS ChucVu,
        COUNT(DISTINCT lhk.Ma_lich_hen_kham) AS AppointmentCount,
        0 AS ServiceCount, -- Khởi tạo ServiceCount là 0 vì sẽ tính riêng số lần đảm nhiệm dịch vụ ở câu truy vấn phía dưới
        COUNT(DISTINCT lhk.Ma_lich_hen_kham) AS TotalCount
    FROM
        bac_si bs
    INNER JOIN
        nhan_vien nv ON nv.Ma_so_nhan_vien = bs.Ma_so_nhan_vien
    LEFT JOIN
        lich_lam_viec llv ON bs.Ma_so_nhan_vien = llv.Ma_so_nhan_vien
    LEFT JOIN
        lich_hen_kham lhk ON llv.So_hieu_ca_lam_viec = lhk.So_hieu_ca_lam_viec
    WHERE
        MONTH(lhk.Ngay_dat_lich) = @AppointmentMonth
    GROUP BY
        bs.Ma_so_nhan_vien, nv.Ho, nv.Ten, bs.Chuc_vu, bs.Bang_cap

    UNION ALL

    -- Tính số lần đảm nhiệm dịch vụ cho mỗi bác sĩ trong tháng
    SELECT
        bs.Ma_so_nhan_vien AS DoctorID,
        nv.Ho AS LastName,
        nv.Ten AS FirstName,
        bs.Bang_cap AS BangCap,
        bs.Chuc_vu AS ChucVu,
        0 AS AppointmentCount, -- Khởi tạo AppointmentCount là 0 vì sẽ tính riêng số lần đặt lịch hẹn khám ở câu truy vấn phía trên
        COUNT(DISTINCT lsddv.Ma_so) AS ServiceCount,
        COUNT(DISTINCT lsddv.Ma_so) AS TotalCount
    FROM
        bac_si bs
    INNER JOIN
        nhan_vien nv ON nv.Ma_so_nhan_vien = bs.Ma_so_nhan_vien
    LEFT JOIN
        lan_su_dung_dich_vu lsddv ON bs.Ma_so_nhan_vien = lsddv.Ma_so_nhan_vien
    LEFT JOIN
        lan_di_benh_vien ldbv ON lsddv.Ma_so_lan_di_benh_vien = ldbv.Ma_so
    WHERE
        MONTH(ldbv.Ngay) = @AppointmentMonth
    GROUP BY
        bs.Ma_so_nhan_vien, nv.Ho, nv.Ten, bs.Chuc_vu, bs.Bang_cap

    ORDER BY
        TotalCount DESC;
END;
GO

EXECUTE Proc_GetDoctorAppointmentsAndServices @AppointmentMonth = 05;
