<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
String num = request.getParameter("num"); 	// 일련번호 받기

BoardDAO dao = new BoardDAO(application); 	// dao 생성
dao.updateVisitCount(num); 					// 조회수 증가
BoardDTO dto = dao.selectView(num);			// 게시물 가져오기
dao.close(); 								// DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<!-- <script type="text/javascript">
function deletePost(){
	
	// 8.7절
	var confirmed = confirm("정말로 삭제하겠습니까?");
	if(confirmed) {
		var form = document.writeFrm;	  // 이름(name) 이 "writeFrm"인 폼 선택
		form.method = "post";			  // 전송 방식 
		form.action = "DeleteProcess.jsp" // 전송 경로
		form.submit();					  // 폼값 전송
	}
}
</script> -->
</head>
<body>
<h2>파일 첨부형 게시판 - 상세 보기 (View)</h2>
<form name="writeFrm">
	<input type="hidden" name="num" value="<%= num%>" />
	<table border="1" width="90%">
	
		<colgroup>
			<col width="15%"/> <col width="35%" />
			<col width="15%"/> <col width="*" />
		</colgroup>
		<tr>
			<td>번호 </td>
			<td>${  dto.idx }</td>
			<td>작성자</td>
			<td>${  dto.name }</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${ dto.postdate }</td>
			<td>조회수</td>
			<td>${ dto.visitcount }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3">${ dto.title }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="3" height="100">
			${ dto.content }</td>
		</tr>
		
		<tr>
			<td>첨부파일</td>
			<td>
				<c:if test="${not empty dto.ofile }">
				${dto.ofile }
				<a href="../mvboard/download.do?ofile=${dto.ofile }&sfile=${dto.sfile}&idx=${dto.idx}
				">[다운로드]</a>
				</c:if>
			</td>
		</tr>
		
		<!-- 하단 메뉴 버튼 -->
		
		<tr>
			<td colspan="4" align="center">
				<button type="button" onclick="location.href='../mvboard/pass.do?mode=edit&idx=${param.idx}';">수정하기</button>
				<button type="button" onclick="location.href='../mvboard/pass.do?mode=delete&idx=${param.idx}';">삭제하기</button>
				<button type="button" onclick="location.href='../mvboard/list.do';">목록바로가기</button>
			
			
			</td>
			
		</tr>
	</table>
</form>
</body>
</html>