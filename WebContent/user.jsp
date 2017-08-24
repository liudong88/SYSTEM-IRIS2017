<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList"
	import="java.util.HashMap"
%><%
String usrName = "丙てーとく";
ArrayList<String[]> images = new ArrayList<String[]>();

//--▼▼dummy▼▼	--
String dm0[] = {"0", "./images/stamp/Richelieu.png"};
String dm1[] = {"0", "./images/stamp/Richelieu.png"};
String dm2[] = {"0", "./images/stamp/Richelieu.png"};
images.add(dm0);
images.add(dm1);
images.add(dm2);
images.add(dm0);
images.add(dm1);
images.add(dm2);
images.add(dm0);
images.add(dm1);
//--▲▲dummy▲▲--

String imgTable = "";
int tmpCnt = 0;
for(String[] img: images) {
	if(tmpCnt == 0) 
		imgTable += "<tr>";
	imgTable += "<td><a href=\"javascript:getDetails("+img[0]+");\"><img src=\""+img[1]+"\"></a></td>";
	tmpCnt++;
	if(tmpCnt == 3) {
		tmpCnt = 0;
		imgTable += "</tr>";
	}
}
if(tmpCnt != 0) {
	while(tmpCnt < 3) {
		imgTable += "<td></td>";
		tmpCnt++;
	}
	imgTable += "</tr>";
}
%><!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf=8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ユーザ情報</title>
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="stylesheet" type="text/css" href="css/user.css">
	<link rel="stylesheet" type="text/css" href="./css/photoDetails.css">
	<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="./js/photoDetails.js"></script>
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
			<h1 id="userName"><%=usrName %></h1>
			<table id="myImg">
				<tbody><%=imgTable %></tbody>
			</table>
		</section>
		<!-- フッター -->
					<footer>
				<ul>
					<li class="camera_nav"><a href="#"><img
							src="images/photo_button.png" /></a></li>
					<li class="collage_nav"><a href="#"><img
							src="images/stamp_button.png" /></a></li>
					<li class="add_nav"><a href="#"><img
							src="images/add_button.png" /></a></li>
					<li class="information_nav"><a href="#"><img
							src="images/infomation_button.png" /></a></li>
					<li class="user_nav"><a href="#"><img
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