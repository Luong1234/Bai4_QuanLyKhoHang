USE [QL_KhoHang]
GO
/****** Object:  Table [dbo].[HANGHOA]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HANGHOA](
	[MaHH] [varchar](10) NOT NULL,
	[TenHH] [nvarchar](50) NULL,
	[SoLuong] [int] NULL,
	[GiaNhap] [float] NULL,
	[GiaXuat] [float] NULL,
	[NSX] [nvarchar](50) NULL,
	[ThongTin] [ntext] NULL,
 CONSTRAINT [PK_HANGHOA] PRIMARY KEY CLUSTERED 
(
	[MaHH] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DANGNHAP]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DANGNHAP](
	[UserName] [nvarchar](20) NULL,
	[Pass] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHINHANH]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHINHANH](
	[MaCN] [varchar](10) NOT NULL,
	[TenCN] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDT] [varchar](20) NULL,
 CONSTRAINT [PK_CHINHANH] PRIMARY KEY CLUSTERED 
(
	[MaCN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NHACUNGCAP]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NHACUNGCAP](
	[MaNCC] [varchar](10) NOT NULL,
	[TenNCC] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDT] [varchar](20) NULL,
 CONSTRAINT [PK_NHACUNGCAP] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ThemNCC]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----PROC Thêm sản phẩm
CREATE PROC [dbo].[ThemNCC] @tenncc nvarchar(50), @diachi nvarchar(100), @sdt varchar(20)
AS
BEGIN
DECLARE @MaNCC varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaNCC from NHACUNGCAP
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaNCC
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaNCC, 7) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = @Sott + 1
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaNCC
END
DECLARE @cdai int
DECLARE @i int
SET @MaNCC = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaNCC)
SET @i = 1
while ( @i <= 7 - @cdai)
BEGIN
	SET @MaNCC = '0' + @MaNCC
	SET @i = @i + 1
END
SET @MaNCC = 'NCC' + @MaNCC

INSERT INTO NHACUNGCAP(MaNCC, TenNCC, DiaChi, SDT) values (@MaNCC, @tenncc, @diachi, @sdt)
CLOSE contro
DEALLOCATE contro
END

----exec DanhMaKH @tenKH = N'Hiếu', @dc = N'Thái Nguyên', @SDT = '09127862476', @LoaiKH = N'Khách VIP'

--CREATE PROC SuaNCC @mancc varchar(10), @tenncc nvarchar(50), @diachi nvarchar(50), @sdt varchar(15)
--AS
--BEGIN
--UPDATE NHACUNGCAP SET TenNCC = @tenncc, DiaChi = @diachi, SDT = @sdt
--WHERE MaNCC = @mancc
--END

--CREATE PROC XoaNCC @mancc varchar(10)
--AS
--BEGIN
--DELETE FROM NHACUNGCAP WHERE MaNCC = @mancc
--END
GO
/****** Object:  StoredProcedure [dbo].[ThemHH]    Script Date: 12/03/2015 20:45:50 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[XoaNCC]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[XoaNCC] @mancc varchar(10)
AS
BEGIN
DELETE FROM NHACUNGCAP WHERE MaNCC = @mancc
END
GO
/****** Object:  StoredProcedure [dbo].[SuaNCC]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SuaNCC] @mancc varchar(10), @tenncc nvarchar(50), @diachi nvarchar(100), @sdt varchar(20)
AS
BEGIN
UPDATE NHACUNGCAP SET TenNCC = @tenncc, DiaChi = @diachi, SDT = @sdt
WHERE MaNCC = @mancc
END
GO
/****** Object:  Table [dbo].[PHIEUXUAT]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PHIEUXUAT](
	[MaPX] [varchar](10) NOT NULL,
	[MaCN] [varchar](10) NOT NULL,
	[NgayXuat] [datetime] NULL,
	[TongTien] [float] NULL,
 CONSTRAINT [PK_PHIEUXUAT_1] PRIMARY KEY CLUSTERED 
(
	[MaPX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PHIEUNHAP]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PHIEUNHAP](
	[MaPN] [varchar](10) NOT NULL,
	[MaNCC] [varchar](10) NOT NULL,
	[NgayNhap] [datetime] NULL,
	[TongTien] [float] NULL,
 CONSTRAINT [PK_PHIEUNHAP_1] PRIMARY KEY CLUSTERED 
(
	[MaPN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CHITIETPHIEUXUAT]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHITIETPHIEUXUAT](
	[MaPX] [varchar](10) NOT NULL,
	[MaHH] [varchar](10) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [float] NULL,
	[ThanhTien] [float] NULL,
 CONSTRAINT [PK_CHITIETPHIEUXUAT] PRIMARY KEY CLUSTERED 
(
	[MaPX] ASC,
	[MaHH] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CHITIETPHIEUNHAP]    Script Date: 12/03/2015 20:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHITIETPHIEUNHAP](
	[MaPN] [varchar](10) NOT NULL,
	[MaHH] [varchar](10) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [float] NULL,
	[ThanhTien] [float] NULL,
 CONSTRAINT [PK_CHITIETPHIEUNHAP] PRIMARY KEY CLUSTERED 
(
	[MaPN] ASC,
	[MaHH] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ThemPX]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemPX] @macn varchar(10), @ngayxuat date
AS
BEGIN
DECLARE @MaPX varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaPX from PHIEUXUAT
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaPX
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaPX, 8) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = @Sott + 1
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaPX
END
DECLARE @cdai int
DECLARE @i int
SET @MaPX = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaPX)
SET @i = 1
while ( @i <= 8 - @cdai)
BEGIN
	SET @MaPX = '0' + @MaPX
	SET @i = @i + 1
END
SET @MaPX = 'PX' + @MaPX

INSERT INTO PHIEUXUAT(MaPX, MaCN, NgayXuat) values (@MaPX, @macn, @ngayxuat)
SELECT @MaPX
CLOSE contro
DEALLOCATE contro
END
GO
/****** Object:  StoredProcedure [dbo].[ThemPN]    Script Date: 12/03/2015 20:45:50 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[TK_PX]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TK_PX] (@Ngay1 date, @Ngay2 date)
AS
BEGIN
	SELECT MaPX, MaCN, NgayXuat FROM PHIEUXUAT WHERE NgayXuat BETWEEN @Ngay1 and @Ngay2 
END
GO
/****** Object:  StoredProcedure [dbo].[TK_PN]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TK_PN] (@Ngay1 date, @Ngay2 date)
AS
BEGIN
	SELECT MaPN, MaNCC, NgayNhap FROM PHIEUNHAP WHERE NgayNhap BETWEEN @Ngay1 and @Ngay2 
END
GO
/****** Object:  StoredProcedure [dbo].[TienXuat]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TienXuat] (@MaPX varchar(10))
AS
BEGIN
	DECLARE @tien float
	SELECT @tien = SUM(ThanhTien) FROM CHITIETPHIEUXUAT WHERE MaPX = @MaPX
	UPDATE PHIEUXUAT SET TongTien = @tien WHERE MaPX = @MaPX
END
GO
/****** Object:  StoredProcedure [dbo].[TienNhap]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TienNhap] (@MaPN varchar(10))
AS
BEGIN
	DECLARE @tien float
	SELECT @tien = SUM(ThanhTien) FROM CHITIETPHIEUNHAP WHERE MaPN = @MaPN
	UPDATE PHIEUNHAP SET TongTien = @tien WHERE MaPN = @MaPN
END
GO
/****** Object:  StoredProcedure [dbo].[ThemCTPX]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemCTPX] @mapx varchar(10), @mahh varchar(10), @soluong int, @dongia float, @thanhtien float
AS
BEGIN
INSERT INTO CHITIETPHIEUXUAT(MaPX, MaHH, SoLuong, DonGia, ThanhTien) values (@mapx, @mahh, @soluong, @dongia, @thanhtien)
END
GO
/****** Object:  StoredProcedure [dbo].[ThemCTPN]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemCTPN] @mapn varchar(10), @mahh varchar(10), @soluong int, @dongia float, @thanhtien float
AS
BEGIN
INSERT INTO CHITIETPHIEUNHAP(MaPN, MaHH, SoLuong, DonGia, ThanhTien) values (@mapn, @mahh, @soluong, @dongia, @thanhtien)
END
GO
/****** Object:  StoredProcedure [dbo].[HT_TK_CTPX]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[HT_TK_CTPX](@Ngay1 date, @Ngay2 date)
AS
BEGIN
	SELECT ctpx.MaHH, ctpx.SoLuong, ctpx.DonGia, ctpx.ThanhTien FROM PHIEUXUAT px, CHITIETPHIEUXUAT ctpx 
	WHERE px.NgayXuat BETWEEN @Ngay1 and @Ngay2 and px.MaPX = ctpx.MaPX
END
GO
/****** Object:  StoredProcedure [dbo].[HT_TK_CTPN]    Script Date: 12/03/2015 20:45:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[HT_TK_CTPN] (@Ngay1 date, @Ngay2 date)
AS
BEGIN
	SELECT ctpn.MaHH, ctpn.SoLuong, ctpn.DonGia, ctpn.ThanhTien FROM PHIEUNHAP pn, CHITIETPHIEUNHAP ctpn 
	WHERE pn.NgayNhap BETWEEN @Ngay1 and @Ngay2 and pn.MaPN = ctpn.MaPN
END
GO
/****** Object:  ForeignKey [FK_CHITIETPHIEUNHAP_HANGHOA]    Script Date: 12/03/2015 20:45:47 ******/
ALTER TABLE [dbo].[CHITIETPHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETPHIEUNHAP_HANGHOA] FOREIGN KEY([MaHH])
REFERENCES [dbo].[HANGHOA] ([MaHH])
GO
ALTER TABLE [dbo].[CHITIETPHIEUNHAP] CHECK CONSTRAINT [FK_CHITIETPHIEUNHAP_HANGHOA]
GO
/****** Object:  ForeignKey [FK_CHITIETPHIEUNHAP_PHIEUNHAP]    Script Date: 12/03/2015 20:45:47 ******/
ALTER TABLE [dbo].[CHITIETPHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETPHIEUNHAP_PHIEUNHAP] FOREIGN KEY([MaPN])
REFERENCES [dbo].[PHIEUNHAP] ([MaPN])
GO
ALTER TABLE [dbo].[CHITIETPHIEUNHAP] CHECK CONSTRAINT [FK_CHITIETPHIEUNHAP_PHIEUNHAP]
GO
/****** Object:  ForeignKey [FK_CHITIETPHIEUXUAT_HANGHOA]    Script Date: 12/03/2015 20:45:47 ******/
ALTER TABLE [dbo].[CHITIETPHIEUXUAT]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETPHIEUXUAT_HANGHOA] FOREIGN KEY([MaHH])
REFERENCES [dbo].[HANGHOA] ([MaHH])
GO
ALTER TABLE [dbo].[CHITIETPHIEUXUAT] CHECK CONSTRAINT [FK_CHITIETPHIEUXUAT_HANGHOA]
GO
/****** Object:  ForeignKey [FK_CHITIETPHIEUXUAT_PHIEUXUAT]    Script Date: 12/03/2015 20:45:47 ******/
ALTER TABLE [dbo].[CHITIETPHIEUXUAT]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETPHIEUXUAT_PHIEUXUAT] FOREIGN KEY([MaPX])
REFERENCES [dbo].[PHIEUXUAT] ([MaPX])
GO
ALTER TABLE [dbo].[CHITIETPHIEUXUAT] CHECK CONSTRAINT [FK_CHITIETPHIEUXUAT_PHIEUXUAT]
GO
/****** Object:  ForeignKey [FK_PHIEUNHAP_NHACUNGCAP]    Script Date: 12/03/2015 20:45:47 ******/
ALTER TABLE [dbo].[PHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_PHIEUNHAP_NHACUNGCAP] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NHACUNGCAP] ([MaNCC])
GO
ALTER TABLE [dbo].[PHIEUNHAP] CHECK CONSTRAINT [FK_PHIEUNHAP_NHACUNGCAP]
GO
/****** Object:  ForeignKey [FK_PHIEUXUAT_CHINHANH]    Script Date: 12/03/2015 20:45:47 ******/
ALTER TABLE [dbo].[PHIEUXUAT]  WITH CHECK ADD  CONSTRAINT [FK_PHIEUXUAT_CHINHANH] FOREIGN KEY([MaCN])
REFERENCES [dbo].[CHINHANH] ([MaCN])
GO
ALTER TABLE [dbo].[PHIEUXUAT] CHECK CONSTRAINT [FK_PHIEUXUAT_CHINHANH]
GO
