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

	//添加用户资料
	if((String)session.getAttribute("user")==null){
		out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='Login.html'</script>");
	}

	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String vip = request.getParameter("vip");
	String end_day = request.getParameter("end_day");
	String detail = request.getParameter("detail");
	
	String sqlQuery = "INSERT INTO user_tbl (`user_name`, `user_password`, `user_vip`, `end_day`, `user_detail`) VALUES (?, ?, ?, ?, ? )";
	String sqlid = "SELECT * FROM user_tbl where user_name = '"+name+"' ";
	Connection con = null;
	Statement stat = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChanUserManage","root","");
		stat = con.createStatement();
		rs = stat.executeQuery(sqlid);
		
		if(rs.next())
		{
			out.print("<script type='text/javascript'>alert('用户名重复!请重新输入!');window.location.href = document.referrer;</script>");
		}
		else
		{
			ps = con.prepareStatement(sqlQuery);
			ps.setString(1,name);
			ps.setString(2,password);
			ps.setString(3,vip);
			ps.setString(4,end_day);
			ps.setString(5,detail);
			ps.executeUpdate();
			out.print("<script type='text/javascript'>alert('添加用户信息成功!');window.location.href='Contain.jsp?pages=1';</script>");
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