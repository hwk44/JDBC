<%@ page import="utils.CookieManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String loginId = CookieManager.readCookie(request, "loginId");
    
    String cookieCheck = "";
    if(!loginId.equals("")) {
    	cookieCheck = "checked";
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현언어 EL 폼값 처리</title>
</head>
<body>
	<h2>폼값 전송하기</h2>
	<form name="frm" method="post" action="FormResult.jsp" >
		이름 : <input type="text" name="name" />
		성별 : <input type="radio" name="gender" value="Man" />남자
			  <input type="radio" name="gender" value="Woman" />여자
		학력 :<!--  -->
		<select name="grade">
		 <option type="ele">초딩</option>
		 <option type="mid">중딩</option>
		 <option type="high">고딩</option>
		 <option type="uni">대딩</option>
		</select><br />
		
		관심 사항: <!-- 체크박스는 배열로 넘어옴 -->
			<input type="checkbox" name="inter" id="pol" value="pol" />
			<label for="pol">정치&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input type="checkbox" name="inter" value="eco" />경제
			<input type="checkbox" name="inter" value="ent" />연예
			<input type="checkbox" name="inter" value="spo" />운동
		<br />
		<input type="submit" value="전송하기" />
	</form>

</body>
</html>