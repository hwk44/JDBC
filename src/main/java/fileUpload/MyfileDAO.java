package fileUpload;

import java.util.List;
import java.util.Vector;

import common.JDBCConnect;
//import model1.board.BoardDTO;

public class MyfileDAO extends JDBCConnect {
	
	// 새로운 게시물을 입력합니다.
	public int insertFile(MyfileDTO dto) {
		int applyResult = 0;
		
		try {
			
			String query = "INSERT INTO myfile ("
					+ " name, title, cate, ofile, sfile) "
					+ " VALUES ( ?, ?, ?, ?, ?)";
		
			psmt = con.prepareStatement(query); // 동적 쿼리
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getCate());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			
			applyResult = psmt.executeUpdate();	//
		}catch (Exception e) {
			System.out.println("INSERT 중 예외 발생");
		}
		
		
		return applyResult;
	}

	
	public List<MyfileDTO> myFileList() {
		List<MyfileDTO> fileList = new Vector<MyfileDTO>();
		// 쿼리문 준비
		String query = "SELECT * "
				+ " FROM myfile ORDER BY idx DESC";
		
		try {
			psmt = con.prepareStatement(query); // 쿼리 준비
			rs = psmt.executeQuery();			// 쿼리 실행
			
			while(rs.next()) { 	// 목록 안의 파일 수만큼 반복 . 쿼리 테이블 수 만큼 순회
				// dto가 쿼리 테이블을 한줄씩 순회 하면서 정보를 저장
				MyfileDTO dto = new MyfileDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setCate(rs.getString(4));
				dto.setOfile(rs.getString(5));
				dto.setSfile(rs.getString(6));
				dto.setPostdate(rs.getString(7));
				
				fileList.add(dto); //  목록에 추가
			}
		}catch(Exception e) {
			System.out.println("select 시 예외 발생");
			e.printStackTrace();
		}
		
			return fileList; // 목록반환
	}
}
