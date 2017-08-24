<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>写真投稿</title>
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="stylesheet" type="text/css" href="css/photoUpload.css">
	<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
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
			<h1 style="display:none;">写真投稿</h1>
			<form action="PhotoServlet" method="post" enctype="multipart/form-data">
				<div id="target_id">
					<div class="imgInput">
						<input type="file" name="filename" id="inputphoto" size="50" accept="image/jpeg,image/png">
						<label for="inputphoto" id="filebutton">写真を選択する</label>
					</div>
					<input type="hidden" name="lat" id="lat">
					<input type="hidden" name="lng" id="lng">
					<p>写真説明</p>
					<textarea name="text"></textarea>
				</div>
				<div id="button_wrapper">
					<button type="submit" id="sbbutton" disabled>投稿する</button>
				</div>
			</form>
		</section>
		<!-- フッター -->
		<footer>
			<ul>
				<li class="camera_nav"><a href="./SharePhotos"><img
						src="images/photo_button.png" /></a></li>
				<li class="collage_nav"><a href="./StampServlet"><img
						src="images/stamp_button.png" /></a></li>
				<li class="add_nav"><a><img
						src="images/add_current_button.png" /></a></li>
				<li class="information_nav"><a href="./RankingServlet"><img
						src="images/rank_button.png" /></a></li>
				<li class="user_nav"><a href="./UserServlet"><img
						src="images/profile_button.png" /></a></li>
			</ul>
		</footer>
	</div>
	<script type="text/javascript" src="js/photoUpload.js"></script>
</body>
</html>