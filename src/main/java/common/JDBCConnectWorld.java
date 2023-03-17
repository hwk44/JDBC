package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


public class JDBCConnectWorld {
	
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs; 

	public  JDBCConnectWorld(){ // 기본 생성자
		try {
			// JDBC 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			String url = "jdbc:mysql://localhost:3306/world";
			String id = "musthave";
			String pwd = "tiger";

			con = DriverManager.getConnection(url,id,pwd);
			
			System.out.println("DB 연결 성공 (기본 생성자)");
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

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
