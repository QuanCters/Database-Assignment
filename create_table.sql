CREATE DATABASE assignment2;
GO
SET DATEFORMAT dmy;
USE assignment2;
CREATE TABLE nhan_vien (
	Ma_so_nhan_vien	CHAR(10) PRIMARY KEY,
    CCCD			CHAR(12),
    Ho				NCHAR(20),
    Ten				NCHAR(10),
    Gioi_tinh		NVARCHAR(3) CHECK (Gioi_tinh = 'Nam' OR Gioi_tinh = 'Nu'),
    Dia_chi			NVARCHAR(255),
    Email			NVARCHAR(100),
    Ngay_ky_hop_dong	DATE,
    Luong			INT,
    Ngay_sinh		DATE,
    SĐT             CHAR(10)
);
CREATE TABLE bac_si (
	Ma_so_nhan_vien	CHAR(10) PRIMARY KEY,
    Chuc_vu			NVARCHAR(50),
    Chuyen_khoa		NVARCHAR(50),
    Chuc_danh       NVARCHAR(50),
    Ma_so_quan_ly	CHAR(10),
    FOREIGN KEY (Ma_so_nhan_vien) REFERENCES nhan_vien(Ma_so_nhan_vien),
    FOREIGN KEY (Ma_so_quan_ly) REFERENCES bac_si(Ma_so_nhan_vien)
);
CREATE TABLE bang_cap_bac_si (
	Ma_so_nhan_vien	CHAR(10),
    Bang_cap		NVARCHAR(50),
    PRIMARY KEY (Ma_so_nhan_vien, Bang_cap),
    FOREIGN KEY (Ma_so_nhan_vien) REFERENCES bac_si(Ma_so_nhan_vien)
);
CREATE TABLE lich_lam_viec (
	So_hieu_ca_lam_viec	CHAR(10) PRIMARY KEY,
    Ngay				DATE,
    Gio_vao             TIME,
    Gio_tan_ca          TIME,
    Ma_so_nhan_vien		CHAR(10),
    FOREIGN KEY (Ma_so_nhan_vien) REFERENCES bac_si(Ma_so_nhan_vien)
);
CREATE TABLE dieu_duong (
	Ma_so_nhan_vien	CHAR(10) PRIMARY KEY,
    Trinh_do				NVARCHAR(50),
    Hang_chuc_nghe_nghiep	NVARCHAR(50),
    FOREIGN KEY (Ma_so_nhan_vien) REFERENCES nhan_vien(Ma_so_nhan_vien)
);
CREATE TABLE benh_nhan (
	Ma_benh_nhan	CHAR(10) PRIMARY KEY,
    CCCD			CHAR(12),
    Ho				NVARCHAR(20),
    Ten				NVARCHAR(10),
    Dia_chi			NVARCHAR(255),
    Email			VARCHAR(100),
    Gioi_tinh 		NVARCHAR(3) CHECK (Gioi_tinh = 'Nam' OR Gioi_tinh = 'Nu'),
    Ngay_sinh		DATE,
    SĐT             CHAR(10)
);
CREATE TABLE the_bhyt (
	Ma_bhyt				CHAR(13) PRIMARY KEY,
    Noi_song					NVARCHAR(255),
    Noi_dang_ky_kham_chua_benh	NVARCHAR(100),
    Ma_ki_hieu_muc_huong		CHAR(2),
    Ma_benh_nhan				CHAR(10),
    Ngay_dang_ky                DATE,
    FOREIGN KEY (Ma_benh_nhan) REFERENCES benh_nhan(Ma_benh_nhan)
);
CREATE TABLE thong_tin_theo_doi_suc_khoe (
	Ma_benh_nhan		CHAR(10),
    Ngay				DATE,
    Gio					TIME,
    Can_nang			FLOAT,
    Chieu_cao			INT,
    Huyet_ap			VARCHAR(10),
    BMI					FLOAT,
    Phan_loai_suc_khoe	NVARCHAR(10),
    PRIMARY KEY (Ma_benh_nhan, Ngay, Gio),
    FOREIGN KEY (Ma_benh_nhan) REFERENCES benh_nhan(Ma_benh_nhan)
);

