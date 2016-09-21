USE [HttpUploader6]
GO
/****** 对象:  StoredProcedure [dbo].[fd_fileProcess]    脚本日期: 04/03/2016 17:48:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		zysoft
-- Create date: 2016-07-31
-- Description:	批量添加子文件
-- =============================================
ALTER PROCEDURE [dbo].[fd_files_add_batch]	
	 @f_count int			--文件总数，要单独增加一个文件夹
	,@fd_count int			--文件夹总数
	,@f_ids varchar(8000) output
	,@fd_ids varchar(8000) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @i int;
	set @i = 0;
	set @f_ids = '';
	set @fd_ids = '';

	/*批量添加文件夹*/
	while @i < @fd_count
	begin
		insert into up6_folders(fd_pid) values(0);
		set @fd_ids = @fd_ids + ltrim(str(@@IDENTITY)) + ',';
		set @i = @i + 1;
	end

	/*批量添加文件*/
	set @i = 0;
	while @i < @f_count
	begin
		insert into up6_files(f_pid) values(0)
		set @f_ids = @f_ids + ltrim(str(@@IDENTITY)) + ',';
		set @i = @i+1
	end
	
	--清除,
	set @f_ids = substring(@f_ids,1,len(@f_ids)-1);
	set @fd_ids = substring(@fd_ids,1,len(@fd_ids) -1);	
END


