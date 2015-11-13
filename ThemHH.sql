USE [QL_KhoHang] 
GO
/****** Object:  StoredProcedure [dbo].[ThemSP]    Script Date: 11/13/2015 07:48:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemHH] @tenhh nvarchar(50), @soluong int, @gianhap bigint, @giaxuat bigint, @nsx nvarchar(50), @thongtin text
AS
BEGIN
DECLARE @MaHH varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaHH from HANGHOA
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaHH
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaHH, 8) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = CAST(right(@MaHH, 8) AS int)
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaHH
END

DECLARE @cdai int
DECLARE @i int
SET @MaHH = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaHH)
SET @i = 1
while ( @i <= 8 - @cdai)
BEGIN
	SET @MaHH = '0' + @MaHH
	SET @i = @i + 1
END
SET @MaHH = 'HH' + @MaHH

INSERT INTO HANGHOA(MaHH, TenHH, SoLuong, GiaNhap, GiaXuat, NSX, ThongTin) values ( @MaHH, @tenhh, @soluong, @gianhap, @giaxuat, @nsx, @thongtin)
SELECT @MaHH
CLOSE contro
DEALLOCATE contro
END
