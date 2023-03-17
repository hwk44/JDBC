<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="fileUpload.MyfileDAO"%>
<%@page import="fileUpload.MyfileDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String saveDirectory = application.getRealPath("/Uploads"); // 저장할 디렉토리
    int maxPostSize = 1024* 1000; // 파일 최대 크기(1MB)
    String encoding = "UTF-8";
    
    try {
    	
    	//1. MultipartRequest 객체 생성
    	MultipartRequest mr = new  MultipartRequest(request, saveDirectory,
    												maxPostSize, encoding); // 클래스 생성되면 파일이 업로드 된것임
    												
    	// 2. 새로운 파일명 생성
    	String fileName = mr.getFilesystemName("attachedFile");			// 파일 현재 이름
    	String ext = fileName.substring(fileName.lastIndexOf(".")); 	// 파일 확장자만 불러옴 
    	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    	String newFileName = now + ext; 								// 새로운 파일 이름 ("업로드일시.확장자")
    	
    	// 3. 파일명 변경
    	File oldFile = new File(saveDirectory + File.separator + fileName);
    	File newFile = new File(saveDirectory + File.separator + newFileName);
    	oldFile.renameTo(newFile);
    	
    	// 4. 다른 폼값 받기
    	String name = mr.getParameter("name");
    	String title = mr.getParameter("title");
    	String[] cateArray = mr.getParameterValues("cate");
    	StringBuffer cateBuf = new StringBuffer();
    	if( cateArray == null){
    		cateBuf.append("선택 없음");
    	}else {
    		for (String s : cateArray){
    			cateBuf.append(s + ", ");
    		}
    	}
    	
    	// 5. dTO 생성
    	MyfileDTO dto = new MyfileDTO();
    	dto.setName(name);
    	dto.setTitle(title);
    	dto.setCate(cateBuf.toString());
    	dto.setOfile(fileName);
    	dto.setSfile(newFileName);
    	
    	// 6. DAO를 통해 데이터베이스 반영
    	MyfileDAO dao = new MyfileDAO();
    	dao.insertFile(dto);
    	dao.close();
    	
    	// 7. 파일 목록 JSP로 리다이렉션
    	response.sendRedirect("FileList.jsp"); 
    	/* 클라이언트로 다시 돌아감 Redirect는 request를 가져오지(공유) 않음  */
    	
    }catch(Exception e){
    	e.printStackTrace();
    	request.setAttribute("errorMessage", "파일 업로드 오류");
    	request.getRequestDispatcher("FileUploadMain.jsp").forward(request, response);
    }
 %>