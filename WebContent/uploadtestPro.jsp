<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	  // 한글 처리
	   request.setCharacterEncoding("UTF-8");
	
	  // 파일 업로드
	  // 파일이 저장될 가상경로 - upload라는 폴더가 있어야함
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
	  	  
	  	  
	  	String oFileName = multi.getOriginalFileName("file");
		String fileName = multi.getFilesystemName("file");
		
		System.out.println("ofilename : "+oFileName);
    	System.out.println("filename: "+fileName);
		  
	  }catch(Exception e){
		  e.printStackTrace();
	  }
	  	  
	  	  
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>uploadtestPro.jsp</h1>



</body>
</html>