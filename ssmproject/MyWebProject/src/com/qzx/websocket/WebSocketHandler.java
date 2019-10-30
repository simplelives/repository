package com.qzx.websocket;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketHandler extends TextWebSocketHandler {

	// �ѽ������ӵ��û�
		private static final ArrayList<WebSocketSession> users = new ArrayList<WebSocketSession>();
	 
		/**
		 * ����ǰ�˷��͵��ı���Ϣ js����websocket.sendʱ�򣬻���ø÷���
		 * 
		 * @param session
		 * @param message
		 * @throws Exception
		 */
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			String username = (String) session.getAttributes().get("WEBSOCKET_USERNAME");
	 
			// ��ȡ�ύ��������Ϣ����
			System.out.println("�յ��û� " + username + " ����Ϣ:" + message.toString());
			// �ָ��id����Ϣ����
			String[] messageInfo = message.getPayload().split("@");
			if (messageInfo.length!=2) {
				sendMessageToUser(username, new TextMessage("500@�������������Ժ��ٷ��Ͱ�"));
			} else {
				String target = messageInfo[0];
				String content = messageInfo[1];
				// ���������������û�
				for (WebSocketSession user : users) {
					if (user.getAttributes().get("WEBSOCKET_USERNAME").equals(target)) {
						//����ƥ���û� ��������������Ϣ
						if (user.isOpen()) {
							sendMessageToUser(target, new TextMessage(username+":"+content));
						}else{//���쳣����ʧ��
							sendMessageToUser(username, new TextMessage("404@�Է������쳣,����ʧ��"));
						}
						return;
					}
				}
				//δ�ҵ�ƥ���û� ����ʧ��
				sendMessageToUser(username, new TextMessage("404@�Է���ʱ������"));
			}
		}
	 
		/**
		 * �������ӽ�����ʱ�򣬱����� ���ӳɹ�ʱ�򣬻ᴥ��ҳ����onOpen����
		 * 
		 * @param session
		 * @throws Exception
		 */
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			users.add(session);
			String username = (String) session.getAttributes().get("WEBSOCKET_USERNAME");
			System.out.println("�û� " + username + " Connection Established");
			session.sendMessage(new TextMessage(username + " connect"));
		}
	 
		/**
		 * �����ӹر�ʱ������
		 * 
		 * @param session
		 * @param status
		 * @throws Exception
		 */
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			String username = (String) session.getAttributes().get("WEBSOCKET_USERNAME");
			System.out.println("�û� " + username + " Connection closed. Status: " + status);
			users.remove(session);
		}
	 
		/**
		 * �������ʱ����
		 * 
		 * @param session
		 * @param exception
		 * @throws Exception
		 */
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			String username = (String) session.getAttributes().get("WEBSOCKET_USERNAME");
			if (session.isOpen()) {
				session.close();
			}
			System.out.println("�û�: " + username + " websocket connection closed......");
			users.remove(session);
		}
	 
		/**
		 * �����������û�������Ϣ
		 * 
		 * @param message
		 */
		public void sendMessageToUsers(TextMessage message) {
			for (WebSocketSession user : users) {
				try {
					if (user.isOpen()) {
						user.sendMessage(message);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	 
		/**
		 * ��ĳ���û�������Ϣ
		 * 
		 * @param userName
		 * @param message
		 */
		public void sendMessageToUser(String userName, TextMessage message) {
			for (WebSocketSession user : users) {
				if (user.getAttributes().get("WEBSOCKET_USERNAME").equals(userName)) {
					try {
						if (user.isOpen()) {
							user.sendMessage(message);
						}
					} catch (IOException e) {
						e.printStackTrace();
					}
					break;
				}
			}
		}

}
