USE assignment2 GO
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'BS10001',
        '1234',
        N'Nguyễn',
        N'Thụ',
        N'Nam',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'BS10003',
        '1235',
        N'Nguyễn',
        N'Tiến',
        N'Nam',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'BS10005',
        '1236',
        N'Lưu',
        N'Huy',
        N'Nam',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'BS10007',
        '1237',
        N'Lê',
        N'Quỳnh',
        N'Nu',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'BS10009',
        '1239',
        N'Trần',
        N'Thúy',
        N'Nu',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'DD10001',
        '1241',
        N'Vũ',
        N'Thư',
        N'Nu',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'DD10002',
        '1242',
        N'Lê',
        N'Trân',
        N'Nu',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'DD10003',
        '1243',
        N'Ngô',
        N'Thuận',
        N'Nu',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
INSERT INTO
    dbo.nhan_vien
VALUES
    (
        'DD10004',
        '1244',
        N'Trần',
        N'Ngọc',
        N'Nu',
        null,
        null,
        GETDATE (),
        null,
        GETDATE ()
    )
SELECT
    *
FROM
    dbo.bac_si
DELETE FROM dbo.bac_si
WHERE
    Ma_so_nhan_vien = 'BS10001'
INSERT INTO
    dbo.bac_si
VALUES
    (
        'BS10001',
        N'Bác sĩ',
        N'Chuyên khoa 2',
        N'Tim mạch',
        N'Bác sĩ hạng 1',
        null
    )
INSERT INTO
    dbo.bac_si
VALUES
    (
        'BS10003',
        N'Bác sĩ',
        N'Chuyên khoa 1',
        N'Tim mạch',
        N'Bác sĩ hạng 1',
        'BS10001'
    )
INSERT INTO
    dbo.bac_si
VALUES
    (
        'BS10005',
        N'Bác sĩ',
        N'Chuyên khoa 2',
        N'Chấn thương chỉnh hình',
        N'Bác sĩ hạng 1',
        null
    )
INSERT INTO
    dbo.bac_si
VALUES
    (
        'BS10007',
        N'Bác sĩ',
        N'Chuyên khoa 1',
        N'Chấn thương chỉnh hình',
        N'Bác sĩ hạng 2',
        'BS10005'
    )
INSERT INTO
    dbo.bac_si
VALUES
    (
        'BS10009',
        N'Bác sĩ',
        N'Chuyên khoa 1',
        N'Hồi sức tích cực',
        N'Bác sĩ hạng 1',
        null
    )
    ----------------------------------------------------------------------------------------------------
INSERT INTO
    dbo.dieu_duong
VALUES
    ('DD10001', N'Đại học', N'Điều dưỡng biên hạng II')
INSERT INTO
    dbo.dieu_duong
VALUES
    (
        'DD10002',
        N'Đại học',
        N'Điều dưỡng biên hạng III'
    )
INSERT INTO
    dbo.dieu_duong
VALUES
    (
        'DD10003',
        N'Trung cấp',
        N'Điều dưỡng biên hạng IV'
    )
    -----------------------------------------------------------------------------------------------------------------
    -- Bệnh nhân
SELECT
    *
FROM
    dbo.benh_nhan
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10001',
        '065038570231',
        N'Lưu',
        N'Minh',
        null,
        null,
        N'Nam',
        '19980210'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10002',
        '065038599345',
        N'Hoàng',
        N'Sang',
        null,
        null,
        N'Nam',
        '19990523'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10003',
        '038574628521',
        N'Đinh',
        N'Giang',
        null,
        null,
        N'Nu',
        '19980210'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10004',
        '063648270251',
        N'Võ',
        N'Ánh',
        null,
        null,
        N'Nu',
        '20041201'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10005',
        '063838270251',
        N'Tân',
        N'Triết',
        null,
        null,
        N'Nam',
        '20040201'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10006',
        '064218270251',
        N'Mỹ',
        N'Nu',
        null,
        null,
        N'Nam',
        '20031103'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10007',
        '064212370251',
        N'Gia',
        N'Huy',
        null,
        null,
        N'Nam',
        '20031103'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10008',
        '016472370251',
        N'Thanh',
        N'Tam',
        null,
        null,
        N'Nu',
        '20021003'
    )
INSERT INTO
    dbo.benh_nhan
VALUES
    (
        'BN10009',
        '020495370251',
        N'Như',
        N'An',
        null,
        null,
        N'Nu',
        '20010523'
    )
    -----------------------------------------------------------------------------------------------------------------
    --Lần đi bệnh viện 
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10001',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10001'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10002',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10002'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10003',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10003'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10004',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10004'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10005',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10005'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10006',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10006'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10007',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10007'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10008',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10008'
    )
INSERT INTO
    dbo.lan_di_benh_vien
VALUES
    (
        'LDBV10009',
        convert(varchar, getdate (), 108),
        GETDATE (),
        null,
        'BN10009'
    )
    -------------------------------------------------------------------------------------------
    -- Mã loại dịch vụ
SELECT
    *
FROM
    dbo.loai_dich_vu
INSERT INTO
    dbo.loai_dich_vu
VALUES
    ('KB', N'Khám bệnh', null, 46000)
INSERT INTO
    dbo.loai_dich_vu
VALUES
    ('LT', N'Lưu trú', null, null)
    ------------------------------------------------------------------------------------------------------------------
    --- Lần sử dụng dịch vụ 
    -- Mã số nên để theo cấu trúc [mã DV]+[5 ky tự số]
    -- Riêng DV Lưu trú ký tự số thứ 3 tương ứng vs loại phòng (số lượng tối đa của phòng đó)
DROP TABLE lan_su_dung_dich_vu
INSERT INTO
    dbo.lan_su_dung_dich_vu
