<%@page import="java.util.Date"%>
<%@page import="com.hj.member.MemberDAO"%>
<%@page import="com.hj.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/member/joinPro.jsp</h1>
	<%
    // 한글처리 
    request.setCharacterEncoding("UTF-8"); 
  	%>
  	
  	<!-- 자바빈 객체 생성 -->
	<jsp:useBean id="mto" class="com.hj.member.MemberDTO"></jsp:useBean>
	<!-- 전달되는 파라미터값 저장 -->
	<jsp:setProperty property="*" name="mto" />
	
	<%
		System.out.println(mto); 
	   // 회원 가입일자 생성
	   // 1) 시간정보를 직접 생성
		mto.setReg_date(new Date()); 
		System.out.println(mto);
		
	
		// DAO 파일을 사용한 디비 작업 
		MemberDAO mdao = new MemberDAO();		
		mdao.insertMember(mto);	
		
	%>
 
 
	<script type="text/javascript">
	   alert("회원 가입 완료!");
	   location.href="login.jsp";	  
	</script>

</body>
</html>