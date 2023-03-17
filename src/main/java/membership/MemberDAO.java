package membership;

import common.JDBCConnect;

public class MemberDAO extends JDBCConnect { // 상속하지 않고 인스터스를 만들어도 됨. 이책은 이렇게 하네
	// 명시한 데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성합니다.
	
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv,url, id, pw); // JDBCConnect.java 의 2번째 생성자를 불러옴
	}
	
	public MemberDAO() { // JDBCConnect.java 의 첫번째 생성자를 불러옴
		super();
	}	
	
	// 명시한 아이디/ 패스워드와 일치하는 회원 정보를 반환합니다.
	public MemberDTO getMemberDTO(String uid, String upass) {
		
		MemberDTO dto = new MemberDTO(); // dto 객체 생성
		
		// 쿼리문 템플릿
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			// 쿼리 실행 
			psmt = con.prepareStatement(query); // 동적 쿼리문 준비
			psmt.setString(1, uid); // 쿼리문 첫 번째 인파라미터 값 설정
			psmt.setString(2, upass);// 쿼리문 두 번째 인파라미터 값 설정
			rs = psmt.executeQuery(); // 쿼리문 실행
			// 실행한 결과 레코드는 ResultSet 객체 rs 에 담겨 반환됨
		
			// 결과 처리
			if(rs.next()){
				// 쿼리 결과로 얻은 회원 정보를 DTO 객체에 저장
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
		
	}
}