VALUES
    ('LT10401', 'DD10001', 'LDBV10001', 'LT')
INSERT INTO
    dbo.lan_su_dung_dich_vu
VALUES
    ('LT10402', 'DD10002', 'LDBV10002', 'LT')
INSERT INTO
    dbo.lan_su_dung_dich_vu
VALUES
    ('LT10601', 'DD10003', 'LDBV10003', 'LT')
INSERT INTO
    dbo.lan_su_dung_dich_vu
VALUES
    ('LT10602', 'DD10004', 'LDBV10004', 'LT')
INSERT INTO
    dbo.lan_su_dung_dich_vu
VALUES
    ('LT10202', 'DD10001', 'LDBV10005', 'LT')
INSERT INTO
    dbo.lan_su_dung_dich_vu
VALUES
    ('LT10201', 'DD10004', 'LDBV10006', 'LT')
SELECT
    *
FROM
    dbo.lan_su_dung_dich_vu
DELETE FROM dbo.lan_su_dung_dich_vu
WHERE
    Ma_so = 'LSD10001'
    ------------------------------------------------
    -- Dịch vụ lưu trú
INSERT INTO
    dbo.dich_vu_luu_tru
VALUES
    (
        'LT10401',
        '20240417',
        '20240517',
        null,
        N'Phòng 4 người'
    )
INSERT INTO
    dbo.dich_vu_luu_tru
VALUES
    (
        'LT10402',
        '20240420',
        '20240423',
        null,
        N'Phòng 4 người'
    )
INSERT INTO
    dbo.dich_vu_luu_tru
VALUES
    (
        'LT10601',
        '20240420',
        '20240423',
        null,
        N'Phòng 6 người'
    )
INSERT INTO
    dbo.dich_vu_luu_tru
VALUES
    (
        'LT10602',
        '20240420',
        '20240424',
        null,
        N'Phòng 6 người'
    )
INSERT INTO
    dbo.dich_vu_luu_tru
VALUES
    (
        'LT10201',
        '20240420',
        '20240423',
        null,
        N'Phòng 2 người'
    )
INSERT INTO
    dbo.dich_vu_luu_tru
VALUES
    (
        'LT10202',
        '20240420',
        '20240423',
        null,
        N'Phòng 2 người'
    )
    ---------------------------------------------------------------------------------
UPDATE dbo.dich_vu_luu_tru
SET
    Ngay_ket_thuc = '20240424'
WHERE
    Ma_so = 'LT10202'
    ---------------------------------------------------000000000000
UPDATE dbo.dich_vu_luu_tru
SET
    Ngay_ket_thuc = '20240419'
WHERE
    Ma_so = 'LT10601'
DELETE FROM dbo.dich_vu_luu_tru
WHERE
    Ma_so = 'LT10202'
    --	'LT10401'
    --	'LT10402'
    --	'LT10601'
    --	'LT10602'
    --	'LT10201'
    --	'LT10202'
SELECT
    *
FROM
    dbo.dich_vu_luu_tru
    -------------------------------------------------------------------------------------------------
    -- Phòng bệnh
SELECT
    *
FROM
    dbo.phong_benh
INSERT INTO
    dbo.phong_benh
VALUES
    ('PB60101', N'6 người', 0)
INSERT INTO
    dbo.phong_benh
VALUES
    ('PB60201', N'6 người', 0)
INSERT INTO
    dbo.phong_benh
VALUES
    ('PB40101', N'4 người', 0)
INSERT INTO
    dbo.phong_benh
VALUES
    ('PB40201', N'4 người', 0)
INSERT INTO
    dbo.phong_benh
VALUES
    ('PB20101', N'2 người', 0)
INSERT INTO
    dbo.phong_benh
VALUES
    ('PB20201', N'2 người', 0)
SELECT
    *
FROM
    dbo.phong_benh
DELETE FROM dbo.phong_benh
WHERE
    So_phong = 'PB20201'
    --	'PB60101'
    --	'PB60201'
    --	'PB40101'
    --	'PB40201'
    --	'PB20101'
    --	'PB20201'
UPDATE dbo.phong_benh
SET
    So_luong_benh_nhan_hien_tai = 0;

SELECT
    *
FROM
    dbo.phong_benh
    -------------------------------------------------------------------------------------------------
    -- Phòng bệnh được sử dụng tại dịch vụ lưu trú
INSERT INTO
    dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES
    ('PB40101', 'LT10401')
INSERT INTO
    dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES
    ('PB40101', 'LT10402')
INSERT INTO
    dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES
    ('PB60101', 'LT10601')
INSERT INTO
    dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES
    ('PB60101', 'LT10602')
INSERT INTO
    dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES
    ('PB20101', 'LT10201')
INSERT INTO
    dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
VALUES
    ('PB20101', 'LT10202')
    -----------------------------
UPDATE dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
SET
    So_phong = 'PB20201'
WHERE
    Ma_so_dich_vu_luu_tru = 'LT10201'
    --------
SELECT
    *
FROM
    dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
    ------------
DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE
    Ma_so_dich_vu_luu_tru = 'LT10401'
DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE
    Ma_so_dich_vu_luu_tru = 'LT10402'
DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE
    Ma_so_dich_vu_luu_tru = 'LT10601'
DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE
    Ma_so_dich_vu_luu_tru = 'LT10602'
DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE
    Ma_so_dich_vu_luu_tru = 'LT10201'
DELETE FROM dbo.phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
WHERE
    Ma_so_dich_vu_luu_tru = 'LT10202'
    --	'LT10401'
    --	'LT10402'
    --	'LT10601'
    --	'LT10602'
    --	'LT10201'
    --	'LT10202'
    --------------------------------------------------------------------------------------