CREATE TABLE than_nhan (
	Ma_benh_nhan	CHAR(10),
    Ten				NVARCHAR(50),
    Dia_chi			NVARCHAR(255),
    PRIMARY KEY (Ma_benh_nhan, Ten),
    FOREIGN KEY (Ma_benh_nhan) REFERENCES benh_nhan(Ma_benh_nhan)
);
CREATE TABLE lien_lac_cua_than_nhan (
	Ma_benh_nhan	CHAR(10),
    Ten				NVARCHAR(50),
    So_dien_thoai	CHAR(10),
    Email			VARCHAR(100),
    PRIMARY KEY (Ma_benh_nhan, Ten, So_dien_thoai, Email),
    FOREIGN KEY (Ma_benh_nhan, Ten) REFERENCES than_nhan(Ma_benh_nhan, Ten)
);
CREATE TABLE lan_di_benh_vien (
	Ma_so			CHAR(10) PRIMARY KEY,
    Gio				TIME,
    Ngay			DATE,
    Tong_chi_phi	INT,
    Ma_benh_nhan	CHAR(10),
    FOREIGN KEY (Ma_benh_nhan) REFERENCES benh_nhan(Ma_benh_nhan)
);
CREATE TABLE loai_dich_vu (
	Ma_loai_dich_vu	CHAR(10) PRIMARY KEY,
    Ten_dich_vu		NVARCHAR(100),
    Mo_ta			NVARCHAR(255),
    Bang_gia        INT
);
CREATE TABLE lan_su_dung_dich_vu (
	Ma_so					CHAR(10) PRIMARY KEY,
    Ma_so_nhan_vien			CHAR(10),
    Ma_so_lan_di_benh_vien	CHAR(10),
    Ma_loai_dich_vu			CHAR(10),
    FOREIGN KEY (Ma_so_nhan_vien) REFERENCES bac_si(Ma_so_nhan_vien),
    FOREIGN KEY (Ma_so_lan_di_benh_vien) REFERENCES lan_di_benh_vien(Ma_so),
    FOREIGN KEY (Ma_loai_dich_vu) REFERENCES loai_dich_vu(Ma_loai_dich_vu)
);
CREATE TABLE dich_vu_noi_soi (
	Ma_so			CHAR(10) PRIMARY KEY,
    Co_quan			NVARCHAR(100),
    Phuong_phap		NVARCHAR(100),
    Chi_phi			INT,
    FOREIGN KEY (Ma_so) REFERENCES lan_su_dung_dich_vu(Ma_so)
);
CREATE TABLE dich_vu_xet_nghiem (
	Ma_so				CHAR(10) PRIMARY KEY,
    Ket_qua_xet_nghiem	NVARCHAR(100),
    Loai_xet_nghiem		NVARCHAR(100),
    Loai_mau 			NVARCHAR(100),
    Chi_phi				INT,
    FOREIGN KEY (Ma_so) REFERENCES lan_su_dung_dich_vu(Ma_so)
);
CREATE TABLE dich_vu_chup_ct_xquang (
	Ma_so			CHAR(10) PRIMARY KEY,
    Vi_tri_chup		NVARCHAR(100),
    Kieu_x_quang	NVARCHAR(100),
    Chi_phi			INT,
    FOREIGN KEY (Ma_so) REFERENCES lan_su_dung_dich_vu(Ma_so)
);
CREATE TABLE dich_vu_sieu_am (
	Ma_so		CHAR(10) PRIMARY KEY,
    Loai_dau_do	NVARCHAR(100),
    Ket_luan	NVARCHAR(100),
    Chi_phi		INT,
    FOREIGN KEY (Ma_so) REFERENCES lan_su_dung_dich_vu(Ma_so)
);
CREATE TABLE hinh_thuc_hien_thi_ket_qua_sieu_am (
	Ma_so						CHAR(10) PRIMARY KEY,
    Hinh_thuc_hien_thi_ket_qua	NVARCHAR(100),
    FOREIGN KEY (Ma_so) REFERENCES dich_vu_sieu_am(Ma_so)
);
CREATE TABLE dich_vu_kham_benh (
	Ma_so				CHAR(10) PRIMARY KEY,
    Ket_qua				NVARCHAR(100),
    Chi_phi				INT,
    Ngay_hen_tiep_theo	DATE,
    Gio_hen_tiep_theo	TIME,
    FOREIGN KEY (Ma_so) REFERENCES lan_su_dung_dich_vu(Ma_so)
);
CREATE TABLE don_thuoc (
	Ma_don_thuoc	CHAR(10) PRIMARY KEY,
    Tong_tien_thuoc	INT,
    Ma_so			CHAR(10),
    FOREIGN KEY (Ma_so) REFERENCES dich_vu_kham_benh(Ma_so)
);
CREATE TABLE thuoc (
	Ma_thuoc	CHAR(10) PRIMARY KEY,
    Ten			NVARCHAR(100),
    Gia_ban		INT,
    HDSD		NVARCHAR(255)
);
CREATE TABLE don_thuoc_gom_thuoc (
	Ma_thuoc		CHAR(10),
    Ma_don_thuoc	CHAR(10),
    So_luong		INT,
    Lieu_luong		NVARCHAR(255),
    PRIMARY KEY (Ma_thuoc, Ma_don_thuoc),
    FOREIGN KEY (Ma_thuoc) REFERENCES thuoc(Ma_thuoc),
    FOREIGN KEY (Ma_don_thuoc) REFERENCES don_thuoc(Ma_don_thuoc)
);
CREATE TABLE dich_vu_luu_tru (
	Ma_so			CHAR(10) PRIMARY KEY,
    Ngay_bat_dau	DATE,
    Ngay_ket_thuc	DATE,
    Tong_chi_phi	INT,
    FOREIGN KEY (Ma_so) REFERENCES lan_su_dung_dich_vu(Ma_so)
);
CREATE TABLE phong_benh (
	So_phong			CHAR(10) PRIMARY KEY,
    Loai_phong			INT,
    So_luong_benh_nhan_hien_tai	    INT
);
CREATE TABLE phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (
	So_phong				CHAR(10),
    Ma_so_dich_vu_luu_tru	CHAR(10),
    PRIMARY KEY (So_phong, Ma_so_dich_vu_luu_tru),
    FOREIGN KEY (So_phong) REFERENCES phong_benh(So_phong),
    FOREIGN KEY (Ma_so_dich_vu_luu_tru) REFERENCES dich_vu_luu_tru(Ma_so)
);
CREATE TABLE ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru (
	So_phong				CHAR(10),
    Ma_so_dich_vu_luu_tru	CHAR(10),
    Ngay_su_dung 			DATE,
    PRIMARY KEY (So_phong, Ma_so_dich_vu_luu_tru, Ngay_su_dung),
    FOREIGN KEY (So_phong, Ma_so_dich_vu_luu_tru) REFERENCES phong_benh_duoc_su_dung_tai_dich_vu_luu_tru(So_phong, Ma_so_dich_vu_luu_tru)
);
CREATE TABLE dieu_duong_tham_gia_dich_vu_luu_tru (
	Ma_so_nhan_vien			CHAR(10),
    Ma_so_dich_vu_luu_tru	CHAR(10),
    PRIMARY KEY (Ma_so_nhan_vien, Ma_so_dich_vu_luu_tru),
    FOREIGN KEY (Ma_so_nhan_vien) REFERENCES dieu_duong(Ma_so_nhan_vien),
    FOREIGN KEY (Ma_so_dich_vu_luu_tru) REFERENCES dich_vu_luu_tru(Ma_so)
);
CREATE TABLE ngay_tham_gia_cua_dieu_duong_phu_trach_dich_vu_luu_tru (
	Ma_so_nhan_vien			CHAR(10),
    Ma_so_dich_vu_luu_tru	CHAR(10),
    Ngay_phu_trach			DATE,
    PRIMARY KEY (Ma_so_nhan_vien, Ma_so_dich_vu_luu_tru, Ngay_phu_trach),
    FOREIGN KEY (Ma_so_nhan_vien, Ma_so_dich_vu_luu_tru) REFERENCES dieu_duong_tham_gia_dich_vu_luu_tru(Ma_so_nhan_vien, Ma_so_dich_vu_luu_tru)
);
CREATE TABLE lich_hen_kham (
	Ma_lich_hen_kham		CHAR(10) PRIMARY KEY,
    So_hieu_ca_lam_viec     CHAR(10),
    Ngay_dat_lich           DATE,
    Gio_den_kham            TIME,
    Ma_so_lan_di_benh_vien  CHAR(10),
    Ma_benh_nhan	        CHAR(10),
    FOREIGN KEY (Ma_so_lan_di_benh_vien) REFERENCES lan_di_benh_vien(Ma_so),
    FOREIGN KEY (Ma_benh_nhan) REFERENCES benh_nhan(Ma_benh_nhan),
    FOREIGN KEY (So_hieu_ca_lam_viec) REFERENCES lich_lam_viec(So_hieu_ca_lam_viec)
)
