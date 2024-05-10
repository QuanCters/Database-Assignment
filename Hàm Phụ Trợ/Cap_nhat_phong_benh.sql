CREATE PROCEDURE Cap_nhat_phong_benh(@So_phong CHAR(10), @Ma_so_dich_vu_luu_tru CHAR(10))
AS
	update phong_benh_duoc_su_dung_tai_dich_vu_luu_tru
	set So_phong = @So_phong
	where Ma_so_dich_vu_luu_tru = @Ma_so_dich_vu_luu_tru;
	 update ngay_phong_benh_duoc_su_dung_tai_dich_vu_luu_tru 
	 set So_phong = @So_phong
	 where Ma_so_dich_vu_luu_tru = @Ma_so_dich_vu_luu_tru;
