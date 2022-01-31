<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 답글달기</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

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
<h1>답글쓰기 페이지</h1>

<%
  // 전달된 파라미터 데이터 저장(num, re_ref, re_lev, re_seq)
  int bno = Integer.parseInt(request.getParameter("bno"));
  int re_ref = Integer.parseInt(request.getParameter("re_ref"));
  int re_lev = Integer.parseInt(request.getParameter("re_lev"));
  int re_seq = Integer.parseInt(request.getParameter("re_seq"));
%>

<form action="reWritePro.jsp" method="post">
	<!-- 화면에 표현없이 단순히 정보(데이터)만 전달 -->
	<input type="hidden" name="bno" value="<%=bno%>">
	<input type="hidden" name="re_ref" value="<%=re_ref%>">
	<input type="hidden" name="re_lev" value="<%=re_lev%>">
	<input type="hidden" name="re_seq" value="<%=re_seq%>">
<table id="notice">
<tr><th class="tno" colspan="5">자유게시판 답글</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 비밀번호 : </td>
		<td class="left" colspan="3"><input type="password" name="pass"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="title" value="[답글]"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="22" name="content"></textarea>
		</td>
	</tr>
	 
</table>


<div id="table_button">
	<input type="submit" value="답글등록" class="btn">
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