USE [HttpUploader6]
GO
/****** 对象:  StoredProcedure [dbo].[f_process]    脚本日期: 10/30/2012 15:20:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Xproer
-- Create date: 2012-10-25
-- Description:	删除文件
-- =============================================
--drop procedure [dbo].[down_del]
CREATE PROCEDURE [dbo].[down_f_del]
	-- Add the parameters for the stored procedure here
	 @f_uid int
	,@f_id int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @sql nvarchar(4000);
	DECLARE @ParamDef nvarchar(500);

    SET @sql=N'delete from down_files where f_id=@f_id and f_uid=@f_uid'
	SET @ParamDef = N'@f_id int
					,@f_uid int';

    -- Insert statements for procedure here
	EXEC sp_executesql @sql,@ParamDef,@f_id,@f_uid

	--清除子文件
	SET @sql = N'delete from down_files where f_pidRoot=@f_id and f_uid=@f_uid;'
	EXEC sp_executesql @sql,@ParamDef,@f_id,@f_uid
END