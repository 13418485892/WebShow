<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//修改用户资料

	if((String)session.getAttribute("user")==null){
		out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='Login.html'</script>");
	}

	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String sourceName = request.getParameter("sourceName");
	sourceName = sourceName.substring(1, sourceName.length()-1);//由于传值过来会被''括住，需要去除
	String password = request.getParameter("password");
	String vip = request.getParameter("vip");
	String end_day = request.getParameter("end_day");
	String detail = request.getParameter("detail");
//	String sqlQuery = "UPDATE user_tbl SET `user_password` = ?,`user_vip` = ?,`end_day` = ?,`user_detail` = ?  WHERE `user_name` = ? ";
	String sqlQuery = "UPDATE user_tbl SET user_password = ?, user_vip = ?, end_day = ?, user_detail = ? WHERE `user_name` = ? ";
	String sqlid = "SELECT * FROM user_tbl where user_name='"+name+"'";
	Connection con = null;
	Statement stat = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	boolean flag = true;
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChanUserManage","root","");
		stat = con.createStatement();
		rs = stat.executeQuery(sqlid);
		
		if(sourceName.equals(name))
		{
			flag = false;
		}
		/*//out.print(flag);
		out.print("<br/>"+sourceId);
		out.print("<br/>"+id);*/
		if(rs.next() && flag)
		{
			out.print("<script type='text/javascript'>alert('用户名重复!请重新输入!');window.location.href = document.referrer;</script>");
		}
		else
		{
			ps = con.prepareStatement(sqlQuery);
			ps.setString(1,password);
			ps.setString(2,vip);
			ps.setString(3,end_day);
			ps.setString(4,detail);
			ps.setString(5,sourceName);
			ps.executeUpdate();
			out.print("<script type='text/javascript'>alert('更改用户信息成功!');window.location.href='Contain.jsp?pages=1';</script>");
			ps.close();
		}
		rs.close();
		stat.close();
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
	
%>
</body>
</html>