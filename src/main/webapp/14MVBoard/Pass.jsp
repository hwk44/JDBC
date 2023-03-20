<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<script type="text/javascript">
function validateForm(form){
	
	if(form.pass.value == "") {
		alert("비밀번호를 입력하세요");
		form.pass.focus();
		return false;
	}
}
</script> 
</head>
<body>
	<h3>파일 첨부형 게시판 - 비밀번호 검증(pass)</h3>
	<form name="writeFrm" action="../mvboard/pass.do" method="post"
	 onsubmit="return validateForm(this);"> <!-- 파일을 업로드할때는 무조건 enctype="multipart/form-data"  -->
		<input type="hidden" name="idx" value=${param.idx }/>
		<input type="hidden" name="mode" value=${param.mode }/>
	
	
	<table border="1" width=90%">
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pass" style="width:100px;"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<button type="submit">검증하기</button>
			<button type="reset">RESET</button>
			<button type="button" onclick="location.href='../mvboard/list.do';">목록 바로가기</button>
			</td>
		</tr>
		
	</table>
		
	</form>

</body>
</html>