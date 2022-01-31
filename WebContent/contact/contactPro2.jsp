<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
 
String from = request.getParameter("from");
String to = request.getParameter("to");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
// 입력값 받음
 
SimpleEmail se = new SimpleEmail();
 
se.setHostName("smtp.gmail.com"); // 네이버 SMTP "smtp.gmail.com" smtp.mailplug.co.kr
 
se.setSmtpPort(465);
se.setAuthentication("id", "password"); // 아이디,패스워드

se.setSSLOnConnect(true); // SSL 접속 활성화

se.setStartTLSEnabled(true); // TLS 접속 활성화
// SMTP 서버에 접속하기 위한 정보들



se.setFrom(from,"테스터","UTF-8");

// 받는 사람

se.addTo("testchoe22@gmail.com","받는 사람","UTF-8");

 

// 이메일에 추가될 내용 설정

se.setSubject(subject); //제목

se.setMsg(content);

 
new Thread(new Runnable(){
	public void run(){
		try{
			se.send();	
		}catch(Exception e){}
		
	}
}).start();



 
out.println("<script>alert('메일이 발송되었습니다.');location.href='contact.jsp';</script>");
// 성공 시
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>