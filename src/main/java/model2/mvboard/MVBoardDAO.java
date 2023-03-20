package model2.mvboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;
import common.JDBCConnect;
import model1.board.BoardDTO;

public class MVBoardDAO extends JDBCConnect {

	public MVBoardDAO() {
		super(); // JDBCConnect 1번째 생성자
	}

	public MVBoardDAO(ServletContext application) {
		super(application); // JDBCConnect 3번째 생성자
	}

	// 검색 조건에 맞는 게시물 개수 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		// query
		String query = "SELECT COUNT(*) FROM mvboard";

		// 검색 조건이 있다면 where 절 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " " + " LIKE '%" + map.get("searchWord") + "%'";
		}
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			rs.next(); // 커서를 첫 번째 행으로 이동
			totalCount = rs.getInt(1); // 첫번째 칼럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}

		return totalCount;
	}

	// 검색 조건에 맞는 게시물 목록 반환 (페이징 기능 지원)
	public List<MVBoardDTO> selectListPage(Map<String, Object> map) {
		List<MVBoardDTO> board = new Vector<MVBoardDTO>();
		// 결과 (게시물목록)을 담을 변수

		// 쿼리문 템플릿
		String query = "SELECT * FROM mvboard ";

		// 검색 조건 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY idx DESC LIMIT ?,?";

		try {
			// 쿼리문 완성
			psmt = con.prepareStatement(query); // 동적 쿼리
			psmt.setInt(1, (int) map.get("start") - 1); // 인파라미터
//			psmt.setInt(2, (int)map.get("pageSize"));
			psmt.setInt(2, (int) map.get("end"));

			rs = psmt.executeQuery(); // 쿼리 실행

			// 반환된 게시물 목록을 List 컬렉션에 추가
			while (rs.next()) { // 결과를 순회하며
				// 한 행 (게시물 하나)의 내용을 DTO에 저장
				MVBoardDTO dto = new MVBoardDTO();
				dto.setIdx(rs.getString(1)); // 일련번호
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3)); // 제목
				dto.setContent(rs.getString(4)); // 내용
				dto.setPostdate(rs.getDate(5)); // 작성일

				dto.setOfile(rs.getString(6)); // 작성자 아이디
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(9));
				dto.setVisitcount(rs.getInt(10)); // 조회수

				board.add(dto); // 반환할 결과 목록에 게시물 추가
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생 페이징");
			e.printStackTrace();
		}

		// 목록 반환
		return board;
	}

	// 게시글 데이터를 받아 db에 추가 합니다.(파일 업로드 지원)
	public int insertWrite(MVBoardDTO dto) {
		int result = 0;
		try {
			// insert 쿼리문 작성
			String query = "INSERT INTO mvboard (" + " name,title,content, ofile, sfile, pass)" + " VALUES ( "
					+ " ?, ?, ?, ?, ?, ?)";

			psmt = con.prepareStatement(query); // 동적 쿼리
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	// 주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환함.
	public MVBoardDTO selectView(String idx) {
		MVBoardDTO dto = new MVBoardDTO();

		// 쿼리문 준비
		String query = "SELECT * " + " FROM mvboard WHERE idx=?";

		try {
			psmt = con.prepareStatement(query); // 동적 쿼리
			psmt.setString(1, idx); // 인파라미터를 일련번호로 설정
			rs = psmt.executeQuery(); // 쿼리 실행

			if (rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
			}

		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}

		return dto; // 결과 반환
	}

	// 지정한 게시물의 조회수를 1 증가시킵니다.
	public void updateVisitCount(String idx) {
		// 쿼리문 준비
		String query = "UPDATE mvboard SET " + "visitcount=visitcount+1 " + "WHERE idx=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx); // 인파라미터를 일련번호로 설정
			psmt.executeUpdate(); // 쿼리 실행
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생 14장");
			e.printStackTrace();
		}
	}

	public void downCountPlus(String idx) {
		// 쿼리문 준비
		String query = "UPDATE mvboard SET " + "downcount=downcount+1 " + "WHERE idx=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx); // 인파라미터를 일련번호로 설정
			psmt.executeUpdate(); // 쿼리 실행
		} catch (Exception e) {
			System.out.println("다운로드 숫자 증가 중 예외 발생 14장");
			e.printStackTrace();
		}
	}

	// 입력한 비밀번호가 지정한 일련번호의 게시물의 비밀번호와 일치하는지 확인
	public boolean confirmPassword(String pass, String idx) {
		boolean isCorr = true;

		// 쿼리문 준비
		try {
			String query = "SELECT COUNT(*) FROM mvboard WHERE pass=? AND idx=?";
			psmt = con.prepareStatement(query); // 동적 쿼리
			psmt.setString(1, pass); // 인파라미터를 일련번호로 설정
			psmt.setString(2, idx); // 인파라미터를 일련번호로 설정
			rs = psmt.executeQuery(); // 쿼리 실행
			rs.next();
			if(rs.getInt(1) == 0) {
				isCorr = false;
			}

		} catch (Exception e) {
			isCorr = false;
			System.out.println("게시물 비밀번호 검증 오류");
			e.printStackTrace();
		}

		return isCorr; // 결과 반환
	}
	
	public int deletePost(String idx) {
		int result = 0;
		try {
			String query = "DELETE FROM mvboard WHERE idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
}
