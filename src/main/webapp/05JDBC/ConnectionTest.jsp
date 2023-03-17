<%@ page import="common.JDBCConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC 테스트1</title>
</head>
<body>
	<h2> JDBC 테스트 1 </h2>
<%
	JDBCConnect jdbc1 = new JDBCConnect();
	jdbc1.close();
%>

	<h2>JDBC 테스트 2 </h2>
	<%
	String driver = application.getInitParameter("mysqlDriver");
	String url = application.getInitParameter("mysqlURL");
	String id = application.getInitParameter("mysqlId");
	String pwd = application.getInitParameter("mysqlPwd"); 
	JDBCConnect jdbc2 = new JDBCConnect(driver,url, id, pwd ); 
	jdbc2.close();
	%>
	
	<h2>JDBC 테스트 3</h2>
	<%
	JDBCConnect jdbc3 = new JDBCConnect(application); 
	jdbc3.close();
	
	%>
	
</body>
</html>