<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String user_name = (String)request.getAttribute("USER");
%>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/photos_design.css">
	<link rel="stylesheet" href="css/comment_modal.css">
	<link rel="stylesheet" href="css/userGood.css">

	<!-- font-awesome用CSS -->
	<link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">

	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/jquery-context-menu.min.js"></script>
	<script src="js/modal-fix.js"></script>
	<script src="js/comment-modal.js"></script>
	<script src="js/userGood.js"></script>
	<title></title>

	<script>
		//jQuery動作確認
		//$(function(){console.log('jq_activate')})
	</script>

	<script>

		$(document).on("submit","#com-form",function(evt){
			evt.preventDefault();
			console.log('confirm');

			if(window.confirm('コメントを投稿しますか?')){
				$.ajax({
					url:$('#com-form').attr('action'),
					type:$('#com-form').attr('method'),
				}).then(
					function(){
						console.log('success');
						alert('投稿が完了しました!');
						console.log('delete');
						$("#comment-modal,#modal-overlay").fadeOut("slow",function(){
						//フェードアウト後、[#modal-overlay]をHTML(DOM)上から削除
							$("#modal-overlay").remove();
							$("#id_input").remove();
						});
					},
					function(){
						console.log('failed');
					}
				)
			}
		})
		// .done(
		// 	$.ajax({
		// 		url:$('#com-form').attr('action'),
		// 		type:$('#com-form').attr('method'),
		// 		data:$('')
		// 	}).then(
		// 		function(){
		// 			console.log('success');
		// 			alert('投稿が完了しました!');
		// 			console.log('delete');
		// 			$("#comment-modal,#modal-overlay").fadeOut("slow",function(){
		// 			//フェードアウト後、[#modal-overlay]をHTML(DOM)上から削除
		// 				$("#modal-overlay").remove();
		// 			});
		// 		},
		// 		function(){
		// 			console.log('failed');
		// 		}
		// 	)
		// ).fail(

		// )
	</script>
	<script>
		var view ="";
		var min_id ="";
		$(function(){
			view = "";
			$.ajax({
				url:"./PhotoListServlet", //初回パラメータなし
				type: 'post',
				datatype: 'json',
				async: 'false',
			}).then(
				function(data){
					//console.log('in');
					var jsonObject = data;
					min_id = jsonObject['min_id'];
					$.ajaxSetup({async:true});
					var json_length = jsonObject['photo'].length;
					for(var i=0;i<json_length;i++){
						setUserGood();
						var json_com_len = jsonObject['photo'][i]['comments'].length;
						console.log(i+':loop_main');
						view += '<section class="photo-view">'
							+'<div class="main-img">'
								+'<img class="preview-img" src="images/dummy_images.jpg" alt="dummy">'
							+'</div>'
							+'<ul class="user-info">'
								+'<li class="com-user">'+jsonObject['photo'][i]['user']+'</li>'
								+'<li class="com-main">'+jsonObject['photo'][i]['explanation']+'</li>'
								+'<li class="com-date">'+jsonObject['photo'][i]['time']+'</li>'
							+'</ul>'
							+'<div id="details">'
								+'<span style="margin-left:8%;"><a class="goodButton goodPhotoID_'+jsonObject['photo'][i]['photo_id']+'" href="javascript:sendGood('+jsonObject['photo'][i]['photo_id']+');"><img src="./images/icon/heart_'+jsonObject['photo'][i]['user_good']+'.png"> <span>'+jsonObject['photo'][i]['good_cnt']+'</span></a></span>'
								+'<span class="likeButton"><img src="images/icon/comment.png"> '+jsonObject['photo'][i]['com_cnt']+'</span><br>'
								+'<ul id="com-preview">';
						for(var j=0;j<json_com_len;j++){
							//console.log(jsonObject['photo'][i]['comments'][j]+"com_obj");
							var now_loop = j+1;
							if((now_loop%2)==0){
								//console.log('in:'+[j]);
								view += '<li class="com-inner">';
									view += '<ul>'
										view += '<li class="com-user">'+jsonObject['photo'][i]['comments'][j]['com_name']+'</li>';
										view += '<li class="com-main">'+jsonObject['photo'][i]['comments'][j]['comment']+'</li>';
										view += '<li class="com-date">'+jsonObject['photo'][i]['comments'][j]['com_time']+'</li>';
									view += '</ul>'
								view += '</li>';
								//console.log('in loop2:'+[j]);
								if(j != (json_com_len-1)){
									view += '</ul><div class="more">もっと見る</div>';
								}
							}else{
								view += '<ul class="content">';
								view += '<ul class="com-inner">';
									view += '<li class="com-user">'+jsonObject['photo'][i]['comments'][j]['com_name']+'</li>';
									view += '<li class="com-main">'+jsonObject['photo'][i]['comments'][j]['comment']+'</li>';
									view += '<li class="com-date">'+jsonObject['photo'][i]['comments'][j]['com_time']+'</li>';
								view += '</ul>';
							}
						}
						view += '</ul>'
							+'<a id="modal-open" onclick="openModal(&quot;'+jsonObject['photo'][i]['user']+'&quot;);">コメントを追加する<i class="fa fa-pencil" aria-hidden="true"></i></a>'
							+'</div>'
						+'</section>';
						//console.log(i);
					}
					// if(json_length != 0){
					// 	view+='<a href="#" id="more-button" onclick="moreContent(); moreContentReload();">More...</a>';
					// }
					//console.log(view);
					$("#photo-area").append(view);
				}
			)
		})
		function moreContent(){
			view ="";
			$.ajax({
				url:"./PhotoListServlet?min_id="+min_id, //初回パラメータなし
				type: 'post',
				datatype: 'json',
				async: 'false',
			}).then(
				function(data){
					var jsonObject = data;
					min_id = jsonObject['min_id'];
					$.ajaxSetup({async:true});
					var json_length = jsonObject['photo'].length;
					for(var i=0;i<json_length;i++){
						setUserGood();
						var json_com_len = jsonObject['photo'][i]['comments'].length;
						view += '<section class="photo-view">'
							+'<div class="main-img">'
								+'<img class="preview-img" src="images/dummy_images.jpg" alt="dummy">'
							+'</div>'
							+'<ul class="user-info">'
								+'<li class="com-user">User:'+jsonObject['photo'][i]['user']+'</li>'
								+'<li class="com-main">'+jsonObject['photo'][i]['explanation']+'</li>'
								+'<li class="com-date">Date'+jsonObject['photo'][i]['time']+'</li>'
							+'</ul>'
							+'<div id="details">'
								+'<span  style="margin-left:8%;"><a class="goodButton goodPhotoID_'+jsonObject['photo'][i]['photo_id']+'" href="javascript:sendGood('+jsonObject['photo'][i]['photo_id']+');"><img src="./images/icon/heart_'+jsonObject['photo'][i]['user_good']+'.png"> <span>'+jsonObject['photo'][i]['good_cnt']+'</span></a></span>'
								+'<span class="likeButton"><img src="images/icon/comment.png"> '+jsonObject['photo'][i]['com_cnt']+'</span><br>'
								+'<ul id="com-preview">'
						for(var j=0;j<json_com_len;j++){
							//console.log(jsonObject['photo'][i]['comments'][j]+"com_obj");
							var now_loop = j+1;
							if((now_loop%2)==0){
								//console.log('in:'+[j]);
								view += '<li class="com-inner">';
									view += '<ul class="com-inner">'
										view += '<li class="com-user">'+jsonObject['photo'][i]['comments'][j]['com_name']+'</li>';
										view += '<li class="com-main">'+jsonObject['photo'][i]['comments'][j]['comment']+'</li>';
										view += '<li class="com-date">'+jsonObject['photo'][i]['comments'][j]['com_time']+'</li>';
									view += '</ul>'
								view += '</li>';
								//console.log('in loop2:'+[j]);
								if(j != (json_com_len-1)){
									view += '</ul><div class="more">もっと見る</div>';
								}
							}else{
								view += '<ul class="content">';
								view += '<ul class="com-inner">';
									view += '<li class="com-user">'+jsonObject['photo'][i]['comments'][j]['com_name']+'</li>';
									view += '<li class="com-main">'+jsonObject['photo'][i]['comments'][j]['comment']+'</li>';
									view += '<li class="com-date">'+jsonObject['photo'][i]['comments'][j]['com_time']+'</li>';
								view += '</ul>';
							}
						}
						view += '</ul>'
								+'<a id="modal-open" onclick="openModal(&quot;'+jsonObject['photo'][i]['user']+'&quot;);">コメントを追加する　<i class="fa fa-pencil" aria-hidden="true"></i></a>'
							+'</div>'
						+'</section>';
					}
					// if(json_length != 0){
					// 	view+='<a href="#" id="more-button" onclick="moreContent(); moreContentReload();">More...</a>';
					// }
					$("#photo-area").append(view);
				}
			)
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
			<form action="./PhotoCommenServlet" method="post" id="com-form">
				<p id="dest-user"></p>
				<span>コメント</span> <br>
				<textarea name="p_comment" id="" cols="30" rows="10" class="com-modal-mes"></textarea><br>
				<button name="button" type="submit">投稿確認</button>
			</form><br>
			<a id="modal-close">close</a>
		</div>
		<!-- ヘッダー -->

		<header>
			<div id="logo">
				<img src="images/logo.png" />
			</div>
			<div id="logout">
				<a href="./Logout"><img src="images/logout_button.png"></a>
			</div>
		</header>
		<article id="photo-area">

		</article>
		<div class="more-button-area"><a href="#" id="more-button" onclick="moreContent(); moreContentReload();">さらに表示</a></div>
		<!-- フッター -->
		<footer>
			<ul>
				<li class="camera_nav"><a><img
						src="images/photo_current_button.png" /></a></li>
				<li class="collage_nav"><a href="./StampServlet"><img
						src="images/stamp_button.png" /></a></li>
				<li class="add_nav"><a href="photoUpload.jsp"><img
						src="images/add_button.png" /></a></li>
				<li class="information_nav"><a href="./RankingServlet"><img
						src="images/rank_button.png" /></a></li>
				<li class="user_nav"><a href="./UserServlet"><img
						src="images/profile_button.png" /></a></li>
			</ul>
		</footer>
	</div>
<body>
</html>
