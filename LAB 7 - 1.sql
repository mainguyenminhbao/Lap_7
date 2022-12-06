select Year(getdate())-Year(NGSINH) as 'Tuoi' from NHANVIEN where MANV = '001'

if OBJECT_ID('fn_TuoiNV') is not null
	drop funcion fn_TuoiNV
go
create function fn_TuoiNV(@MaNV nvarchar(9))
return int
as
begin
	return(select YEAR(getdate())-YEAR(NGSINH) as 'Tuoi' from NHANVIEN where MANV = @MANV)
end

print 'Tuoi Nhan Vien: '+ convert(nvarchar, dbo.fn_TuoiNV('001'))
print 'Tuoi Nhan Vien: '+ convert(nvarchar, dbo.fn_TuoiNV('002'))
print 'Tuoi Nhan Vien: '+ convert(nvarchar, dbo.fn_TuoiNV('003'))

------------------------------------------------------------------------------------------------------------------

select MA_NVien count(MADA) from PHANCONG
group by Ma_NVien

select count(MADA) from PHANCONG where Ma_NVien = '004'

if OBJECT_ID('fn_DemDeAnNV') is not null
	drop function fn_DemDeAnNV
go
create function fn_DemDeAnNV(@MaNV varchar(9))
return int
as
	begin
		return(select count(MADA) from PHANCONG where Ma_NVien = @MaNV)
	end
print 'So Du an nhan vien da lam: '+ convert(varchar, dbo.fn_DemDeAnNV('004'))

--------------------------------------------------------------------------------------------------------------------

select * from NHANVIEN
select count(*) from NHANVIEN where PHAI like 'Nam'
select count(*) from NHANVIEN where PHAI like 'Nu'

create function fn_DemNV_Phai (@PHAI nvarchar(5))
return int 
as
	begin
		return(select count (*) from NHANVIEN where PHAI like @PHAI)
	end

print 'Nhan Vien Nam: '+ convert(varchar, dbo.fn_DemNV_Phai('Nam'))
print 'Nhan Vien Nu: '+ convert(varchar, dbo.fn_DemNV_Phai('Nu'))

----------------------------------------------------------------------------------------------------------------------

select PHG, TENPHG, AVG(LUONG) from NHANVIEN
inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
group by PHG.TENPHG

select AVG(LUONG) from NHANVIEN
inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
where TENPHG = 'IT'

if OBJECT_ID('fn_Luong_NhanVien_PB') is not null
	drop function fn_Luong_NhanVien_PB
go
create function fn_Luong_NhanVien_PB(@TenPhongBan nvarchar(20))
return @tbLuongNV table(fullname nvarchar(50), LUONG float)
as
	begin
		declare @LuongTb float
		select AVG(LUONG) from NHANVIEN
		inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
		where TENPHG = @TenPhongBan
		insert into @tbLuongNV
			select HoNV+' '+ TENLOT+' '+ TENNV, LUONG from NHANVIEN
			wherev LUONG > @LuongTB
		return
	end

select * from dbo.fn_Luong_NhanVien_PB('IT')

--------------------------------------------------------------------------------------------------------------------

select TENPHG, TRPHG, HONV+' '+ TENLOT+' '+ TENNV as 'Ten Truong Phong', count(MADA) as 'So Luong De An'
inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
inner join NHANVIEN on NHANVIEN.MANV = PHONGBAN.TRPHG
where PHONGBAN.MAPHG = '001'
group by TENPHG, TRPHG, TENNV, HONV, TENLOT

if OBJECT_ID('fn_SoLuongDeAnTheoPB') is not null
	drop fn_SoLuongDeAnTheoPB
	go
create function fn_SoLuongDeAnTheoPB(@MaPB int)
return @tblistPB table(TENPB nvarchar(20), MATP nvarchar(10), TENTP nvarchar(50), soLuong int)
as
begin
	insert into @tbListPB
	select TENPHG, TRPHG, HONV+' '+ TENLOT+' '+ TENNV as 'Ten Truong Phong', count(MADA) as 'So Luong De An'
		inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
		inner join NHANVIEN on NHANVIEN.MANV = PHONGBAN.TRPHG
		where PHONGBAN.MAPHG = @MaPB
		group by TENPHG, TRPHG, TENNV, HONV, TENLOT
	return
end
	 
select * from dbo.fn_SoLuongDeAnTheoPB(1)
select TENPHG, TRPHG, HONV+' '+ TENLOT+' '+ TENNV as 'Ten Truong Phong', count(MADA) as 'So Luong De An'
inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
inner join NHANVIEN on NHANVIEN.MANV = PHONGBAN.TRPHG
group by TENPHG, TRPHG, TENNV, HONV, TENLOT