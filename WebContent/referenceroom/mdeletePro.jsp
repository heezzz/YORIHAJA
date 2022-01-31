
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

   	String pageNum = request.getParameter("pageNum");
    int bno = Integer.parseInt(request.getParameter("bno"));
    String pass = request.getParameter("pass");
    
    // DAO 객체 생성 - deleteBoard(num,pass)
    MediaDAO mdao = new MediaDAO();
    int result =  mdao.deleteMedia(bno,pass);
      
    // 처리결과에 따른 페이지이동  
   if(result == 1){ // 수정완료
		 %>
		  <script type="text/javascript">
		     alert(" 게시글이 삭제되었습니다.");
		     location.href='mediaList.jsp';
		  </script>		 
		 <%		 
	 }else if(result == 0){
		 %>
		  <script type="text/javascript">
		     alert(" 비밀번호가 올바르지 않습니다. ");
		     history.back();
		  </script>
		 <%
	 }else{
		 %>
		  <script type="text/javascript">
		     alert(" 게시글이 존재하지 않습니다. ");
		     history.back();
		  </script>
		 <%
	 }
	%>

</body>
</html>