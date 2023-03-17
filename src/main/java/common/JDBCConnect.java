package common;

//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.Statement;

import java.sql.*;
import javax.servlet.ServletContext;

public class JDBCConnect {
	// Connection : 데이터베이스와 연결을 담당
	public Connection con;
	
	// Statement 인파라미터가 없는 정적 쿼리문
	public Statement stmt;

	// PreparedStatement 인파라미터가 있는 동적 쿼리문
	public PreparedStatement psmt;
	
	// ResultSet select 쿼리문 결과를 저장 (테이블 저장)
	public ResultSet rs; 

	public  JDBCConnect(){ // 기본 생성자
		try {
			// JDBC 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// H2 DB 에 연결
//			String url = "jdbc:h2:tcp://localhost/~/musthave";
//			String id = "sa";
//			String pwd = "";
			
			String url = "jdbc:mysql://localhost:3306/musthave";
			String id = "musthave";
			String pwd = "tiger";

			con = DriverManager.getConnection(url,id,pwd);
			
			System.out.println("DB 연결 성공 (기본 생성자)");
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public  JDBCConnect(String driver, String url, String id, String pwd){ // 2번째 생성자
		try {
			// JDBC 드라이버 로드
			Class.forName(driver);

			con = DriverManager.getConnection(url,id,pwd);
			
			System.out.println("DB 연결 성공 (인수 생성자 1)");
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 세번째 생성자
	public  JDBCConnect(ServletContext application){ // 3번째 생성자
		try {
			// JDBC 드라이버 로드
			String driver = application.getInitParameter("mysqlDriver");
			Class.forName(driver);

			// db에 연결
			String url = application.getInitParameter("mysqlURL");
			String id = application.getInitParameter("mysqlId");
			String pwd = application.getInitParameter("mysqlPwd");
			con = DriverManager.getConnection(url,id,pwd);
			
			System.out.println("DB 연결 성공 (인수 생성자 2)");
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * public static void main(String[] args) { JDBCConnect jdbc = new
	 * JDBCConnect(); }
	 */
	// 연결 해제 (자원 반납)
	public void close() {
		try {
			if (rs != null) rs.close();
			if (stmt != null) ((Connection) stmt).close();
			if (psmt != null) psmt.close();
			if (con != null) con.close();
			
			System.out.println("JDBC 자원 해제");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
