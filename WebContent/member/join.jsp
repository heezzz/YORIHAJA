<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 회원가입</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>

<script type="text/javascript">
 
	//유효성 체크
	function checkJoin(){
		// 아이디 - 입력여부, 길이 5~10
		if(document.fr.id.value==""){
			alert("아이디를 입력하세요");
			document.fr.id.focus();
			return false;
		}
		if(!(5<=document.fr.id.value.length && 
				document.fr.id.value.length <= 10)){
			alert("아이디를 5자~10자 사이로 입력하세요.");
			document.fr.id.focus();
			return false;
		}
		
		// 비밀번호 - 입력여부, 값 동일여부
		if(document.fr.pass.value==""){
			alert("비밀번호를 입력하세요");
			document.fr.pass.focus();
			return false;
		}
		
		if(document.fr.pass2.value==""){
			alert("비밀번호 확인을 입력하세요");
			document.fr.pass2.focus();
			return false;
		}
		if(document.fr.pass.value!=document.fr.pass2.value){
			alert("비밀번호가 동일하지 않습니다.");
			document.fr.pass2.select();
			return false;
		}
		
		// 이름 입력여부
		if(document.fr.name.value==""){
			alert("이름을 입력하세요");
			document.fr.name.focus();
			return false;
		}
		
		// 이메일 입력여부
		if(document.fr.email.value==""){
			alert("이메일을 입력하세요");
			document.fr.email.focus();
			return false;
		}
	}
	
	function dupcheck(){
		//새창을 열어서 페이지를 오픈 후 -> 회원아이디정보를 가지고 중복체크
		//1. 아이디가 없으면 알림창과 진행x
		if(document.fr.id.value =="" || document.fr.id.value.length < 0){
			alert("아이디를 먼저 입력해주세요")
			document.fr.id.focus();
		}else{
			//2. 회원정보아이디를 가지고 있는 지 체크하려면 DB에 접근해야한다.
			//자바스크립트로 어떻게 DB에 접근할까? => 파라미터로 id값을 가져가서 jsp페이지에서 진행하면 된다.
			window.open("joinIdCheck.jsp?id="+document.fr.id.value,"","width=500, height=300");
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
<li><a href="login.jsp">로그인</a></li>
<li><a href="#">개인정보처리방침</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원가입</h1>
<form action="joinPro.jsp" id="join" name="fr" onsubmit="return checkJoin();">
<fieldset>
<legend>필수 입력</legend>
<label>아이디</label>
<input type="text" name="id" class="id" placeholder="5~10자리 입력">
<input type="button" value="중복확인" class="dup" onclick="dupcheck()"><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
<label>비밀번호 확인</label>
<input type="password" name="pass2"><br>
<label>이름</label>
<input type="text" name="name"><br>
<label>이메일</label>
<input type="email" name="email"><br>

</fieldset>

<fieldset>
<legend>선택 입력</legend>
<label>주소</label>
<div class="addr">
<input type="text" id="postcode" placeholder="우편번호" >
<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="addbtn"><br>
<label> </label>
<input type="text" name="address" id="address" placeholder="주소">
<input type="text" id="detailAddress" placeholder="상세주소">
<input type="hidden" id="extraAddress" placeholder="참고항목"><br>
</div>

<label>전화번호</label>
<input type="text" name="phone"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
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