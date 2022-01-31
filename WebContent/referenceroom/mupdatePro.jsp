<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.hj.media.MediaDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.hj.media.MediaDAO"%>
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
	 // 한글처리
	 request.setCharacterEncoding("UTF-8");
	 
	 // pageNum 정보저장
	 String pageNum = request.getParameter("pageNum");
	 
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
		  
		 int bno = Integer.parseInt(multi.getParameter("bno"));
		 String name = multi.getParameter("name");
		 String pass = multi.getParameter("pass");
		 String title = multi.getParameter("title");
		 String content = multi.getParameter("content");
		 String oldfileName = multi.getParameter("oldfile");
		 File newFile = multi.getFile( "file" );

		 System.out.println(oldfileName);
			  
		 MediaDTO mdto = new MediaDTO();	
		 // 디비에 저장 -> 파일이름 정보를 디비에 저장
		 mdto.setBno(bno);
		 mdto.setName(name);
		 mdto.setPass(pass);
		 mdto.setTitle(title);
		 mdto.setContent(content);
		 mdto.setFile(oldfileName);
		 
		 Enumeration<String> fileNames = multi.getFileNames();
		 if(fileNames.hasMoreElements()){
			 String fileName = fileNames.nextElement();
			 String updateFile = multi.getFilesystemName(fileName);
			 
			 if(updateFile==null){
				 mdto.setFile(oldfileName);
			 }else{
				 mdto.setFile(updateFile);
			 }
		 }

			  
		 // DAO 객체 생성
		 MediaDAO mdao = new MediaDAO();				 
		 int flag = mdao.updateMediaF(mdto); 
				
		 if(flag == 1){
		 %>
			<script type="text/javascript">
				alert(" 게시글이 수정되었습니다. ");
				location.href='mcontent.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>';
			</script>		 
		 <%		 
		 }else if(flag == 0){
		 %>
			<script type="text/javascript">
				alert(" 비밀번호가 올바르지 않습니다. ");
				history.back();
			</script>
		 <%
		 }else{
		 %>
			<script type="text/javascript">
				alert(" 게시글이 없습니다.");
				history.back();
			</script>
		 <%
		 }
	}catch(Exception e){
		e.printStackTrace();
	}


%>

</body>
</html>