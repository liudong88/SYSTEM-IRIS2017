<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList"
	import="java.util.HashMap"
%><%
/*ArrayList<String[]> ranking = new ArrayList<String[]>(); // ranking
ArrayList<String[]> spots   = new ArrayList<String[]>(); // spots   ...plz request.getAttribute
String nowSpotID = ""; // nowSpotID 全スポットの場合は空
//--dummy↓↓↓--
String dummyRanking0[] = {"./images/stamp/Richelieu.png", "リシュリュううううううううううう", "67890", "丙てーとく", "1"};
String dummyRanking1[] = {"./images/stamp/Richelieu.png", "リシュリュううううううううううう", "123",    "丙てーとく", "1"};
String dummyRanking2[] = {"./images/stamp/Richelieu.png", "リシュリュううううううううううう", "45",     "丙てーとく", "1"};
ranking.add(dummyRanking0);
ranking.add(dummyRanking1);
ranking.add(dummyRanking2);
String dummySpots0[] = {"0", "横鎮"};
String dummySpots1[] = {"1", "舞鶴"};
String dummySpots2[] = {"2", "呉"  };
spots.add(dummySpots0);
spots.add(dummySpots1);
spots.add(dummySpots2);*/
//--dummy↑↑↑--

ArrayList<String[]> ranking = (ArrayList<String[]>)request.getAttribute("RANKING"); // ranking
ArrayList<String[]> spots   = (ArrayList<String[]>)request.getAttribute("SPOTS"); // spots   ...plz request.getAttribute
String nowSpotID = (String)request.getAttribute("NOWSPOT"); // nowSpotID 全スポットの場合は空

String spotList    = "";
String rankingList = "";
String nowSpot     = "";

for(String[] spot: spots) {
	spotList += "<li><a href=\"?spot_id="+spot[0]+"\">▶ "+spot[1]+"</a></li>";
}
for(String[] data: ranking) {
	String tmpNum[] = data[2].split("");
	String tmpGood = "";
	for(String num: tmpNum) {
		tmpGood += "<img class=\"goodNum\" src=\"./images/ranking/num_"+num+".png\">";
	}


	rankingList += "<li>";
	rankingList += "<ul>";
	rankingList += "<li style=\"background-color:#eee;border-radius:0/0;\"><img class=\"goodNum\" src=\"./images/icon/heart_true.png\">"+tmpGood+"</li>";
	rankingList += "<li style=\"padding:0;\"><a href=\"javascript:getDetails("+data[4]+");\"><img src=\""+data[0]+"\"></a></li>";
	rankingList += "<li style=\"padding:0 5px;color:#ccc;\">"+data[3]+"</li>";
	rankingList += "<li style=\"border-style:solid;background-color:#9bffd9;margin:5px 10px 10px 2em;\">"+data[1]+"</li>";
	rankingList += "</ul>";
	rankingList += "</li>";

}
if(nowSpotID.isEmpty()) {
	nowSpot = "すべて";
} else {
	for(String[] spot: spots) {
		if(nowSpotID.equals(spot[0])) {
			nowSpot = spot[1];
		}
	}
}

%><!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf=8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ランキング</title>
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="stylesheet" type="text/css" href="css/ranking.css">
	<link rel="stylesheet" type="text/css" href="./css/photoDetails.css">
	<link rel="stylesheet" type="text/css" href="./css/userGood.css">
	<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="./js/photoDetails.js"></script>
	<script type="text/javascript" src="./js/userGood.js"></script>
	<script type="text/javascript">
	var selectOpenTF = false;
	var selectSpotHeight_1;
	var selectSpotHeight_2;
	function selectOpen() {
		if(!selectOpenTF) {
			$('ul#selectSpot > li').animate({height: selectSpotHeight_2 + 'px'});
			selectOpenTF = !selectOpenTF;
		} else {
			$('ul#selectSpot > li').animate({height: selectSpotHeight_1 + 'px'});
			selectOpenTF = !selectOpenTF;
		}
	}
	$(function () {
		selectSpotHeight_1 = $('ul#selectSpot > li').height();
		$('ul#selectSpot > li > ul').css({display: 'block'});
		selectSpotHeight_2 = $('ul#selectSpot > li').height();
		$('ul#selectSpot > li').css({height: selectSpotHeight_1 + 'px'});
	});
	</script>
</head>
<body>
	<div id="top_page_wrapper">
		<!-- ヘッダー -->
		<header>
			<div id="logo">
				<img src="images/logo.png" />
			</div>
			<div id="logout">
				<a href="./Logout"><img src="images/logout_button.png"></a>
			</div>
		</header>
		<section>
			<ul id="selectSpot">
				<li onclick="selectOpen();"><span style="font-size:125%;">▼ 絞り込み</span> - <%=nowSpot %>
					<ul>
						<li><a href="?">▶ すべて</a></li>
						<%=spotList %>
					</ul>
				</li>
			</ul>
				<ul id="photoRanking"><%=rankingList %></ul>
		</section>
		<!-- フッター -->
		<footer>
			<ul>
				<li class="camera_nav"><a href="./SharePhotos"><img
						src="images/photo_button.png" /></a></li>
				<li class="collage_nav"><a href="./StampServlet"><img
						src="images/stamp_button.png" /></a></li>
				<li class="add_nav"><a href="photoUpload.jsp"><img
						src="images/add_button.png" /></a></li>
				<li class="information_nav"><a><img
						src="images/rank_current_button.png" /></a></li>
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