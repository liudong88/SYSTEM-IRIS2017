<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//ユーザー名を取得
	String user_name = (String)request.getAttribute("");
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
	<script src="js/comment-modal.js"></script>
	<script src="js/userGood.js"></script>
	<title>投稿写真一覧</title>

	<script>
		var view ="";
		var min_id ="";
		
		$(function(){
			view = "";
			$.ajax({
				url:"./PhotoListServlet", //初回パラメータなし
				type: 'get',
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
								+'<img class="preview-img" src='+jsonObject['photo'][i]['path']+' alt="image">'
							+'</div>'
							+'<ul class="user-info">'
								+'<li class="com-user">'+jsonObject['photo'][i]['user']+'</li>'
								+'<li class="com-main">'+jsonObject['photo'][i]['explanation']+'</li>'
								+'<li class="com-date">'+jsonObject['photo'][i]['time']+'</li>'
							+'</ul>'
							+'<div id="details">'
								+'<span style="margin-left:8%;"><a class="goodButton goodPhotoID_'+jsonObject['photo'][i]['photo_id']+'" href="javascript:sendGood('+jsonObject['photo'][i]['photo_id']+');"><img src="./images/icon/heart_'+jsonObject['photo'][i]['user_good']+'.png"> <span>'+jsonObject['photo'][i]['good_cnt']+'</span></a></span>'
								+'<span class="likeButton"><img src="images/icon/comment.png"> '+jsonObject['photo'][i]['com_cnt']+'</span><br>'
								+'<ul id="com-preview" id="photo_id_'+jsonObject['photo'][i]['photo_id']+'">';
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
							+'<span id="com-modal-button">'
								+'<a href="javascript:void(0)"　id="modal-open" style="text-decoration:none;" onclick="openModal(&quot;'+jsonObject['photo'][i]['user']+'&quot;);">コメントを追加する<i class="fa fa-pencil" aria-hidden="true"></i></a>'
							+'</span>'
							+'</div>'
						+'</section>';
						//console.log(i);
					}
					$("#photo-area").append(view);
				}
			)
		})
		
		function moreContent(){
			view ="";
			$.ajax({
				url:"./PhotoListServlet?min_id="+min_id,
				type: 'get',
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
								+'<img class="preview-img" src='+jsonObject['photo'][i]['path']+' alt="img">'
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
								+'<a href="javascript:void(0)" id="modal-open" onclick="openModal(&quot;'+jsonObject['photo'][i]['user']+'&quot;);">コメントを追加する<i class="fa fa-pencil" aria-hidden="true"></i></a>'
							+'</div>'
						+'</section>';
					}
					$("#photo-area").append(view);
				}
			)
		}

		$(function(){
			if(min_id != 1 && min_id != 0){
				$('.more-button-area').html('<a href="javascript:void(0)" id="more-button" onclick="moreContent(); moreContentReload();">さらに表示</a>');
			}else{
				$('#more-button').remove();
			}
		})
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
			<form action="./PhotoCommentServlet" method="post" id="com-form">
				<p id="dest-user"></p>
				<hr>
				<textarea name="p_comment" cols="30" rows="10" id="com-modal-mes"></textarea><br>
				<button name="button" type="submit"　class="submit-btn">投稿確認</button>
				<div class="flex-cnt">
					<a href="javascript:void(0)" id="modal-close">close</a>
				</div>
			</form>
		</div>
		<!-- ヘッダー -->
		
		<header>
			<div id="logo">
				<img src="images/header_logo.png" />
			</div>
		</header>
		<article id="photo-area">

		</article>
		<div class="more-button-area">
		</div>
		<!-- フッター -->
		<footer>
			<ul>
				<li class="camera_nav"><a href="sharePhotos.jsp"><img
						src="images/photo_button.png" /></a></li>
				<li class="collage_nav"><a href="stampRally.jsp"><img
						src="images/stamp_button.png" /></a></li>
				<li class="add_nav"><a href="#"><img
						src="images/add_button.png" /></a></li>
				<li class="information_nav"><a href="#"><img
						src="images/infomation_button.png" /></a></li>
				<li class="user_nav"><a href="user.jsp"><img
						src="images/profile_button.png" /></a></li>
			</ul>
		</footer>
	</div>
<body>
</html>
