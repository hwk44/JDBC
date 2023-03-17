<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBCConnectWorld"%>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>

	<h2>회원 목록 조회 테스트(executeUpdate() 사용)</h2>
	<%
	// DB에 연결
	JDBCConnectWorld jdbc = new JDBCConnectWorld();

	// 쿼리문 생성
	String sql = "select count(*) from countrylanguage where language = 'English'";
	Statement stmt = jdbc.con.createStatement();

	// 쿼리 수행
	ResultSet rs = stmt.executeQuery(sql);

	String count = "";
	
	
	StringBuilder st = new StringBuilder();
	st.append("<table class=\"table\">" +
			  "<thead>" +
			    "<tr>" +
			      "<th scope=\"col\">#</th>" +
			      "<th scope=\"col\">count</th>" +
			    "</tr>" +
			  "</thead>" );
	
	st.append("<tbody");
	int cnt = 1;
	 while(rs.next()){ 
		count = rs.getString("count(*)");

		st.append(count);
		st.append("<tr><th scope=\"row\">");
		st.append(String.valueOf(cnt++));
		st.append("</th><td>");
		st.append(count);
		st.append("</td>"); ;
	   /*  st.append("</td>" +
				   " </tr>" +
				   " <tr>" +
				      "<th scope=\"row\">2</th>" +
				      "<td>Jacob</td>" +
				      "<td>Thornton</td>" +
				      "<td>@fat</td>" +
				    "</tr>" +
				   " <tr>" +
				     " <th scope=\"row\">3</th>" +
				      "<td colspan=\"2\">Larry the Bird</td>" +
				     " <td>@twitter</td>" +
				    "</tr>" +
				  "</tbody>"); */
	}
	 st.append("</table>");
	 
    %>
    
    <h4><%= st %></h4>
    <%
	
	// 연결 닫기
	// jdbc.close();
	%>
</body>
</html>