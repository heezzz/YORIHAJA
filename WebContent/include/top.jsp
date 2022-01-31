<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("id");
%>
<!-- 헤더파일들어가는 곳 -->
<header>

<div id="login">
	<%if(id == null){
		%>
		<div id="login"><a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a></div>
		<%
	}else if(id != null){
		%>
		<div id="login"><%=id %>님 환영합니다 | <a href="../member/logout.jsp">로그아웃</a></div>
	<%
	}
	%>
</div>
<div class="clear"></div>

<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../index.jsp"><img src="../images/logo2.png" width="262" height="65" alt="yorihajalogo"></a></div>
<!-- 로고들어가는 곳 -->

<nav id="top_menu">
<ul>
	<li><a href="../index.jsp">HOME</a></li>
	<li><a href="../center/boardList.jsp">자유게시판</a></li>
	<li><a href="../referenceroom/mediaList.jsp">레시피 자료실</a></li>
	<li><a href="../member/mypage.jsp">마이페이지</a></li>
	<li><a href="../contact/contact.jsp">문의하기</a></li>
</ul>
</nav>
</header>
<!-- 헤더파일들어가는 곳 -->