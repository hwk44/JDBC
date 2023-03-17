<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function validateForm(form){
		if(!form.user_id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		if(form.user_pw.value == ""){
			alert("패스워드를 입력하세요.");
			return false;
		}
	}
	</script>
<body>

<jsp:include page="../Common/Link.jsp" />
	<h2>회원가입 페이지</h2>
	<span style="color: red; font-size: 1.2em;"> 
		<%= request.getAttribute("LoginErrMsg") == null? // 크라이언트 요청을 어트리뷰트 LoginErrMsg 가 
				"" : request.getAttribute("LoginErrMsg") // 널값이면 아무것도 출력하지 말고, 있으면 메세지를 출력해라
		%>
	</span>
	<% // UserId 값을 읽었는데 null 값이면? 로그아웃상태. 있으면? else로 감
	if (session.getAttribute("UserId") == null){ 
		// 로그아웃 상태
	%>
	
	
	
	<!-- 로그인 버튼을 누르면 "LoginProcess.jsp"를 호출. 메서드는 post 방식으로. -->
	<form action="LoginProcess.jsp" method="post" name="loginFrm"
	onsubmit="return validateForm(this);">
		아이디 : <input type="text" name="user_id" /> <br />
		패스워드 : <input type="password" name="user_pw" /> <br />
		<input type="submit" value="로그인하기" />
	</form>
	<%
	} else{ //  로그인된 상태
	%>
		<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br />
		<a href="Logout.jsp">[로그아웃]</a>
		<%
		}
		%>

</body>
</html>