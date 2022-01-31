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

  <%
  	// 한글처리
  	request.setCharacterEncoding("UTF-8");
  %>
  <jsp:useBean id="bto" class="com.hj.board.BoardDTO"></jsp:useBean>
  <jsp:setProperty property="*" name="bto"/>
  
  <%
    // bdto 객체 안에 답글 쓴 사람의 IP 주소를 추가
    bto.setIp(request.getRemoteAddr());
  
    // BoardDAO 객체 생성
    BoardDAO bdao = new BoardDAO();
    // 답글쓰기 메서드 - reInsertBoard(dto);
    bdao.replyBoard(bto);
    
    // 페이지 이동
    response.sendRedirect("boardList.jsp");
  
  
  %>


</body>
</html>