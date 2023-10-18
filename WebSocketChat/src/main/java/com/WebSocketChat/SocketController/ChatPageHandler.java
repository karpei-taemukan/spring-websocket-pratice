package com.WebSocketChat.SocketController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatPageHandler extends TextWebSocketHandler {

	private ArrayList<WebSocketSession> conClientList =  new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅 페이지 접속");
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String)sessionAttrs.get("loginId");
		Gson gson = new Gson();
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		
		msgInfo.put("msgType", "c");
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", "접속함");
		
		for(WebSocketSession client : conClientList) {
			// 새 참여자 
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
		conClientList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("채팅 메세지 전송(서버 -> 클라이언트)");
		System.out.println("전송한 메세지: "+message.getPayload());
		
		Map<String, Object> sessionAttrs = session.getAttributes();
		System.out.println("Map 전: "+session);
		System.out.println("Map 후"+sessionAttrs);
		//WebSocketSession에서 getID()를 사용하면 임의로 부여된 사용자ID 정보가 찍힌다
		// HttpSession이랑 WebSocketSession의 구조가 다름 변환 필요
		String loginId = (String)sessionAttrs.get("loginId");
		System.out.println("보내는 아이디: "+loginId);
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgType", "m");
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", message.getPayload());
		
		for(WebSocketSession client : conClientList) {
	//System.out.println("client: "+client); == System.out.println("session: "+session);
			
	//		System.out.println("conClientList: "+ conClientList); 
			if(!client.getId().equals(session.getId())) {
			
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
				// {msgid: abcd, msgcomm:1234} 
				
			} 
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅 페이지 접속해제");
		conClientList.remove(session);
		
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String)sessionAttrs.get("loginId");
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgType", "d");
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", "접속 해제");
		
		for(WebSocketSession client : conClientList) {
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
	}
}
