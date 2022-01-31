<%@page import="java.util.Date"%>
<%@page import="com.hj.media.MediaDTO"%>
<%@page import="com.hj.media.MediaDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	  // 한글 처리
	   request.setCharacterEncoding("UTF-8");

	  String realPath = "C:\\fupload";
	  
	  System.out.println(realPath);
	
	  // 업로드 파일크기 지정
	  int maxSize = 10 * 1024 * 1024; // 10MB
	  
	  try{
	  	  MultipartRequest multi = new MultipartRequest(
				  						request,
				  						realPath,
				  						maxSize,
				  						"UTF-8",
				  						new DefaultFileRenamePolicy()
				  						);
	  
	  	  System.out.println("MultipartRequest 객체 생성완료 - 파일업로드 완료!");	  	  
	  
		  String name = multi.getParameter("name");
		  String pass = multi.getParameter("pass");
		  String title = multi.getParameter("title");
		  String content = multi.getParameter("content");
		  String oFileName = multi.getOriginalFileName("file");
		  String fileName = multi.getFilesystemName("file");		  
		  
		  MediaDTO mdto = new MediaDTO();	
		  // 디비에 저장 -> 파일이름 정보를 디비에 저장
		  mdto.setName(name);
		  mdto.setPass(pass);
		  mdto.setTitle(title);
		  mdto.setContent(content);
		  mdto.setDate(new Date());
		  mdto.setIp(request.getRemoteAddr());		  
		  
		  if(fileName!=null){ //파일을 올릴경우
			  mdto.setFile(fileName);
		  }else{ //파일 올리지 않을 경우
		      mdto.setFile("");
		  } 
		  
		  System.out.println("mdto:"+mdto);
		  
		  // DB저장
		  MediaDAO mdao = new MediaDAO();	  
		  mdao.insertMedia(mdto);
	   
	   }catch(Exception e){
			e.printStackTrace();
	   }
	  
		// 리스트로 페이지 이동
		response.sendRedirect("mediaList.jsp");
	  
	
	
	%>

</body>
</html>