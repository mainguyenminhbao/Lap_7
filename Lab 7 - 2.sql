select HOTEN, TENNV, TENPHG, DIADIEM from PHONGBAN
inner join DIADIEM_PHG on DIADIEM_PHG.MAPHG = PHONGBAN.MAPHG
inner join NHANVIEN on NHANVIEN.PHG = PHONGBAN.MAPHG

create view v_DD_PhongBan
as
inner join DIADIEM_PHG on DIADIEM_PHG.MAPHG = PHONGBAN.MAPHG
inner join NHANVIEN on NHANVIEN.PHG = PHONGBAN.MAPHG

select * from v_DD_PhongBan 

---------------------------------------------------------------

select TENNV, LUONG,YEAR(GETDATE())-YEAR(NGSINH) as 'Tuoi' from NHANVIEN

create view v_TuoiNV
as
select TENNV, LUONG,YEAR(GETDATE())-YEAR(NGSINH) as 'Tuoi' from NHANVIEN

select * from v_TuoiNV

-----------------------------------------------------------------

select top(1) TENPHG, TRPHG, B.HONV+' '+B.TENLOT+' '+B.TENNV as 'TenTP', COUNT(A.MANV) as 'So Luong NV' from
inner join PHONGBAN on PHONGBAN.PHG = A.PHG
inner join NHANVIEN B on B.MANV = PHONGBAN.TRPHG
group by TENPHG, TRPHG, B.TENNV, B.HONV, B.TENLOT
order by SoLuongNV desc

create view v_TopSoLuongNV_PB
as
select top(1) TENPHG, TRPHG, B.HONV+' '+B.TENLOT+' '+B.TENNV as 'TenTP', COUNT(A.MANV) as 'So Luong NV' from
inner join PHONGBAN on PHONGBAN.PHG = A.PHG
inner join NHANVIEN B on B.MANV = PHONGBAN.TRPHG
group by TENPHG, TRPHG, B.TENNV, B.HONV, B.TENLOT
order by SoLuongNV desc

select * from v_TopSoLuongNV_PB
