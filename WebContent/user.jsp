<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList"
	import="java.util.HashMap"
%><%
/*String usrName = "丙てーとく";
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
//--▲▲dummy▲▲--*/

String usrName = (String)request.getAttribute("USERNAME");
ArrayList<String[]> images = (ArrayList<String[]>)request.getAttribute("IMAGES");

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
	<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
		function getDetails(id) {
			$.ajax({
				//url: './js/samplePhotoDetails.json?photo_id=' + id,
				url: './PhotoDetailsServlet?photo_id=' + id,
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
			HTML += '<div id="photoComments" style="padding:15px;">';
			HTML += '<h3 style="padding:5px 0;">コメント一覧</h3>';
			HTML += '<ul>';
			for(var i = 0; i < data.com_cnt; i++) {
				HTML += '<li>';
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
			<h1 id="userName"><%=usrName %></h1>
			<table id="myImg">
				<tbody><%=imgTable %></tbody>
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