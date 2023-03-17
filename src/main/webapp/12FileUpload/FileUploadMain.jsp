<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
</head>

<script>
	function validateForm(form){
		if(form.name.value == "") {
			alert("작성자를 입력하세요.");
			form.name.focus();
			return false;
		}
		if(form.title.value == ""){
			alert("제목를 입력하세요.");
			return false;
		}
		if(form.attachedFile.value == ""){
			alert("첨부파일은 필수 입력입니다.");
			return false;
		}
	}
</script>
	
<body>

	
	
	<!-- 로그인 버튼을 누르면 "LoginProcess.jsp"를 호출. 메서드는 post 방식으로. -->
	<h3> 파일 업로드</h3>
	<span style="color: red;">${errorMessage }</span> <!-- 처음에 데이터가 없기때문에 아무것도 안보임 -->
	<!-- UploadProcess.jsp로 액션 페이지 -->
	<form name="fileForm" action="UploadProcess.jsp" method="post" 
	enctype="multipart/form-data" onsubmit="return validateForm(this);"> <!-- 파일을 업로드할때는 무조건 enctype="multipart/form-data"  -->
		작성자 : <input type="text" name="name" value="머스트해브" /> <br />
		제목 : <input type="text" name="title" /> <br />
		카테고리(선택사항) : 
		<input type="checkbox" name="cate" value="사진" checked />사진
		<input type="checkbox" name="cate" value="과제" />과제
		<input type="checkbox" name="cate" value="워드" />워드
		<input type="checkbox" name="cate" value="음원" />음원<br />
		첨부파일 : <input type="file" name="attachedFile" />
		<input type="submit" value="전송하기" />
	</form>
	
</body>
</html>