<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device, initial-scale=1" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/css/bootstrap.js"></script>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<style>
	* {
		padding:0; list-style-type:none; box-sizing:border-box; 
		font-family: Noto Sans KR,sans-serif!important;
	}	
	#all{
		margin:0 auto; background-color:white;	
	}
	.all_wrapper{
		margin-top:70px;
		width:1100px;
		background-color:white;
		margin:0 auto;
	}
	img{ height:110px; width:110px;}

    .form-control{
    	margin:0 auto;
    	background-color:white;
    }
    html {
	    color: white;
	    font-weight: 100;
	    font-size: 1em;
	    line-height: 1.375;   
	}
	.btn1{
	    color: #434343;
	    padding: 10px 14px;
	    border-radius: 16px;
	    border: 1px solid gold;
	    margin: 5px 6px 10px 0;
	    display: inline-block;
	    cursor: pointer;
	    font-size: 13px;
	    font-weight: 400;
	    line-height: 12px;
	    text-align: center;
	    width:90px;
	}
	 .list-group-item {
	 	width:1000px;
	 }
	.listPanel{
		color: #222;
	    font-weight: 100;
	    font-size: 1em;
	    line-height: 1.375;
	}
	.review_rate {
	    display: flex;
	    font-size: 12px;
	    font-weight: 500;
	    text-align: left;
	    color: white;
	}
	#map{
		width: 100%;
		height: 500px;
		border-bottom-left-radius: 20px;
		border-bottom-right-radius: 20px;
	}
	
	<!-- -->
	.imgBox{
		float:left;
		padding: 15px;
		height: 150px;
		position: absolute;
		top: 20px;
	}
	.offerBox{
		float:right;
		width: 310px;
		padding: 3px;
	}
	.offerTitle{
		font-size: 1.1em;
	}
	.card-body{
		white-space: nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}
	#btnBox{
		margin-top: 10px;
		margin-bottom: -10px;
		width: 100%;
		height: 50px;
		white-space: nowrap;
		display: inline-block;
		vertical-align: top;
	}
