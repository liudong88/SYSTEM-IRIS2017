<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList"
	import="java.util.HashMap"
%><%
//ArrayList<String[]> mapSpots = new ArrayList<String[]>(); // request.getAttribute
//HashMap<String, String> stampMap = new HashMap<String, String>(); // スポットID, 画像名

ArrayList<String[]> mapSpots = (ArrayList<String[]>)request.getAttribute("MAPSPOTS");
HashMap<String, String[]> stampMap = (HashMap<String, String[]>)request.getAttribute("STAMPMAP");

/*--dummy Start--*/
//stampMap.put("1", "./images/stamp/dummy.png");

/*String spotInfo_0[] = {"0", "通天閣", "34.652499", "135.506306", "100"};
String spotInfo_1[] = {"1", "あべのハルカス", "34.645842", "135.513971", "200"};
String spotInfo_2[] = {"2", "大阪城", "34.684581", "135.526349", "400"};
String spotInfo_4[] = {"3", "グリコ看板", "34.668896", "135.501155", "50"};
String spotInfo_3[] = {"4", "スカイビル", "34.70528", "135.490687", "200"};
mapSpots.add(spotInfo_0);
mapSpots.add(spotInfo_1);
mapSpots.add(spotInfo_2);
mapSpots.add(spotInfo_3);
mapSpots.add(spotInfo_4);*/
/*--dummy End--*/

