<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" href="css/reset.css">
	<!-- <link rel="stylesheet" href="css/common.css"> -->
	<link rel="stylesheet" href="css/photos_design.css">
	<link rel="stylesheet" href="css/test_style.css">
	<link rel="stylesheet" href="css/context_menu.css">
	<link rel="stylesheet" href="css/comment_modal.css">

	<!-- font-awesome用CSS -->
	<link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">

	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/jquery-context-menu.min.js"></script>
	<script src="js/modal-fix.js"></script>
	<script src="js/comment-modal.js"></script>
	<title></title>

	<script>
		//jQuery動作確認
		//$(function(){console.log('jq_activate')})
	</script>

	<script>
		// ポップアップメニュー表示
		// $(function(){
		// 	--context_menu implementation
		// 	var x = new _contextMenu();
		// 	x.config({
		// 		contextBoxClass : 'context-box',
		// 		clickedOnClass : 'trigger_context_menu',
		// 		closeBtnClass : 'close-btn',
		// 		popupBesideClass : 'className',
		// 		disableErrorLog: true,
		// 		box_position : 'bot-right',
		// 		displacement_px : [-140,2]
		// 	})
		// 	x.run();
		// });
	</script>
	
	<script>
		$(document).on("submit","#com-form",function(evt){
			evt.preventDefault();
			console.log('confirm');

			if(window.confirm('コメントを投稿しますか?')){
				$.ajax({
					url:$('#com-form').attr('action'),
					type:$('#com-form').attr('method'),
					data:$('')
				}).then(
					function(){
						console.log('success');
					},
					function(){
						console.log('failed');
					}
				)
			}else{

			}
		})
	</script>
	<script>
		var photo_id = 1;
		var good_flag = true;
		var icon_tag = '#like-icon'+photo_id;

		$(document).on('click',"#like-icon",function(){
			if(good_flag === true){
				$(icon_tag).css('color','pink');
			}else{
				$(icon_tag).css('color','gray');
			}
			
			$.ajax({
				url: '#',
				type:'post',
				data:''
			}).then(
				function(){
					console.log('success');
					if($(icon_tag).attr('color','gray')){
						$(icon_tag).css('color','pink');
						console.log('change:pink');
					}else if($(icon_tag).attr('color','pink')){
						$(icon_tag).css('color','gray');
						console.log('change:gray');
					}	
				},
				function(){
					console.log('failed');
				}
			)
		})
	</script>
</head>
<body>
	<div id="wrapper-main">
		<header>
			<p>test</p>
		</header>

		<article id="photo-area">

			<div id="comment-modal">
				<form action="" id="com-form">
					<p>さんへのコメントを投稿</p>
					<input type="text" name="com-title"><br>
					<textarea name="comment" id="" cols="30" rows="10"></textarea>
					<button name="button" type="submit">投稿確認</button>
				</form>
				<a href="#" id="modal-close">close</a>
			</div>

			<!-- section.photo-view で取得した画像、情報を表示 -->
			<section class="photo-view">
				<!-- 写真用ヘッダー&コンテキストメニュー -->
				<div class="photo-header">
					<div class="account-name">
						<p>account name</p>
					</div>
					<div class="menu-trigger">
						<!-- the triggerer -->
						<a href="#" class="trigger_context_menu">
							<span class="icon-menu">
								<i class="fa fa-bars" aria-hidden="true"></i>
							</span>
						</a>
					</div>
				</div>
				<!-- Context-menu -->
				<!-- <div class="context-box">
					<ul>
						<li class="inner-menu"><a href="#">test</a></li>
						<li class="inner-menu"><a href="#">hoge</a></li>
						<li><a href="#" class="close-btn">close</a></li>
					</ul>
				</div> -->
				<!--  -->
				<div class="main-img">
					<img class="preview-img" src="images/dummy_images.jpg" alt="dummy">
				</div>
				<!--  -->
				<div>
					<a href="#" id="modal-open" onclick="openModal();">open</a>
				</div>

			</section>

			<section class="photo-view">
				<!-- 写真用ヘッダー&コンテキストメニュー -->
				<div class="photo-header">
					<div class="account-name">
						<p>account name</p>
					</div>
					<div class="menu-trigger">
						<!-- the triggerer -->
						<a href="#" class="trigger_context_menu">
							<span class="icon-menu">
								<i class="fa fa-bars" aria-hidden="true"></i>
							</span>
						</a>
					</div>
				</div>
				<!-- Context-menu -->
				<div class="context-box">
					<ul>
						<li class="inner-menu"><a href="#">test</a></li>
						<li class="inner-menu"><a href="#">hoge</a></li>
						<li><a href="#" class="close-btn">close</a></li>
					</ul>
				</div>
				<!--  -->
				<div class="main-img">
					<img class="preview-img" src="images/dummy_images.jpg" alt="dummy">
				</div>
				<!--  -->
				<div>
					<i class="fa fa-heart" aria-hidden="true" id="like-icon"></i>
					<i class="fa fa-heart" aria-hidden="true" id="dislike-icon"></i>
					
				</div>
			</section>

			<section class="photo-view">
				<!-- 写真用ヘッダー&コンテキストメニュー -->
				<div class="photo-header">
					<div class="account-name">
						<p>account name</p>
					</div>
					<div class="menu-trigger">
						<!-- the triggerer -->
						<a href="#" class="trigger_context_menu">
							<span class="icon-menu">
								<i class="fa fa-bars" aria-hidden="true"></i>
							</span>
						</a>
					</div>
				</div>
				<!-- Context-menu -->
				<div class="context-box">
					<ul>
						<li class="inner-menu"><a href="#">test</a></li>
						<li class="inner-menu"><a href="#">hoge</a></li>
						<li><a href="#" class="close-btn">close</a></li>
					</ul>
				</div>
				<!--  -->
				<div class="main-img">
					<img class="preview-img" src="images/dummy_images.jpg" alt="dummy">
				</div>
				<!--  -->
				<div >

				</div>
			</section>

		</article>
		<!-- <footer>

		</footer> -->

		<!-- ヘッダーを常に表示させるためheaderとarticleの記述順を逆にしている -->
<!-- ヘッダー -->
		<!-- <header>
			<div class="application_name">
				<img src="images/header_logo.png" />
			</div>
			<div class="home_button">
				<a href="index.jsp"><img src="images/home_current_buttom.png" /></a>
			</div>
		</header> -->
<!-- フッター -->
		<!-- <footer>
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
		</footer> -->
	</div>
<body>
</html>