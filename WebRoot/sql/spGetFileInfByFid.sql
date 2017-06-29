-- =============================================
-- Author:		Xproer
-- Create date: 2012-10-25
-- Description:	根据ID获取文件详细信息
-- =============================================
CREATE PROCEDURE [dbo].[spGetFileInfByFid]
	-- Add the parameters for the stored procedure here
	@f_id int	--文件ID。
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sql nvarchar(1000);
	DECLARE @ParamDef nvarchar(500);

	SET @sql = N'select top 1 * from up6_files where f_id=@f_id';
	SET @ParamDef = N'@f_id int';
    -- Insert statements for procedure here
	EXECUTE sp_executesql @sql, @ParamDef,@f_id

END