</style>
<script>
$(function(){
	//지도 토글
    $(document).on("click", "#mapBtn", function(){
			$("#map").toggle();
	});
	
  	//검색창	
    $(document).on("keyup", "#locFilter", function(){
    	var value = $(this).val().toLowerCase();
    	$(".loc").filter(function(){
    		$(this).parent().parent().parent().toggle($(this).text().toLowerCase().indexOf(value)>-1);	    		
    	});
    });
	
	
	//필터
	$(document).on("click", "#btnBox>button", function(){
	    var activity_type = $(this).text();
	    console.log(activity_type);
	    var url = "/dbmon/careAct";
		var params = "activity_type="+activity_type;
		console.log("파람="+params);
		$.ajax({
			url: url,
			data: params,
			type: 'GET',
			success: function(result){
				console.log("갯수="+result.length);
				$("#Tcnt").text(result.length);
				var $result = $(result);
				var tag = "";
					
				$result.each(function(idx, vo){
					tag += '<div class="col-sm-6" style="padding: 20px;">';
					tag += '<div class="card">';
					tag += '<div class="card-body">';
					tag += '<div class="imgBox"><img src=';	
					tag +='"img/ch1.PNG" class="rounded-circle"></div>';
					tag += '<div class="badge badge-warning badge-pill ml-1" style="position: absolute; top: 170px; left: 53px;"><span>';
					tag += vo.tcnt+'명 지원</div>';
					tag += '<div class="offerBox" style="width: 310px";>';
					tag += '<span class="card-title" class="offerTitle" style="line-height: 2em;"><b>'+vo.title+'</b></span>';
					tag += '<p class="card-text" style="line-height: 1.8em;"><span style="color: gray;">no. '+vo.job_board_no +' | '+ vo.userid+'</span>';
					tag += '<br/><span><b>신생아 1명, 유아 1명</b> | '+vo.writedate+'</span>';
					tag += '<br/><span>'+vo.care_addr+'</span>';
					tag += '<br/><span><b>'+vo.start_date+'</b> 시작</span>';
					tag += '<br/><span style="color: orange;">희망시급 '+vo.wish_wage+'원';
					if(vo.consultation=="Y"){
						tag += ' | <b>협의가능</b></span></p>';
					}else{
						tag += '</span></p>';
					}
					tag += '</div></div>';
					tag += '<div class="card-footer btn" onclick="location.href=parentView?no='+vo.job_board_no+'">자세히 보기</div>';	
					tag += '</div>';
					tag += '</div>';
					tag += '</div>';
				});
				tag += "";
				$("#cardBox").html(tag);	
			}, error: function(){
				console.log("리스트 받기 에러");
			}
		});		
	});//ajax
	    
	//select
	$(document).on("change", "#selectType", function(){
		var care_type = $(this).val();
		console.log("케어타입="+care_type);
		var url2 = "/dbmon/careSelect";
		var params2 = "care_type="+care_type;
		console.log("파라미터="+params2);
		$.ajax({
			url:url2,
			data:params2,
			type:'GET',
			success:function(result){
				$("#Tcnt").text(result.length);

 				var $result = $(result);
				var tag = "";
					
				$result.each(function(idx, vo){
					tag += '<div class="col-sm-6" style="padding: 20px;">';
					tag += '<div class="card">';
					tag += '<div class="card-body">';
					tag += '<div class="imgBox"><img src=';	
					tag +='"img/ch1.PNG" class="rounded-circle"></div>';
					tag += '<div class="badge badge-warning badge-pill ml-1" style="position: absolute; top: 170px; left: 53px;">';
					tag += vo.tcnt+'명 지원</div>';
					tag += '<div class="offerBox" style="width: 310px";>';
					tag += '<span class="card-title" class="offerTitle" style="line-height: 2em;"><b>'+vo.title+'</b></span>';
					tag += '<p class="card-text" style="line-height: 1.8em;"><span style="color: gray;">no. '+vo.job_board_no +' | '+ vo.userid+'</span>';
					tag += '<br/><span><b>신생아 1명, 유아 1명</b> | '+vo.writedate+'</span>';
					tag += '<br/><span>'+vo.care_addr+'</span>';
					tag += '<br/><span><b>'+vo.start_date+'</b> 시작</span>';
					tag += '<br/><span style="color: orange;">희망시급 '+vo.wish_wage+'원';
					if(vo.consultation=="Y"){
						tag += ' | <b>협의가능</b></span></p>';
					}else{
						tag += '</span></p>';
					}
						tag += '</div></div>';
						tag += '<div class="card-footer btn" onclick="location.href=parentView?no='+vo.job_board_no+'">자세히 보기</div>';	
						tag += '</div>';
						tag += '</div>';
						tag += '</div>';
					});
					tag += "";
					$("#cardBox").html(tag);	
			}, error: function(){
				console.log("리스트 받기 에러");
			}
		});		
	});//ajax
	
	
	//====================정렬 필터=========================
	
	$(document).on("change", "#selectArray", function(){
		var order = $(this).val();
		console.log("정렬="+order);
				
		var url = "/dbmon/filterArray";
		var params = "order="+order;
			
		console.log("파라미터="+params);
		$.ajax({
			url: url,
			data: params,
			type: 'GET',
			success: function(result){
					
				var $result = $(result);
				var tag = "";
											
				$result.each(function(idx, vo){
					tag += '<div class="col-sm-6" style="padding: 20px;">';
					tag += '<div class="card">';
					tag += '<div class="card-body">';
					tag += '<div class="imgBox"><img src=';	
					tag +='"img/ch1.PNG" class="rounded-circle"></div>';
					tag += '<div class="badge badge-warning badge-pill ml-1" style="position: absolute; top: 170px; left: 53px;">';
					tag += vo.tcnt+'명 지원</div>';
					tag += '<div class="offerBox" style="width: 310px";>';
					tag += '<span class="card-title" class="offerTitle" style="line-height: 2em;"><b>'+vo.title+'</b></span>';
					tag += '<p class="card-text" style="line-height: 1.8em;"><span style="color: gray;">no. '+vo.job_board_no +' | '+ vo.userid+'</span>';
					tag += '<br/><span><b>신생아 1명, 유아 1명</b> | '+vo.writedate+'</span>';
					tag += '<br/><span>'+vo.care_addr+'</span>';
					tag += '<br/><span><b>'+vo.start_date+'</b> 시작</span>';
					tag += '<br/><span style="color: orange;">희망시급 '+vo.wish_wage+'원';
					if(vo.consultation=="Y"){
						tag += ' | <b>협의가능</b></span></p>';
					}else{
						tag += '</span></p>';
					}
						tag += '</div></div>';
						tag += '<div class="card-footer btn" onclick="location.href=parentView?no='+vo.job_board_no+'">자세히 보기</div>';	
						tag += '</div>';
						tag += '</div>';
						tag += '</div>';
					});
					tag += "";
					
					$("#cardBox").html(tag);
					
				},
				error:function(error){
					console.log("리스트 받기 에러-->"+ error.responseText);
				}
			});
	 	});//ajax 
});





</script>






