USE [QL_KhoHang] 
GO
/****** Object:  StoredProcedure [dbo].[ThemCTHD]    Script Date: 11/13/2015 07:44:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemCTPN] @mapn varchar(10), @mahh varchar(10), @soluong int, @dongia float, @thanhtien float
AS
BEGIN
INSERT INTO CHITIETPHIEUNHAP(MaPN, MaHH, SoLuong, DonGia, ThanhTien) values (@mapn, @mahh, @soluong, @dongia, @thanhtien)
END
