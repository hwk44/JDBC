<%@page import="java.lang.reflect.Array"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현언어 EL - board 출력</title>
</head>
<body>
	<h2>List 컬렉션</h2>
<%
	/* DAO 객체를 담을 어레이 리스트 생성 */
	// List<BoardDAO> bList = new ArrayList<BoardDAO>();
	ArrayList<BoardDTO> bList = new ArrayList<BoardDTO>();
	
	/* DAO 객체를 생성  데이터를 읽어옴 */
	BoardDAO dao = new BoardDAO(application);
	dao.pushData(bList);
	
	pageContext.setAttribute("bList", bList);
	// bList.add(dao);

		/* for(BoardDTO dto : bList){
			*/

		for(int idx=0; idx < bList.size(); idx++){
			pageContext.setAttribute("idx", idx);
 %>
		<tr>
	 	<td>${ bList[idx].num }</td> 
		<td>${ bList[idx].title }</td>
		<td>${ bList[idx].content} </td>
		<td>${ bList[idx].postdate} </td>
		<td>${ bList[idx].id} </td>
		<td>${ bList[idx].visitcount} </td>
		</tr>
		<br/>
	<% } %>
	
	
</body>
</html>