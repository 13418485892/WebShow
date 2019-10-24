<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<!-- Optional JavaScript -->
		<!-- jQuery first, then Popper.js, then Bootstrap JS -->
		<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<title>Insert title here</title>
		<style type="text/css">
			.form-control {
				width: 300px;
				height: 30px;
				float: right;
			}
			
			select {
				width: 210px;
				height: 30px;
			}
			
			.submit {
				margin-left: 100px;
				margin-right: 30px;
			}
			
			.contain {
				width: 1000px;
				border: 1px #bbb solid;
				background-color: #eee;
				padding-top: 20px;
				border-radius: 10px;
			}
			
			label {
				display: inline-block;
				width: 100px;
				margin-right: 10px;
			}
			
			form {
				margin-left: 300px;
			}
		</style>
	</head>

	<body>
	<%!
	    String source_name;
		String name;
		String password;
		String vip;
		java.sql.Date end_day;
		String detail;
	%>
	
	<%
		if((String)session.getAttribute("user")==null){
			out.print("<script language='JavaScript'>alert('请先登录！');window.location.href='Login.html'</script>");
		}
	
		request.setCharacterEncoding("UTF-8");
		name = request.getParameter("name");
		String sqlid = "SELECT * FROM user_tbl where user_name='"+name+"'";
		source_name = name;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChanUserManage","root","");
			Statement sql = con.createStatement();
			ResultSet rs = sql.executeQuery(sqlid);
			if(rs.next()){
				name = rs.getString(2);
				password = rs.getString(3);
				vip = rs.getString(6);
				end_day = rs.getDate(5);
				detail = rs.getString(7);			
			}
			rs.close();
			sql.close();
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
		<div class="contain">
			<form action="AlertUserDB.jsp?sourceName='<%=source_name %>'" method="post">
				<div class="form-group form-inline">
				<label for="name">用户名:</label>
					<input type="text" class="form-control" id="name" name="name" maxlength="20" value='<%=name %>' required="required">
				</div>
				
				<div class="form-group form-inline">
				<label for="password">密码:</label>
					<input type="text" class="form-control" id="password" name="password" maxlength="20" value='<%=password %>' required="required">
				</div>
				
				<div class="form-group form-inline">
					<label for="vip">VIP:</label>
					<select name="vip" id="vip" class="vip">
						<option selected="selected">0</option>
						<option selected="selected">1</option>
						<option selected="selected">2</option>
						<option selected="selected">3</option>
						<option selected="selected" value='<%=vip %>'><%=vip %></option>
					</select>
				</div>
				
				<div class="form-group form-inline">
					<label for="end_day">到期日期:</label>
					<input type="date" class="form-control" id="end_day" name="end_day" value='<%=end_day %>' required="required">
				</div>
			
				<div class="form-group form-inline">
				<label for="detail">备注:</label>
					<input type="text" class="form-control" id="detail" name="detail" value='<%=detail %>'  required="required">
				</div>
				
				<div class="form-group form-inline">
					<input type="submit" id="" name="" class="btn btn-primary submit" value='修改' /><input type="reset" class="btn btn-warning" value="重置" />
				</div>
			</form>
		</div>
	</body>
	</html>