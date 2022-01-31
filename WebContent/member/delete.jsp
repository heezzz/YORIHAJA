<%@page import="com.hj.member.MemberDTO"%>
<%@page import="com.hj.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 회원탈퇴</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<script type="text/javascript">
 	function check(){
 		if(document.fr.pass.value == ""){
 			alert("비밀번호를 입력하세요! ");
 			document.fr.pass.focus();
 			return false;
 		}
 	}
 
</script>

 
 
</head>
<body>
<!-- 로그인한사람만 볼 수 있게 -->
<%
    String id = (String)session.getAttribute("id");
  
    if(id == null){
    	response.sendRedirect("login.jsp");
    }
%>
 
<div id="wrap">
<div id="top_img_mypage">
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
<li><a href="modify.jsp">수정하기</a></li>
<li><a href="delete.jsp">회원 탈퇴하기</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원 탈퇴</h1>
<hr>
<%
  // 전달된 파라미터값 저장(id)

  // DAO 객체 생성
  MemberDAO bdao = new MemberDAO(); 
  
  // 기존의 글정보를 가져오기
  MemberDTO bdto = bdao.getMember(id);  

%>

<form action="deletePro.jsp" method="post" name="fr" onsubmit="return check();">
<div class="clear"></div>
<table id="mypage">    
	<tr>
		<td colspan="2"> 아이디 : </td>
		<td class="left" colspan="3"><input type="text" name="id" value="<%=bdto.getId()%>" readonly="readonly"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 비밀번호 : </td>
		<td class="left" colspan="3"><input type="password" name="pass"> </td>
	</tr>
	 
</table>
<div id="table_button">
<input type="submit" value="탈퇴하기" class="btn">
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