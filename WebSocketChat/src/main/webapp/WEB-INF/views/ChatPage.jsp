<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#chatArea{
box-sizing: border-box;
border: 3px solid black;
width: 100%;
height: 100%;
overflow: scroll;
}
.sendM{
text-align: right;
}
.receiveM{
text-align: left;
}
.msgComment{
display: inline-block;
}
</style>
</head>

<body style="background: green">
<h1>CHAT PAGE - ${sessionScope.loginId}</h1>
<input type="text" id="sendMsg" />
<button onclick="sendMsg()">전송</button>
<hr>

<div id="chatArea" style="width: 400px; border: 1px solid black">
<div id="connectMsg" style="text-align: center"></div>

<div id="receiveMsg">
<div class="msgId"></div>

</div>

<div id="sendMsg">
<div class="msgId"></div>

</div>

<div id="disconnectMsg" style="text-align: center"></div>
</div>

</body>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
var sock = new SockJS('chatPage');
sock.onopen = function() {
    console.log('open');
    //sock.send('test');
};

sock.onmessage = function(e) {
    console.log('message', e.data); // {"msgId":"abcd", "msgComm":"ABCD"}
    let msgObj = JSON.parse(e.data);
  //  console.log("msgType: "+msgObj.msgType); 
  //  console.log("msgId: "+msgObj.msgId);
  //  console.log("msgComm: "+msgObj.msgComm);
  //  sock.close();
  
  let mtype = msgObj.msgType;
  switch(mtype){
  case "m":
	  printMessage(msgObj);
	  break;
  case"c":
  case "d":
	  printConnect(msgObj);
	  break;
  }
};

sock.onclose = function() {
    console.log('close');
};
</script>

<script type="text/javascript">
let chatAreaDiv = document.querySelector("#chatArea");
let msgInput = document.querySelector("#sendMsg");

//let msgInputValue = "";

function sendMsg(){
let msgDiv= document.createElement("div");
let sendMsg = document.getElementById("sendMsg");

let createMsg = document.createElement("div");

sock.send(msgInput.value);

console.log(msgInput.value);
//msgInputValue=msgInput.value;

createMsg.classList.add("sendM");
createMsg.innerText = msgInput.value;

msgDiv.appendChild(createMsg);
sendMsg.appendChild(msgDiv);
msgInput.value="";
}
</script>

<script type="text/javascript">
function printConnect(msgObj){
	let connectMsg = document.getElementById("connectMsg");
	let disconnectMsg  = document.getElementById("disconnectMsg");
	let msg = document.createElement("h2");
	if(msgObj.msgType == "c"){
		msg.innerText = msgObj.msgId + " 접속됨";
		connectMsg.appendChild(msg);
	}
	if(msgObj.msgType == "d"){
		msg.innerText = msgObj.msgId + " 접속해제";
		disconnectMsg.appendChild(msg);
	}
}
</script>

<script type="text/javascript">
function printMessage(msgObj){
	let msgDiv= document.createElement("div");
	let receiveMsg = document.getElementById("receiveMsg");
	let msgId =  document.querySelector(".msgId");
	
	let createMsg = document.createElement("div");

	
	createMsg.innerText = msgObj.msgComm;
	createMsg.classList.add("receiveM");
	msgId.innerText = msgObj.msgId;
		
	msgDiv.appendChild(createMsg);
	receiveMsg.appendChild(msgDiv);

}
</script>
</html>