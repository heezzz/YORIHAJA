<%@page import="com.hj.member.MemberDTO"%>
<%@page import="com.hj.member.MemberDAO"%>
<%@page import="com.hj.board.BoardDTO"%>
<%@page import="com.hj.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 게시판 본문</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">

</head>
<body>
<div id="wrap">
<div id="top_img_board">
<div id="top_img_cover"></div>
<!-- 헤더들어가는 곳 -->
<div class="top"></div>
<jsp:include page="../include/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->

</div>
<div class="clear"></div>

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<%if(session.getAttribute("id")!=null){ %>
<li><a href="boardWrite.jsp">글쓰기</a></li>
<%} %>
<li><a href="boardList.jsp">자유게시판 목록</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1></h1>

<%
  // 전달된 파라미터값 저장(bno,pageNum)
  int bno = Integer.parseInt(request.getParameter("bno"));
  String pageNum = request.getParameter("pageNum");

  // DAO 객체 생성
  BoardDAO bdao = new BoardDAO();
  
  // 조회수 1증가  - updateReadcount();
  bdao.updateReadcount(bno);  
  
  // 기존의 글정보를 가져오기
  BoardDTO bto = bdao.getBoard(bno);


%>
<form>
<input type="hidden" value="">
<table id="notice">
<tr><th class="tno" colspan="5">게시글</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name" value="<%=bto.getName()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="title" value="<%=bto.getTitle()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="40" name="content"><%=bto.getContent() %></textarea>
		</td>
	</tr>
	 
</table>

<div id="table_button">
<%if(session.getAttribute("id")!=null){ %>
	<input type="button" value="수정" class="btn" onclick="location.href='update.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'">
	<%if(bto.getRe_seq()==0){%>
	<input type="button" value="삭제" class="btn" onclick="location.href='delete.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'">
	<%}else{ %>
	<input type="button" value="삭제" class="btn" onclick="location.href='redelete.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>&re_ref=<%=bto.getRe_ref()%>&re_lev=<%=bto.getRe_lev()%>&re_seq=<%=bto.getRe_seq()%>'">
	<%} %>
	<input type="button" value="답글" class="btn" onclick="location.href='reWrite.jsp?bno=<%=bno%>&re_ref=<%=bto.getRe_ref()%>&re_lev=<%=bto.getRe_lev()%>&re_seq=<%=bto.getRe_seq()%>';">
<%} %>
	<input type="button" value="목록" class="btn" onclick=" location.href='boardList.jsp?pageNum=<%=pageNum %>'" >
</div>
</form>

<div class="clear"></div>


</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
 <jsp:include page="../include/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>