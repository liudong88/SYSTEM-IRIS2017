<%@ page 
	language="java" 
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList"
	import="java.util.HashMap"
%><%
ArrayList<String[]> mapSpots = new ArrayList<String[]>(); // request.getAttribute
HashMap<String, String> stampMap = new HashMap<String, String>(); // スポットID, 画像名

/*--dummy Start--*/
stampMap.put("1", "./images/stamp/dummy.png");

String spotInfo_0[] = {"0", "通天閣", "34.652499", "135.506306", "100"};
String spotInfo_1[] = {"1", "あべのハルカス", "34.645842", "135.513971", "200"};
String spotInfo_2[] = {"2", "大阪城", "34.684581", "135.526349", "400"};
String spotInfo_4[] = {"3", "グリコ看板", "34.668896", "135.501155", "50"};
String spotInfo_3[] = {"4", "スカイビル", "34.70528", "135.490687", "200"};
mapSpots.add(spotInfo_0);
mapSpots.add(spotInfo_1);
mapSpots.add(spotInfo_2);
mapSpots.add(spotInfo_3);
mapSpots.add(spotInfo_4);
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
		mapInfoWindow += "var infoWindow"+spot[0]+" = new google.maps.InfoWindow({position: new google.maps.LatLng("+spot[2]+", "+spot[3]+"),content:\"<img src='"+stampMap.get(spot[0])+"'>\" , pixelOffset: new google.maps.Size(0, -50),});";
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
		stampTable += "<tr>";
	}
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
		$(function() {
			$('table#stampList > tbody > tr > td').css({'height': $('table#stampList > tbody > tr > td').width() + 'px'});
			// Mapの高さ指定
			$('#googleMap').css({'height': ($('#googleMap').width() * 0.75) + 'px'});
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
				<li class="camera_nav"><a href="#"><img
						src="images/camera_button.png" /></a></li>
				<li class="collage_nav"><a href="#"><img
						src="images/collage_button.png" /></a></li>
				<li class="add_nav"><a href="#"><img
						src="images/add_button.png" /></a></li>
				<li class="information_nav"><a href="#"><img
						src="images/infomation_button.png" /></a></li>
				<li class="user_nav"><a href="#"><img
						src="images/user_button.png" /></a></li>
			</ul>
		</footer>
	</div>
</body>
</html>