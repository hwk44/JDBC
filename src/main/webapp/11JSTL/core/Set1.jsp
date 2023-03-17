<%@ page import="java.util.Date"%>
<%@ page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - Set1</title>
</head>
<body>
	<!-- 변수 선언부 -->
	<!-- 접두어 "c" namespace 식별자 사용시 범위를 정해 같은 카테고리에서 사용하게 -->
	<!-- 본인이 만든것과 표준 라이브러리가 충돌하지 않게 접두어를 사용하는 것임 -->
	<c:set var="directVar" value="100" />
	<c:set var="elVar" value="${directVar mod 5 }" />
	<c:set var="expVar" value="<%=new Date()%>" />
	<c:set var="betweenVar">변수값 이렇게 설정 </c:set>

	<h4>EL을 이용한 변수 출력</h4>
	<ul>
		<li>directVar : ${pageScope.directVar }</li>
		<li>elVar : ${elVar}</li>
		<li>expVar : ${expVar }</li>
		<li>betweenVar : ${betweenVar }</li>
	</ul>
	
	<h4>자바빈즈 생성 1 - 생성자 사용</h4>
	<c:set var="personVar1" value="<%=new Person(\"박문수\", 50)%>"
		scope="request" />

	<ul>
		<li>이름 : ${requestScope.personVar1.name}</li>
		<li>나이 : ${personVar1.age}</li>
	</ul>

	<h4>자바빈즈 생성 2 - target, property 사용</h4>
	<c:set var="personVar2" value="<%=new Person()%>" scope="request" />
	<c:set target="${personVar2 }" property="name" value="정약용" />
	<c:set target="${personVar2 }" property="age" value="60" />
	<ul>
		<li>이름 : ${requestScope.personVar2.name}</li>
		<li>나이 : ${personVar2.age}</li>
	</ul>

	<!-- common 패키지의 Person 클래스로 personVar3이라는 자바빈즈를 생성 request 영역에 저장 -->
	<jsp:useBean id="personVar3" class="common.Person" scope="request" />

	<!-- personVar3 자바빈즈의 name 과 age 멤버 변수에 값을 설정 이때는 세터를 이용 -->
	<jsp:setProperty name="personVar3" property="name" value="이말년" />
	<jsp:setProperty name="personVar3" property="age" value="41" />

	<h4>자바빈즈 생성 2 - 액션 태그 사용</h4>
	<ul>
		<li>이름 : <jsp:getProperty name="personVar3" property="name" /></li>
		<li>나이 : <jsp:getProperty name="personVar3" property="age" /></li>
	</ul>
	
	
</body>
</html>