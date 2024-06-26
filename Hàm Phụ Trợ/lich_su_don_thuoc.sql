use assignment2
go
create function lich_su_don_thuoc(@id_benh_nhan char(10))
returns table 
as 
return
(
	select dtgt.Ma_don_thuoc, ldbv.Ngay, dt.Tong_tien_thuoc  
	from
		don_thuoc as dt,
		don_thuoc_gom_thuoc as dtgt,
		lan_su_dung_dich_vu as lsddv,
		lan_di_benh_vien as ldbv
	where
		ldbv.Ma_benh_nhan = @id_benh_nhan 
	AND	ldbv.Ma_so_lan_di_benh_vien = lsddv.Ma_so_lan_di_benh_vien
	AND 	dt.Ma_so = lsddv.Ma_so
	AND	dt.Ma_don_thuoc = dtgt.Ma_don_thuoc
)
go

select * from lich_su_don_thuoc('BN10003')
