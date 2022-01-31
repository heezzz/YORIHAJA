<%@page import="java.util.List"%>
<%@page import="com.hj.board.BoardDTO"%>
<%@page import="com.hj.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 자유게시판</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

</head>
<body>
<div id="wrap">
<div id="top_img_board">
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
<%if(session.getAttribute("id")!=null){ %>
<li><a href="boardWrite.jsp">글쓰기</a></li>
<%} %>
<li><a href="boardList.jsp">자유게시판 목록</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<%
  // BoardDAO 객체 생성
  BoardDAO bdao = new BoardDAO();
  // 게시판 DB에 있는 글 개수를 확인
  int cnt = bdao.getBoardCount();
  
  // 페이징 처리
  
  // 한 페이지에 출력될 글 개수
  int pageSize = 5;
  
  // 현 페이지 정보 설정
  String pageNum = request.getParameter("pageNum");
  if(pageNum == null){
	  pageNum = "1";
  }  
  
  // 첫행번호를 계산
  int currentPage = Integer.parseInt(pageNum);
  int startRow = (currentPage-1)*pageSize+1;
  
%>


<!-- 게시판 -->
<article>
<h1>자유게시판</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">제목</th>
    <th class="twrite" >작성자</th>
    <th class="tdate">날짜</th>
    <th class="tread">조회수</th></tr>
    
<% if(cnt != 0){ 
    // DB에 있는 게시판의 글정보 모두를 가져오기

    List boardList = bdao.getBoardList(startRow,pageSize);
    for(int i=0;i<boardList.size();i++){
    	 BoardDTO bto = (BoardDTO) boardList.get(i);    	
%>

<tr>
	<td><%=bto.getBno() %></td>
	<td class="left">
	<%if(bto.getRe_lev()>0){ %>
		<img src="level.gif" height="10" width="<%=bto.getRe_lev()*10%>">
		<img src="re.gif">
	 <%} %>
		<a href="bcontent.jsp?bno=<%=bto.getBno()%>&pageNum=<%=pageNum%>"><%=bto.getTitle() %></a>
	</td>
    <td><%=bto.getName() %></td>
    <td><%=bto.getDate() %></td>
    <td><%=bto.getReadcount() %></td>
    </tr>
<% 
    }// for
  }else{%>
<tr>
  <td colspan="5">
      게시판에 글이 없습니다.<br>
      새 글을 작성하세요<br>
      <a href="boardWrite.jsp"> 글 쓰러가기 </a>
  </td> 
</tr>
<%} %>
  
</table>
<div class="clear"></div>
<div id="page_control">
<% if(cnt != 0){ 
	     ////////////////////////////////////////////////////////////
	     // 페이징 처리
	     // 전체 페이지수 계산
	     int pageCount = cnt / pageSize + (cnt%pageSize==0? 0:1);
	     
	     // 한 페이지에 보여줄 페이지블럭
	     int pageBlock = 2;
	     
	     // 한 페이지에 보여줄 페이지 블럭 시작번호 계산
	     int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
	     
	     // 한 페이지에 보여줄 페이지 블럭 끝번호 계산
	     int endPage = startPage + pageBlock-1;
	     if(endPage > pageCount){
	    	 endPage = pageCount;
	     }
	  
	  %>
	    <% if(startPage>pageBlock){ %>
			<a href="boardList.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
		<% } %>
		
		<% for(int i=startPage;i<=endPage;i++){ %>
			<a href="boardList.jsp?pageNum=<%=i%>"><%=i %></a>
		<% }%>
		
		<% if(endPage < pageCount){%>
			<a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>">이후</a>
		<% }%>
		
	  <% } %>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../include/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>