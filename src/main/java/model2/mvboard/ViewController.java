package model2.mvboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/mvboard/view.do")
public class ViewController extends HttpServlet {

	
	private static final long serialVersionUID = 1L;
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException{
		// 게시물 불러오기
		MVBoardDAO dao = new MVBoardDAO();
		String idx = req.getParameter("idx");
		dao.updateVisitCount(idx); // 조회수 1 증가
		MVBoardDTO dto = dao.selectView(idx); // 조회수를 1 증가하고 그 정보를 dto로 담아옴
		dao.close();
		
		// 줄바꿈 처리
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		
		// 게시물 (dto) 저장 후 뷰로 포워드
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/14MVBoard/View.jsp").forward(req, resp);
	}
	
	
}
