<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body style="background: green">
<h1>MAIN PAGE</h1>
<button>채팅페이지 1</button>
<button onclick="chatPage2()">채팅페이지 2</button>
</body>

<script type="text/javascript">
function chatPage2(){
	let chatId = prompt("사용자 이름 잉력");
	console.log(chatId);
	location.href="chatPage2?chatid="+chatId;
}
</script>
</html>