<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 답글 삭제</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<script type="text/javascript">
 
	//유효성 체크
	function checkdelete(){
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
<li><a href="boardWrite.jsp">글쓰기</a></li>
<li><a href="boardList.jsp">자유게시판 목록</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>답글 삭제 페이지</h1>

<form action="redeletePro.jsp?pageNum=<%=request.getParameter("pageNum") %>" method="post" name="fr" onsubmit="return checkdelete();">
<input type="hidden" name="bno" value="<%=request.getParameter("bno") %>" >
<input type="hidden" name="re_seq" value="<%=request.getParameter("re_seq") %>" >  

<table id="notice">
<tr><th class="tno" colspan="5">답글 삭제</th></tr>
    
	<tr>
		<td colspan="2"> 답글 비밀번호 : </td>
		<td class="left" colspan="3"><input type="password" name="pass"> </td>
	</tr>
	 
</table>

<div id="table_button">
	<input type="submit" value="삭제하기" class="btn">
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