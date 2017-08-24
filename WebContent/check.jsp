<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
	String username = (String)session.getAttribute("USERNAME");
	String pass = (String)session.getAttribute("PASS");
	System.out.println(pass);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ユーザー登録</title>
</head>
<body>
	<h1>ユーザー登録画面</h1>
	<form action = "./HackuRegister" method = "get">
		<p>
			ユーザー名：<%=username %><br>パスワード：<%=pass%>
		</p>
		<input type="submit" name = "sb" value = "登録" >
	</form>
</body>
</html>