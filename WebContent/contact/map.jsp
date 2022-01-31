<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YORIHAJA | 찾아오는 길</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">


</head>
<body>
<div id="wrap">
<div id="top_img_contact">
<div id="top_img_cover"></div>
<!-- 헤더들어가는 곳 -->
<div class="top"></div>
<jsp:include page="../include/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->

</div>
<div class="clear"></div>
<!-- 본문내용 -->
<article>
<h1>찾아오는 길</h1>

<div id="map" style="width:500px;height:400px;"></div>
<div class="clear"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=becf19ddbd081ff77ddd812b294e7dab"></script>
    <script>
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(35.15846270666615, 129.06205078007451),
            level: 3
        };
 
        var map = new kakao.maps.Map(container, options);
        
     	// 마커가 표시될 위치입니다 
        var markerPosition  = new kakao.maps.LatLng(35.15846270666615, 129.06205078007451); 

        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });

        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);
        
	</script>
	
<p> > 부산광역시 부산진구 부전동 동천로 109 삼한골든게이트</p>
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