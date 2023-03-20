package utils;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class JSFunction {
	// 메세지 알림창을 띄운 후 명시한 URL로 이동합니다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		try {
			String script = "" // 삽입할 자바스크립트 코드
							+"<script>"
							+"   alert('" + msg + "');"
							+"   location.href='" + url + "';"
							+"</script>";
			out.println(script);
		}
		catch (Exception e ) {}
	}

	// 메세지 알림창을 띄운 후 이전 페이지로 돌아갑니다.
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = "" // 삽입할 자바스크립트 코드
					+"<script>"
					+"   alert('" + msg + "');"
					+"   history.back();"
					+"</script>";
				out.println(script);
		}
		catch(Exception e) {}
	}
	
	// 메세지 알림창을 띄운 후 명시한 URL로 이동합니다. 14장
	public static void alertLocation(HttpServletResponse resp, String msg, String url) {
		try {
			
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = "" // 삽입할 자바스크립트 코드
							+"<script>"
							+"   alert('" + msg + "');"
							+"   location.href='" + url + "';"
							+"</script>";
			writer.print(script);
		}
		catch (Exception e ) {}
	}
	
	// 메세지 알림창을 띄운 후 이전 페이지로 돌아갑니다. 14장
		public static void alertBack(HttpServletResponse resp, String msg) {
			try {
				resp.setContentType("text/html;charset=UTF-8");
				PrintWriter writer = resp.getWriter();
				String script = "" // 삽입할 자바스크립트 코드
						+"<script>"
						+"   alert('" + msg + "');"
						+"   history.back();"
						+"</script>";
					writer.println(script);
			}
			catch(Exception e) {}
		}
		
	
}
