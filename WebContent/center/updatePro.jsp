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
	 
	 // pageNum 정보저장
	 String pageNum = request.getParameter("pageNum");
	 
	%>
	<jsp:useBean id="bto" class="com.hj.board.BoardDTO"/>
	<jsp:setProperty property="*" name="bto"/>
	
	<%
	  System.out.println(" 수정 정보 : "+bto);
	
	 // DAO 객체 생성
	 BoardDAO bdao = new BoardDAO();
	 // 정보 수정 메서드
	 int result = bdao.updateBoard(bto); 
	
	 if(result == 1){
		 %>
		  <script type="text/javascript">
		     alert(" 게시글이 수정되었습니다. ");
		     location.href='boardList.jsp';
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
		     alert(" 게시글이 없습니다.");
		     history.back();
		  </script>
		 <%
	 }
	%>

</body>
</html>