String mapMarker = "";
String mapMarkerClick = "";
String mapMarkerCircle = "";
String mapInfoWindow = "";
String stampTable = "";
int tmpCnt = 0;
for(String[] spot: mapSpots) {
	boolean tmpTF = stampMap.containsKey(spot[0]);
	// googleMap
	mapMarker += "var marker"+spot[0]+" = new google.maps.Marker({ map: map , position: new google.maps.LatLng("+spot[2]+", "+spot[3]+"),icon: {url: \"./images/stamp/mapIcon";
	if(tmpTF) {
		mapMarker += "1";
	}
	mapMarker += ".png\"}, clickable:";
	if(tmpTF) {
		mapMarker += "true";
	} else {
		mapMarker += "false";
	}
	mapMarker += "});";
	//--
	if(tmpTF) {
		mapInfoWindow += "var infoWindow"+spot[0]+" = new google.maps.InfoWindow({position: new google.maps.LatLng("+spot[2]+", "+spot[3]+"),content:\"<a href='javascript:getDetails("+stampMap.get(spot[0])[0]+");'><img src='"+stampMap.get(spot[0])[1]+"' style='max-width:128px; max-height:128px;'></a><br><p style='width:128px;overflow:hidden;'>"+spot[1]+"</p>\" , pixelOffset: new google.maps.Size(0, -50),});";
		mapMarkerClick += "marker"+spot[0]+".addListener( \"click\", function ( argument ) {infoWindow"+spot[0]+".open(map);});";
	}
	//--
	mapMarkerCircle += "var circle"+spot[0]+" = new google.maps.Circle({map: map,center: new google.maps.LatLng("+spot[2]+", "+spot[3]+"),radius: "+spot[4]+",strokeWeight: 0,fillColor: \"#f00\"});";
	// stampList
	if(tmpCnt == 0) {
		stampTable += "<tr>";
	}
	stampTable += "<td>";
	if(tmpTF) {
		stampTable += "<img src=\"./images/stamp/stamp_"+spot[0]+".png\">";
	}
	stampTable += "</td>";
	tmpCnt++;
	if(tmpCnt == 4) {
		tmpCnt = 0;
		stampTable += "</tr>";
	}
}
if(tmpCnt != 0) {
	while(tmpCnt < 4) {
		stampTable += "<td class=\"noStamp\"></td>";
		tmpCnt++;
	}
	stampTable += "</tr>";
}
%><!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf=8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>スタンプラリー</title>
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="stylesheet" type="text/css" href="css/stampRally.css">
	<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCihy_b9BGxc74hMTyBujEAUCTNWQOBUuA&libraries=drawing&lang=ja"></script>
	<script type="text/javascript">
		function getDetails(id) {
			$.ajax({
				url: './js/samplePhotoDetails.json?photo_id=' + id,
				type: 'GET',
				datatype: 'json'
			}).then(function(json) {
				var data = json.photo[0];
				openModal(data);
			}, function(json) {
				console.log('getDetails: error');
			});
		}
		function openModal(data) {
			var HTML = '';
			//--img--
			HTML += '<div style="padding:15px; border-style:solid none dotted;border-width:3px 0;border-color:#fff;"><img src="'+data.path+'" style="width:100%;"></div>';
			//--info--
			HTML += '<ul style="padding:15px; border-style:solid;border-width:0 0 3px;border-color:#fff;">';
			HTML += '<li>投稿日時：'+data.time+'</li>';
			HTML += '<li>Good!：'+data.good_cnt+'件♡</li>';
			HTML += '<li>コメント件数：'+data.com_cnt+'件</li>';
			HTML += '</ul>';
			//--comment--
			HTML += '<div style="padding:15px;">';
			HTML += '<h3 style="padding:5px 0;">コメント一覧</h3>';
			HTML += '<ul style="padding:0 0 0 15px;">';
			for(var i = 0; i < data.com_cnt; i++) {
				HTML += '<li style="padding:15px 0;">';
				HTML += '<ul>';
				HTML += '<li>ニックネーム：'+data.comments[i].com_name+'</li>';
				HTML += '<li>コメント投稿日時：'+data.comments[i].com_time+'</li>';
				HTML += '<li>'+data.comments[i].comment+'</li>';
				HTML += '</ul>';
				HTML += '</li>';
			}
			HTML += '</ul>';
			HTML += '</div>';

			$('div#modalWindow > div#modalContent').html(HTML);
			$('body').css({overflow: 'hidden'});
			$('div#modalWindow').fadeIn('fast', function() {
			});
			$('div#modalHeader').css({height: $('div#modalHeader > a').outerHeight() + 'px'});
		}
		function closeModal() {
			$('div#modalWindow').fadeOut('fast');
			$('body').css({overflow: 'auto'});
		}
		$(function() {
			$('table#stampList > tbody > tr > td').css({height: $('table#stampList > tbody > tr > td').width() + 'px'});
			// Mapの高さ指定
			$('#googleMap').css({height: ($('#googleMap').width() * 0.75) + 'px'});
			// Map中心
			var mapCenter = new google.maps.LatLng(34.6937378, 135.5021651);
			// Map生成
			var map = new google.maps.Map(document.getElementById('googleMap'), {
				center: mapCenter,
				zoom: 12,
				clickableIcons: false,
				draggable: true,
				disableDefaultUI: true,
				styles: [
			    	{
						"elementType": "labels",
						"stylers": [
			     			{"visibility": "off"}
						]
			        }
				]

			});
			<%=mapMarker %>
			<%=mapMarkerClick %>
			<%=mapMarkerCircle %>
			<%=mapInfoWindow %>
			<%=mapMarkerClick %>

		});
	</script>
</head>
<body>
	<div id="top_page_wrapper">
		<!-- ヘッダー -->
		<header>
			<div id="logo">
				<img src="images/header_logo.png" />
			</div>
		</header>
		<section>
			<h1 style="display:none;">スタンプラリー</h1>
			<div id="googleMap"></div>
			<table id="stampList">
				<tbody>
					<%=stampTable %>
				</tbody>
			</table>
		</section>
		<!-- フッター -->
		<footer>
			<ul>
				<li class="camera_nav"><a href="share_photos.jsp"><img
						src="images/photo_button.png" /></a></li>
				<li class="collage_nav"><a href="./StampServlet"><img
						src="images/stamp_button.png" /></a></li>
				<li class="add_nav"><a href="photoUpload.jsp"><img
						src="images/add_button.png" /></a></li>
				<li class="information_nav"><a href="./RankingServlet"><img
						src="images/infomation_button.png" /></a></li>
				<li class="user_nav"><a href="./UserServlet"><img
						src="images/profile_button.png" /></a></li>
			</ul>
		</footer>
	</div>
	<div id="modalWindow">
		<div id="modalHeader"><a href="javascript:closeModal();">close <span style="font-size:200%;">×</span></a></div>
		<div id="modalContent"></div>
	</div>
</body>
</html>