<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 문의하기</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">

</head>
<body>
<div id="wrap">
<div id="top_img_contact">
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
<li><a href="map.jsp">찾아오는 길</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>문의하기</h1>


<form action="contactPro.jsp" id="join" method="post">
<fieldset>
<input type="hidden" name="to">
<table id="notice">
<tr><th class="tno" colspan="5">문의메일 작성</th></tr>
    
	<tr>
		<td colspan="2"> 보내는 사람 : </td>
		<td class="left" colspan="3"><input type="email" name="from"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="subject"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="50" name="content"></textarea>
		</td>
	</tr>
	 
</table>

</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="메일 발송" class="submit">
<input type="reset" value="취소하기" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../include/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>