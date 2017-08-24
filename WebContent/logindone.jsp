<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
	String user_id = (String)session.getAttribute("USER_ID");
	String login = (String)session.getAttribute("login");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ログイン</title>
</head>
<body>
	<h1>ログイン完了</h1>
	<p>ユーザーID:<%=user_id %>  セッションVersion２<%=login %></p>
	<p>ようこそ。</p>
	<form action = "./LoginCheck" method = "get">
		<input type = "submit" name = "sb" value = "ログアウト">
	</form>
</body>
</html>