<body>
<!-- -------------------상단메뉴------------- -->
<div id="top">
<%@include file="/WEB-INF/views/top.jsp"%>
<hr/><br/>
</div>
<!-- ------------------------------------------ -->
<div class="all_wrapper" >
<div>
	<button type="button" id="mapBtn" class="btn btn-warning btn-lg btn-block" style="width: 100%; margin-bottom: -20px;">가까운 일자리 찾기</button><br/>
	<div id="map">
	</div>
</div>
<div class="listPanel" style="display: block; vertical-align: inherit; background-color:white; "> 
<div id="filterbox">
	<input type="text" class="form-control border-warning mt-2" id="locFilter" placeholder="#돌봄 지역을 입력해주세요">
	<form class="form-inline">
	<label class="my-1 mr-2" for="selectType"></label>
	<select class="custom-select my-1 mr-sm-2" id="selectType" style="width: 100%;">
	<option selected>돌봄 유형을 선택하시면, 맞춤 일자리를 보여드려요</option>
	<option value="정기 돌봄">2~10세 정기 돌봄</option>
	<option value="신생아/영아">신생아/영아 정기 돌봄</option>
	<option value="긴급">긴급 돌봄</option>
	<option value="all">모든 돌봄 유형 보기</option>
	</select>
	</form>
</div>
	<div id="btnBox">
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act1" >실내놀이</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act2">등하원돕기</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act3">책읽기</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act4">야외활동</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act5">한글놀이</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act6">영어놀이</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act7">학습지도</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act8">체육놀이</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act9">간단청소</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act10">밥챙겨주기</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act11">간단설거지</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act12">장기입주</button>
		<button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act13">단기입주</button>
	</div>
 
	<div class="total" style="float: left; margin: 0px; margin-top: -5px; margin-left: 5px;"><br/>총 <b><span id="Tcnt">${totalRecords}</span></b>건의 일자리 찾기가 있습니다</div>
	<select class="custom-select my-1 mr-sm-2" id="selectArray" style="width:20%; float: right; margin: 0px;">
	    <option selected value="new">최신순</option>
	    <option value="wage_high">높은 시급순</option>
	    <option value="wage_low">낮은 시급순</option>
	</select>
	
	</div>
	<br/>
	<br/>
	<div class="row" id="cardBox">
		<c:forEach var="vo" items="${list2}">
			<div class="col-sm-6" style="padding: 20px;">
				<div class="card">
					<div class="card-body">
						<div class="imgBox"><img src="img/hoochoo.jpg" class="rounded-circle"></div>
						<div class="badge badge-warning badge-pill ml-1" style="position: absolute; top: 170px; left: 53px;"><span>${vo.tcnt}</span>명 지원</div>
						<div class="offerBox" >
							<span class="card-title" class="offerTitle" style="line-height: 2em;"><b>후추후추후추</b></span>
							<p class="card-text" style="line-height: 1.8em;"><span style="color: gray;">no. ${vo.job_board_no} | ${vo.userid }</span>
							<br/><span><b>신생아 1명, 유아 1명</b> | ${vo.writedate}</span>
							<br/><span>${vo.care_addr} </span>
							<br/><span><b>${vo.start_date}</b> 시작</span>
							<br/><span style="color: orange;">희망시급 ${vo.wish_wage}원
							
							
							<c:if test="${vo.consultation=='Y'}"> | <b>협의가능</b></c:if></span>
							
							</p>
						</div>
					</div>
				<div class="card-footer btn" onclick="location.href='parentView?no=${vo.job_board_no}'">자세히 보기</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	
	
<!-- ================================지도======================================== -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d236a21d1724aae6ae65ed16423e6d4f"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng("${mvo.lat}", "${mvo.lng}"), // 지도의 중심좌표
	        level: 8 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 
	// 마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [
		<c:forEach var="vo" items="${hash}">
	    {
	        content: '<div style="padding:5px;">${vo.username.substring(0,1)}O${vo.username.substring(2)}<br/><a href="teacherView?userid=${vo.userid}">프로필보기</a></div>', 
	        latlng: new kakao.maps.LatLng("${vo.lat}", "${vo.lng}")
	    },
	    </c:forEach>
	];
	
	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        //title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	
	  //  var iwContent = '<div style="padding:5px;">Hello World! <br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	
		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    content : positions[i].content 
		});
		  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	//infowindow.open(map, marker); 
	
	
	
	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	// 이벤트 리스너로는 클로저를 만들어 등록합니다 
	// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
	kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow));
	}//for문
	
	//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
		return function() {
		    infowindow.open(map, marker);
		};
	}
	
	//인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
		return function() {
		    infowindow.close();
		};
	}

</script>
	
	
	
	
	
	
	
	
	
	
	
	</div>
<hr/>
<jsp:include page="../footer.jsp"/>
</body>
</html>