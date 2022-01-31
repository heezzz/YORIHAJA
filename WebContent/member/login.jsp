<%@page import="com.hj.member.MemberDTO"%>
<%@page import="com.hj.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 로그인</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<script type="text/javascript">
 
	//유효성 체크
	function checklogin(){
		if(document.fr.id.value==""){
			alert("아이디를 입력하세요");
			document.fr.id.focus();
			return false;
		}
		
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
<div id="top_img_member">
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
<li><a href="join.jsp">회원가입</a></li>
<li><a href="#">개인정보처리방침</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>로그인</h1>

<form action="loginPro.jsp" id="join" method="post" name="fr" onsubmit="return checklogin();">
<fieldset>
<label>아이디</label>
<input type="text" name="id"><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="로그인" class="submit">
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