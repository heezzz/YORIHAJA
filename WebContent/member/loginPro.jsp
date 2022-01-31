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
    request.setCharacterEncoding("UTF-8");
  	%>
  	<jsp:useBean id="mto" class="com.hj.member.MemberDTO"></jsp:useBean>
    <jsp:setProperty property="*" name="mto"/>
    
  	<%
    // DB연결에 해당하는 처리동작을 수행하는 객체를 생성
    MemberDAO mdao = new MemberDAO();  
    int result = mdao.loginCheck(mto.getId(), mto.getPass());
    
	if(result == -1){
	%>
		<script type="text/javascript">
		var value = confirm("아이디가 없습니다. 회원가입 하시겠습니까?");
		if(value){
		   location.href='join.jsp';
		}else{
		    history.back();
		}		      
		</script>
	<%
	}else if(result == 0){
		%>
		   <script type="text/javascript">
		       alert('비밀번호가 올바르지 않습니다.');
		       history.back();		   
		   </script>
		<%		
	}else{ // result == 1
	   // 로그인정보를 세션 객체에 저장
	   session.setAttribute("id", mto.getId());
	   response.sendRedirect("../main/main.jsp");
		
	}
 
  %>
  	
</body>
</html>