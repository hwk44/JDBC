<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String popupMode = "on";
    
    Cookie[] cookies = request.getCookies(); // 쿠키를 읽어 popupMode 값 설정
    if(cookies != null) {
    	for(Cookie c : cookies){
    		String cookieName = c.getName();
    		String cookieValue = c.getValue();
    		if(cookieName.equals("PopupClose")) { // "PopupClose" 쿠키가 존재하면
    			popupMode = cookieValue; // popupMode 의 값 갱신
    		}
    	}
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키를 이용한 팝업 관리</title>
<style>
	div#popup {
		position: absolute; top:100px; left:100px; color:yellow;
		width:300px; height:100px; background-color:gray;
	}
	div#popup>div{
		position: relative;
		background-color:#ffffff; top:0px
		border:1px solid gray; padding:10px; color:black;
	}
</style>
<script scr="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function(){
		$('#closeBtn').click(function() { // 닫기 버튼 (id="closeBtn")을 누르면
			$('#popup').hide(); // 팝업창 (id="popup") 을 숨김 처리합니다.
			var chkVal = $("input:checkbox[id=inactiveToday]:checked").val(); // 체크 여부
			
			$.ajax({
				url : './PopupCookie.jsp',
				type : 'get',
				data : {inactiveToday : chkVal},
				dataType : "text",
				success : function(resData) {
					if(resData != "") location.reload();
				}
			});
		});
	});
</script>
</head>
<body>

	<h2>팝업 메인 페이지</h2>
</body>
</html>