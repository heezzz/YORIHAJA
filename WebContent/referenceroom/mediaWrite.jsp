<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 자료실 작성</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

</head>
<body>
<div id="wrap">
<div id="top_img_media">
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
<li><a href="mediaWrite.jsp">글쓰기</a></li>
<li><a href="mediaList.jsp">자료실 목록</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>자료실 글쓰기</h1>

<form action="mediaWritePro.jsp" method="post" enctype="multipart/form-data">
<table id="notice">
<tr><th class="tno" colspan="5">자료실 작성</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name" required="required"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 비밀번호 : </td>
		<td class="left" colspan="3"><input type="password" name="pass" required="required"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="title" required="required"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="30" name="content" required="required"></textarea>
		</td>
	</tr>
	
	<tr>
		<td colspan="2"> 첨부파일 : </td>
		<td class="left" colspan="3"><input type="file" name="file"> </td>
	</tr>
	 
</table>


<div id="table_search">
	<input type="submit" value="글등록" class="btn">
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