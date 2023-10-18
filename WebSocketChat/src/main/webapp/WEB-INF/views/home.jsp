<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
<style type="text/css">
#chatArea{
border: 2px solid black;
width: 500px;
padding: 10px;
}

.receiveMsg{
text-align: right;
margin-bottom: 5px;
}

.sendMsg{
text-align: left;
margin-bottom: 5px;
}
</style>	
</head>



<body style="background: green">

<input type="text" id="sendMsg" />
<button onclick="msgSend()">전송</button>
<hr>
<div id="chatArea">

</div>

</body>



<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">

var sock = new SockJS('chatSocket');
sock.onopen = function() { // onopen: 접속
    console.log('open');
    //sock.send('test'); // 서버로 메세지 전송
};

sock.onmessage = function(e) { // onmessage: 서버에서 클라이언트
    console.log('받은 메세지: ', e.data);

	let receiveMsgDiv = document.createElement("div");
	// sock.close();
	receiveMsgDiv.classList.add("receiveMsg");
	receiveMsgDiv.innerText=e.data;
	chatAreaDiv.appendChild(receiveMsgDiv);

};

sock.onclose = function() { // onclose: 접속 종료
    console.log('close');
};
</script>

<script type="text/javascript">
let chatAreaDiv = document.querySelector("#chatArea");

function msgSend(){
let msgInput = document.querySelector("#sendMsg");	
console.log("보낸 메세지: ", msgInput.value);
sock.send(msgInput.value);

let sendDiv = document.createElement("div");
sendDiv.classList.add("sendMsg");
sendDiv.innerText=msgInput.value;

chatAreaDiv.appendChild(sendDiv);

msgInput.value="";
}
</script>


</html>
