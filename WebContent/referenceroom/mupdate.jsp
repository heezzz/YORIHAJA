<%@page import="com.hj.media.MediaDTO"%>
<%@page import="com.hj.media.MediaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%

  request.setCharacterEncoding( "utf-8" );
  // 전달된 파라미터값 저장(bno,pageNum)
  int bno = Integer.parseInt(request.getParameter("bno"));
  String pageNum = request.getParameter("pageNum");

  // DAO 객체 생성
  MediaDAO mdao = new MediaDAO();  
  // 기존의 글정보를 가져오기
  MediaDTO mdto = new MediaDTO();
  mdto = mdao.updateMedia(mdto);
  
  String name = mdto.getName();
  String title = mdto.getTitle();
  String content = mdto.getContent();
  String file = mdto.getFile();
  
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 자료수정</title>
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
<h1></h1>

<%
  // 전달된 파라미터값 저장(bno,pageNum)
  bno = Integer.parseInt(request.getParameter("bno"));
  pageNum = request.getParameter("pageNum");

  // DAO 객체 생성
  mdao = new MediaDAO();
  
  // 조회수 1증가  - updateReadcount();
  mdao.updateReadcount(bno);  
  
  // 기존의 글정보를 가져오기
  mdto = mdao.getBoard(bno);  

%>

<form action="mupdatePro.jsp?pageNum=<%=pageNum %>" method="post" enctype="multipart/form-data" name="fr">
<input type="hidden" name="bno" value="<%=mdto.getBno()%>">
<input type="hidden" name="oldfile" value="<%=mdto.getFile()%>">
<table id="notice">
<tr><th class="tno" colspan="5">자료실 수정</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name" value="<%=mdto.getName()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 비밀번호 : </td>
		<td class="left" colspan="3"><input type="password" name="pass"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="title" value="<%=mdto.getTitle()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="30" name="content"><%=mdto.getContent() %></textarea>
		</td>
	</tr>

    <tr>
          <td colspan="2">첨부파일 : </td>
          <td class="left" colspan="3"><input type="file" name="newfile">
          <%
      		if(mdto.getFile()!=null){// 업로드된 파일 존재하면 
      	  %>
      			기존 파일명 : <%=mdto.getFile()%>
    	  <%
      		}
    	  %>
          </td>        	
		
	 </tr>
</table>

<div id="table_search">
	<input type="submit" value="수정" class="btn">
	<input type="button" value="목록" class="btn" onclick="location.href='mediaList.jsp?pageNum=<%=pageNum %>'" >
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