<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf=8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>index</title>
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/top_design.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
</head>
<body style="background-color:#fff;">
	<div id="top_page_wrapper">
		<!-- ヘッダー -->
		<header>
			<div id="logo">
				<img src="images/logo.png" />
			</div>
		</header>
		<div id="background">
			<section></section>
			<article>
				<div class="login">
				  <form class="login-container" action = "./LoginServlet"  method = "post">
				    <p><input type = "text" name ="username"  placeholder="UserName"></p>
				    <p><input type="password" name="pass" placeholder="Password"></p>
				    <p><input type="submit" name ="sb" value="Log in"></p>
				  </form>
				</div>
			</article>

		</div>
	</div>
</body>
</html>