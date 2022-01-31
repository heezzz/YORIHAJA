
<%@page import="comment.CommentDAO"%>
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
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="cdto" class="comment.CommentDTO" />
<jsp:setProperty name="cdto" property="*" />

	<% 
	 	// 사용자 IP정보 저장
    	cdto.setBno(Integer.parseInt(request.getParameter("bno")));
		cdto.setUid(request.getParameter("id"));
	
	
	    // BoardDAO객체 생성 - insertBoard()
	    CommentDAO cdao = new CommentDAO();
	    cdao.insertComment(cdto);	    
	    
	    // 글목록 페이지(mcontent.jsp)이동 
	    response.sendRedirect("mediaList.jsp");
		
	%>



</body>
</html>