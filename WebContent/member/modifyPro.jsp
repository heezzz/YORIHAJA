<%@page import="java.util.Date"%>
<%@page import="com.hj.member.MemberDAO"%>
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
	// 한글처리 (form태그 정보를 post방식 전달)
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="mto" class="com.hj.member.MemberDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="mto"/>
	
<%
		// MemberDAO 객체를 생성 - updateMember(mto);
		MemberDAO mdao = new MemberDAO();
		int result = mdao.updateMember(mto);
		
		System.out.println(" 수정 처리결과 : " + result);
		// 수정 처리 결과(정수데이터)에 따른 페이지 이동
		
		if(result == -1){
			%>
			<script type="text/javascript">
				alert('회원정보가 없습니다.');
				history.back();
			</script>			
			<%
		}else if(result == 0){
			%>
			<script type="text/javascript">
				alert('비밀번호가 올바르지 않습니다.');
				history.back();
			</script>			
			<%
			
		}else{ //result == 1
			%>
			<script type="text/javascript">
				alert('회원정보가 수정되었습니다.');
				location.href="mypage.jsp";
			</script>			
			<%
		}	
	
	%>


</body>
</html>