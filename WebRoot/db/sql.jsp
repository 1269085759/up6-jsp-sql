<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ 
	page import="java.io.File"%><%@
	page import="java.io.BufferedReader"%><%@
	page import="java.io.FileReader"%><%@
	page import="java.io.InputStreamReader"%><%@
	page import="java.io.FileInputStream"%><%@
	page import="up6.DbHelper"%><%@
	page import="up6.PathTool"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


String pathCur = application.getRealPath(request.getServletPath());
String pathParent = new File(pathCur).getParent();
pathParent = new File(pathParent).getParent();
String sqlDir = PathTool.combine(pathParent,"sql");
String downDir = PathTool.combine(pathParent,"sql.down");
DbHelper db = new DbHelper();
String[] sql_clear = {
					 "if object_id('f_process') is not null drop procedure f_process"
			        ,"if object_id('fd_fileProcess') is not null drop procedure fd_fileProcess"
			    	,"if object_id('fd_files_add_batch') is not null drop procedure fd_files_add_batch"
			        ,"if object_id('fd_files_check') is not null drop procedure fd_files_check"
			        ,"if object_id('spGetFileInfByFid') is not null drop procedure spGetFileInfByFid"
			        ,"if object_id('fd_add_batch') is not null drop procedure fd_add_batch"
			        ,"if object_id('down_f_del') is not null drop procedure down_f_del"
			        ,"if object_id('down_f_process') is not null drop procedure down_f_process"
			        ,"if object_id('up6_files') is not null drop table up6_files"
			        ,"if object_id('up6_folders') is not null drop table up6_folders"
			        ,"if object_id('down_files') is not null drop table down_files"
			        ,"if object_id('down_folders') is not null drop table down_folders",
					};
for(String str : sql_clear)
{
	db.ExecuteNonQuery(str);	
}

File dir = new File(sqlDir);
if(dir.exists())
{
	File[] files = dir.listFiles();
	if(files.length > 0)
	{
		for(File file : files)
		{
			if(file.getName().endsWith(".sql"))
			{
				InputStreamReader isr = new InputStreamReader(new FileInputStream(file), "UTF-8");
				BufferedReader reader = new BufferedReader(isr);
				StringBuffer buffer = new StringBuffer();
				String text;
				while((text = reader.readLine()) != null)
				{
					buffer.append(text + "\n");
				}
				String output = buffer.toString();
				db.ExecuteNonQuery(output);
			}
		}
	}	
}

dir = new File(downDir);
if(dir.exists())
{
	File[] files = dir.listFiles();
	if(files.length > 0)
	{
		for(File file : files)
		{
			if(file.getName().endsWith(".sql"))
			{
				InputStreamReader isr = new InputStreamReader(new FileInputStream(file), "UTF-8");
				BufferedReader reader = new BufferedReader(isr);
				StringBuffer buffer = new StringBuffer();
				String text;
				while((text = reader.readLine()) != null)
				{
					buffer.append(text + "\n");
				}
				String output = buffer.toString();
				db.ExecuteNonQuery(output);
			}
		}
	}
}
out.write("数据库初始化完毕");
%>


