USE [QL_KhoHang]
GO
/****** Object:  StoredProcedure [dbo].[ThemHDN]    Script Date: 11/13/2015 07:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemPN] @mancc varchar(10), @ngaynhap date
AS
BEGIN
DECLARE @MaPN varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaPN from PHIEUNHAP
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaPN
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaPN, 8) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = @Sott + 1
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaPN
END
DECLARE @cdai int
DECLARE @i int
SET @MaPN = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaPN)
SET @i = 1
while ( @i <= 8 - @cdai)
BEGIN
	SET @MaPN = '0' + @MaPN
	SET @i = @i + 1
END
SET @MaPN = 'PN' + @MaPN

INSERT INTO PHIEUNHAP(MaPN, MaNCC, NgayNhap) values (@MaPN, @mancc, @ngaynhap)
SELECT @MaPN
CLOSE contro
DEALLOCATE contro
END
