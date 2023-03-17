<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");  // 날짜 표시 형식
	
	long creationTime = session.getCreationTime();
	String creationTimeStr = dateFormat.format(new Date(creationTime));
	
	long lastTime = session.getCreationTime();
	String lastTimeStr = dateFormat.format(new Date(lastTime));

	/* 
	처음 서버에 접속할때 session 영역이 만들어짐.
	서버와 통신을 할때는
	요청하는 정보는 세션에서 관리를 하고 있음. 로그인이 가장 대표적인 정보.
	브라우저를 끄면
	더이상 그 서버로 엑세스를 안함.
	서버에서는 일정 시간이 지난 후에 자동으로 세션을 지워버림
	다음부터는 처음 접근 하는 것 처럼 세션을 만듦
	
	처음 접속을 하게 되면 서버에서 클라이언트의 요청을 받아(request. url 형식으로)
	그 정보에서 쿠기가 있는지? 세션이 있는지 확인
	없으면 세션을 만들고 아이디를 임의로 할당
	
	그 세션 아이디를 쿠키에 담아 response 객체로 담아 클라이언트로 보냄
	다음 요청에는 그 쿠키를 가지고 이동

	*/	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session</title>
</head>
<body>

	<h2>Session 설정 확인</h2>
	<ul>
		<li>세션 유지 시간 : <%= session.getMaxInactiveInterval() %></li>
		<li>세션 아이디 : <%= session.getId() %></li>
		<li>최초 요청 시각: <%= creationTimeStr %></li>
		<li>마지막 요청 시각 : <%= lastTimeStr %></li>
		
	</ul>
</body>
</html>