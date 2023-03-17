<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>액션 태그 - UseBean</title>
</head>
<body>

	<h2>useBean 액션 태그</h2>
	<h3>자바빈스 생성하기</h3>
	<jsp:useBean id="person" class="common.Person" scope="request" />
	<!-- common 패키지의 Person 클래스로 person 이라는 자바빈즈를 생성해
	request 영역에 저장. 자바코드로 변경한다면 아래와 같음
	
	Person person = (Person)request.getAttribute("person"); // request 영역에서 가져옴
	if(person == null) { // 없으면 새로 생성해 저장
		person = new Person();
		request.setAttribute("person", person);
		}
	-->
	
	<h3>setProperty 액션 태그로 자바빈스 속성 지정하기</h3>
	<!-- person 자바빈즈의 name과 age 멤버 변수에 값을 설정했습니다. 이때 세터를 이용합니다.-->
	<jsp:setProperty property="name" name="person" value="임꺽정"/> 
	<jsp:setProperty property="age" name="person" value="41"/>
	
	<h3>getProperty 액션 태그로 자바빈스 속성 읽기</h3>
	<ul>
		<!-- 자바빈즈에서 멤버변수의 값을 출력했습니다. 이때 게터를 이용해 값을 추출합니다. -->
		<li>이름 : <jsp:getProperty name="person" property="name" /></li>
		<li>나이 : <jsp:getProperty name="person" property="age" /></li>
	</ul>
</body>
</html>