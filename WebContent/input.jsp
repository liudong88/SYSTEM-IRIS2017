<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String Errormessage = (String)request.getAttribute("MESSAGE");
	if(Errormessage == null){
		Errormessage = "";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ユーザー登録</title>
</head>
<body>
	<h1>ユーザー登録画面</h1>
	<form action = "./HakcuUser" method = "get">
		ユーザー名<input type = "text" name = username><br>
		パスワード<input type = "text" name = pass><br>
		<input type = "submit" name = "sb" value = "確認">
	</form>
	<p><font color = "red"><%=Errormessage %></font></p>
</body>
</html>