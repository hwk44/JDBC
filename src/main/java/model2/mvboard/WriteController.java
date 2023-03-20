package model2.mvboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import fileUpload.FileUtil;
import utils.JSFunction;
@WebServlet("/mvboard/wirte.do")
public class WriteController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		req.getRequestDispatcher("/14MVBoard/Write.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		// 1. 파일 업로드 처리
		// 업로드 디렉터리의 물리적 경로 확인
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		// 초기화 매개변수로 설정한 첨부 파일 최대 용량 확인
		ServletContext application = getServletContext();
		int maxPostSize = 1024*1024*1; 
		
		// 교재 내용 : getinitparameter로 불러옴 이건 web.xml 에 있어야 하므로 내가 파일 크기를 지정했음
		//int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		
		// 파일 업로드
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		if(mr == null) {
			// 업로드 실패

			JSFunction.alertLocation(resp,"첨부 파일이 제한 용량을 초과합니다.",
					"../mvboard/write.do");
			
			return;
		}
		// 2. 파일 업로드 외 처리
		// 폼값을 DTO에 저장
		MVBoardDTO dto = new MVBoardDTO();
		dto.setName(mr.getParameter("name"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		dto.setPass(mr.getParameter("pass"));
		
		// 원본 파일명과 저장된 파일 이름 설정
		String fileName = mr.getFilesystemName("ofile");
		if(fileName != null) {
			// 첨부 파일이 있을 경우 파일명 변경
			// 새로운 파일명 생성
			
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now + ext;
			
			// 파일명 변경
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			oldFile.renameTo(newFile);
			
			dto.setOfile(fileName);		// 원래 파일 이름
			dto.setSfile(newFileName);	// 서버에 저장된 파일 이름
		}
		
		// DAO를 통해 DB에 게시 내용 저장
		MVBoardDAO dao = new MVBoardDAO();
		int result = dao.insertWrite(dto);
		dao.close();
		
		// 성공 or 실패
		if(result == 1) { // 글쓰기 성공
			System.out.println("글작성 성공");
			resp.sendRedirect("../mvboard/list.do");
		}else {

			System.out.println("글작성 실패");
			resp.sendRedirect("../mvboard/write.do");
		}
	}

}
