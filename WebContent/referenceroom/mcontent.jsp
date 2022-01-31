<%@page import="java.util.List"%>
<%@page import="com.hj.media.MediaDTO"%>
<%@page import="com.hj.media.MediaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 자료본문</title>
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
<%
String id = (String)session.getAttribute("id");
if(id!=null && id.equals("admin")){ %>
<li><a href="mediaWrite.jsp">글쓰기</a></li>
<%}%>
<li><a href="mediaList.jsp">자료실 목록</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1></h1>

<%
  // 전달된 파라미터값 저장(bno,pageNum)
  int bno = Integer.parseInt(request.getParameter("bno"));
  String pageNum = request.getParameter("pageNum");

  // DAO 객체 생성
  MediaDAO mdao = new MediaDAO();
  
  // 조회수 1증가  - updateReadcount();
  mdao.updateReadcount(bno);  
  
  // 기존의 글정보를 가져오기
  MediaDTO mdto = mdao.getBoard(bno);
 

%>


<table id="notice">
<tr><th class="tno" colspan="5">자료실</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name" value="<%=mdto.getName()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="title" value="<%=mdto.getTitle()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="40" name="content"><%=mdto.getContent() %></textarea>
		</td>
	</tr>
	<%
      if(mdto.getFile()!=null){  // 업로드된 파일 존재하면 
    %>
        <tr>
          <td colspan="2">첨부파일 : </td>
          <td class="left" colspan="2"><a href="download.jsp?fileName=<%=mdto.getFile()%>"><%=mdto.getFile()%></a>
          </td>
        </tr>
    <%
      }
    %>
	 
</table>

<div id="table_search">
<%

if(id!=null && id.equals("admin")){ %>
	<input type="button" value="수정" class="btn" onclick="location.href='mupdate.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'">
	<input type="button" value="삭제" class="btn" onclick="location.href='mdelete.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'">
<%} %>
	<input type="button" value="목록" class="btn" onclick="location.href='mediaList.jsp?pageNum=<%=pageNum %>'" >
</div>



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