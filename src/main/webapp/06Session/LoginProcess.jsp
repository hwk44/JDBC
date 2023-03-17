<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
// 로그인 폼으로부터 받은 아이디와 패스워드 request 메서드로 받음
String userId = request.getParameter("user_id"); 
String userPwd = request.getParameter("user_pw");


// web.xml에서 가져온 데이터베이스 연결 정보
String mysqlDriver = application.getInitParameter("mysqlDriver");
String mysqlURL = application.getInitParameter("mysqlURL");
String mysqlId = application.getInitParameter("mysqlId");
String mysqlPwd = application.getInitParameter("mysqlPwd");


// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDAO dao = new MemberDAO(mysqlDriver, mysqlURL, mysqlId, mysqlPwd); // 두번째 생성자 이용.
// MemberDAO dao = new MemberDAO(); // 첫번째 생성자 이용. 이럴경우 web.xml 에서 연결 정보를 가져올 필요가 없음

MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
dao.close();


/* if(userId.equals("musthave") && userPwd.equals("1234")){
	// 로그인 성공
	session.setAttribute("UserId", userId);
	session.setAttribute("UserName", "홍길동");
	response.sendRedirect("LoginForm.jsp"); */

if(memberDTO.getId() != null) {
		// 로그인 성공
		session.setAttribute("UserId", memberDTO.getId());
		session.setAttribute("UserName", memberDTO.getName());
		response.sendRedirect("LoginForm.jsp");
}else {
	// 로그인 실패
	 request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	 request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
	
}
%>
