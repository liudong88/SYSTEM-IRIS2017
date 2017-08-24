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
						alert('投稿が完了しました!');
						console.log('delete');
						$("#comment-modal,#modal-overlay").fadeOut("slow",function(){
						//フェードアウト後、[#modal-overlay]をHTML(DOM)上から削除
							$("#modal-overlay").remove();
						});
					},
					function(){
						console.log('failed');
					}
				)
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

	<script>

		var view ="";

		var jsonObject = {
			"photo":[
				{
					"photo_id":"4",
					"path":"1_20170819193036312.png",
					"latitude":"35.111111",
					"longitude":"135.222222",
					"user":"ben",
					"time":"2017-08-19 19:30:36.0",
					"explanation":"Testttt",
					"good_cnt":"0",
					"com_cnt":"0",
					"user_good":"false",
					"comments":[]
				},
				{
					"photo_id":"3",
					"path":"1_20170819193002156.jpeg",
					"latitude":"35.111111",
					"longitude":"135.222222",
					"user":"タロウ",
					"time":"2017-08-19 19:30:02.0",
					"explanation":"Testttt",
					"good_cnt":"1",
					"com_cnt":"2",
					"user_good":"false",
					"comments":[
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 01:35:11.0",
							"comment":"コメントコメント"
						},
						{
							"com_name":"タロウ",
							"com_time":"2017-08-21 01:28:17.0",
							"comment":"コメントコメントコメント"
						}
					]
				},
				{
					"photo_id":"2",
					"path":"1_20170819192517678.png",
					"latitude":"35.111111",
					"longitude":"135.222222",
					"user": "daniel",
					"time":"2017-08-19 19:25:18.0",
					"explanation":"Testttt",
					"good_cnt":"0",
					"com_cnt":"1",
					"user_good":"false",
					"comments":[
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:20.0",
							"comment":"コメント"
						},
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						},
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						}
					]
				},
				{
					"photo_id":"1",
					"path":"15029397690141063822137.jpg",
					"latitude":"35.111111",
					"longitude":"135.222222",
					"user":"タロウ",
					"time":"2017-08-17 12:38:57.0",
					"explanation":"Testttt",
					"good_cnt":"0",
					"com_cnt":"1",
					"user_good":"false",
					"comments":[
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						},
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						},
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						},
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						},
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						},
						{
							"com_name":"ハナコ",
							"com_time":"2017-08-21 02:30:30.0",
							"comment":"コメント"
						}
					]
				}
			],
			"min_id":"1"
		}

		$(function(){
			view = "";
			//$.ajax({
				//url:"", //初回パラメータなし
			//})
			//console.log('in');
			var json_length = jsonObject['photo'].length;
			for(var i=0;i<4;i++){
				var json_com_len = jsonObject['photo'][i]['comments'].length;
				console.log(i+':loop_main');
				view += '<section class="photo-view">'
					+'<div class="photo-header">'
						+'<div class="account-name">'
							+'<p>'+jsonObject['photo'][i]['user']+'</p>'
						+'</div>'
						+'<div class="menu-trigger">'
							+'<a href="#" class="trigger_context_menu">'
								+'<span class="icon-menu">'
									+'<i class="fa fa-bars" aria-hidden="true"></i>'
								+'</span>'
							+'</a>'
						+'</div>'
					+'</div>'
					+'<hr>'
					+'<div class="main-img">'
						+'<img class="preview-img" src="images/dummy_images.jpg" alt="dummy">'
					+'</div>'
					+'<hr>'
					+'<div id="details">'
						+'<span>投稿日時：'+jsonObject['photo'][i]['time']+'</span><br>'
						+'<span>good!：'+jsonObject['photo'][i]['good_cnt']+'件</span>'
						+'<i class="fa fa-heart-o" aria-hidden="true"></i><br>'
						+'<span>コメント件数：'+jsonObject['photo'][i]['com_cnt']+'件</span><br>'
						+'<hr class="horizon">'
						+'<span>コメント一覧</span><br>'
						+'<div id="com-preview">';
						for(var j=0;j<json_com_len;j++){
							//console.log(jsonObject['photo'][i]['comments'][j]+"com_obj");
							var now_loop = j+1;
							if((now_loop%2)==0){
								//console.log('in:'+[j]);
								view += '<div class="content">';
									view += '<p>ニックネーム：'+jsonObject['photo'][i]['comments'][j]['com_name']+'</p>';
									view += '<p>コメント投稿日時：'+jsonObject['photo'][i]['comments'][j]['com_time']+'</p>';
									view += '<p>'+jsonObject['photo'][i]['comments'][j]['comment']+'</p>';
								view += '</div>';
								//console.log('in loop2:'+[j]);
								view += '</div><div class="more">もっと見る</div>';
							}else{
								view += '<div class="content">';
								view += '<div class="com-inner">';
									view += '<p>ニックネーム：'+jsonObject['photo'][i]['comments'][j]['com_name']+'</p>';
									view += '<p>コメント投稿日時：'+jsonObject['photo'][i]['comments'][j]['com_time']+'</p>';
									view += '<p>'+jsonObject['photo'][i]['comments'][j]['comment']+'</p>';
								view += '</div>';
							}
						}
				view += '</div>'
						+'<a href="#" id="modal-open" onclick="openModal(&quot;'+jsonObject['photo'][i]['user']+'&quot;);">open</a>'
					+'</div>'
				+'</section>';
				//console.log(i);
			}
			if(json_length != 0){
				view+='<a href="#" id="more-button" onclick="moreContent(); moreContentReload();">More...</a>';
			}
			//console.log(view);
			$("#photo-area").append(view);
		})
	</script>

	<script>
		function moreContent(){
			view ="";
			//追加読み込み処理
			//$.ajax({
				//url:"", //getでパラメータに、min_idを追加
			//})

			//console.log('in');
			var json_length = jsonObject['photo'].length;
			for(var i=0;i<4;i++){
				console.log(i+':loop-more');
				var json_com_len = jsonObject['photo'][i]['comments'].length;
				//console.log(jsonObject['photo'][i]['comments']+"mesあああ");
				view += '<section class="photo-view">'
					+'<div class="photo-header">'
						+'<div class="account-name">'
							+'<p>'+jsonObject['photo'][i]['user']+'</p>'
						+'</div>'
						+'<div class="menu-trigger">'

							+'<a href="#" class="trigger_context_menu">'
								+'<span class="icon-menu">'
									+'<i class="fa fa-bars" aria-hidden="true"></i>'
								+'</span>'
							+'</a>'
						+'</div>'
					+'</div>'
					+'<hr>'
					+'<div class="main-img">'
						+'<img class="preview-img" src="images/dummy_images.jpg" alt="dummy">'
					+'</div>'
					+'<hr class="horizon">'
					+'<div id="details">'
						+'<span>投稿日時：'+jsonObject['photo'][i]['time']+'</span><br>'
						+'<span>good!：'+jsonObject['photo'][i]['good_cnt']+'件</span>'
						+'<i class="fa fa-heart-o" aria-hidden="true"></i><br>'
						+'<span>コメント件数：'+jsonObject['photo'][i]['com_cnt']+'件</span><br>'
						+'<div id="com-preview">'
							for(var j=0;j<json_com_len;j++){
								//console.log(jsonObject['photo'][i]['comments'][j]+"com_obj");
								var now_loop = j+1;
								if((now_loop%2)==0){
									//console.log('in:'+[j]);
									view += '<div class="com-inner">';
										view += '<p>ニックネーム：'+jsonObject['photo'][i]['comments'][j]['com_name']+'</p>';
										view += '<p>コメント投稿日時：'+jsonObject['photo'][i]['comments'][j]['com_time']+'</p>';
										view += '<p>'+jsonObject['photo'][i]['comments'][j]['comment']+'</p>';
									view += '</div>';
									//console.log('in loop2:'+[j]);
									view += '</div><div class="more">もっと見る</div>';
								}else{
									view += '<div class="content">';
										view += '<div class="com-inner">';
											view += '<p>ニックネーム：'+jsonObject['photo'][i]['comments'][j]['com_name']+'</p>';
											view += '<p>コメント投稿日時：'+jsonObject['photo'][i]['comments'][j]['com_time']+'</p>';
											view += '<p>'+jsonObject['photo'][i]['comments'][j]['comment']+'</p>';
										view += '</div>';
								}
							}
				view += '</div>'
						+'<a href="#" id="modal-open" onclick="openModal(&quot;'+jsonObject['photo'][i]['user']+'&quot;);">open</a>'
					+'</div>'
				+'</section>';
			}
			if(json_length != 0){
				view+='<a href="#" id="more-button" onclick="moreContent(); moreContentReload();">More...</a>';
			}
			$("#photo-area").append(view);
		}
	</script>

	<script>
		$(function(){
				$('.content:not(.content:first-of-type)').css('display','none');//一番上の要素以外を非表示
				$('.more').nextAll('.more').css('display','none');//ボタンを非表示
				$('.more').on('click', function() {
				$(this).css('display','none');//押したボタンを非表示
				$(this).next('.content').slideDown('fast');
				$(this).nextAll('.more:first').css('display','block'); //次のボタンを表示
			});
		});
	</script>

	<script>
		function moreContentReload(){
			$('.content:not(.content:first-of-type)').css('display','none');//一番上の要素以外を非表示
			$('.more').nextAll('.more').css('display','none');//ボタンを非表示
			$('.more').on('click', function() {
				$(this).css('display','none');//押したボタンを非表示
				$(this).next('.content').slideDown('fast');
				$(this).nextAll('.more:first').css('display','block'); //次のボタンを表示
			})
		}
	</script>

</head>
<body>
	<div id="wrapper-main">
		<div id="comment-modal">
			<form action="" id="com-form">
				<p id="dest-user"></p>
				<input type="text" name="com-title"><br>
				<textarea name="comment" id="" cols="30" rows="10"></textarea><br>
				<button name="button" type="submit">投稿確認</button>
			</form>
			<a href="#" id="modal-close">close</a>
		</div>
		<header>
			<p>test</p>
		</header>
		<article id="photo-area">

		</article>
		<footer>
			<ul class="nav">
				<li class="camera_nav"><a href="#"><img class="nav-img"
						src="images/camera_button.png" /></a></li>
				<li class="collage_nav"><a href="#"><img class="nav-img"
						src="images/collage_button.png" /></a></li>
				<li class="add_nav"><a href="#"><img class="nav-img"
						src="images/add_button.png" /></a></li>
				<li class="information_nav"><a href="#"><img class="nav-img"
						src="images/infomation_button.png" /></a></li>
				<li class="user_nav"><a href="#"><img class="nav-img"
						src="images/user_button.png" /></a></li>
			</ul>
			<!-- <button type="button" name="scroll">scroll to top</button> -->
		</footer>
	</div>
<body>
</html>
