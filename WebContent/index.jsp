<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf=8">
<title>index</title>
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/top_design.css">
<link rel="stylesheet" type="text/css" href="css/common.css">

<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="js/flipsnap.min.js"></script>
<script type="text/javascript">
	$(function() {
		var $pointer = $('.viewport .pointer span');
		var flipsnap = Flipsnap('.flipsnap', {});
		flipsnap.element.addEventListener('fspointmove', function() {
			$pointer.filter('.current').removeClass('current');
			$pointer.eq(flipsnap.currentPoint).addClass('current');
		}, false);
	});
</script>
</head>
<body>
	<div id="top_page_wrapper">
		<section></section>
<!-- フリックで操作するスライドショー -->
		<article>
			<div class="viewport">
				<ul class="flipsnap">
			<!-- 横750px、縦1074pxの画像 -->
					<li><img src="images/sample_image.png"></li>
					<li><img src="images/sample_image.png"></li>
					<li><img src="images/sample_image.png"></li>
				</ul>
				<div class="pointer">
					<span class="current"></span> <span></span> <span></span>
				</div>
			</div>
		</article>
<!-- ここまでがフリック -->
<!-- ヘッダーを常に表示させるためheaderとarticleの記述順を逆にしている -->
<!-- ヘッダー -->
		<header>
			<div class="application_name">
				<img src="images/header_logo.png" />
			</div>
			<div class="home_button">
				<a href="index.jsp"><img src="images/home_current_buttom.png" /></a>
			</div>
		</header>
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