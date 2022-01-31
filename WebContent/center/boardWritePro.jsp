<%@page import="com.hj.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>자유게시판처리 페이지</h1>
	<%
	    // 한글 처리
	    request.setCharacterEncoding("UTF-8");
	%>
	<jsp:useBean id="bto" class="com.hj.board.BoardDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="bto"/>	
	<%    
	    
	    // 사용자 IP정보 저장
	    bto.setIp(request.getRemoteAddr());

	    // BoardDAO객체 생성 - insertBoard()
	    BoardDAO bdao = new BoardDAO();
	    bdao.insertBoard(bto);	    
	    
	    // 글목록 페이지(boardList.jsp)이동 
	    response.sendRedirect("boardList.jsp");	    
		
	%>

</body>
</html>