<%@page import="com.hj.board.BoardDTO"%>
<%@page import="com.hj.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 게시판 수정</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<script type="text/javascript">
 
	//유효성 체크
	function checkupdate(){
		if(document.fr.pass.value==""){
			alert("비밀번호를 입력하세요");
			document.fr.pass.focus();
			return false;
		}
	}
</script>
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
  
  // 기존의 글정보를 가져오기
  BoardDTO bto = bdao.getBoard(bno);  

%>

<form action="updatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" onsubmit="return checkupdate();">
<input type="hidden" name="bno" value="<%=bto.getBno()%>">
<table id="notice">
<tr><th class="tno" colspan="5">게시글 수정</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name" value="<%=bto.getName()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 비밀번호 : </td>
		<td class="left" colspan="3"><input type="password" name="pass"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="title" value="<%=bto.getTitle()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="30" name="content"><%=bto.getContent() %></textarea>
		</td>
	</tr>
	 
</table>

<div id="table_button">
	<input type="submit" value="수정" class="btn">
	<input type="button" value="목록" class="btn" onclick="location.href='boardList.jsp?pageNum=<%=pageNum %>'" >
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