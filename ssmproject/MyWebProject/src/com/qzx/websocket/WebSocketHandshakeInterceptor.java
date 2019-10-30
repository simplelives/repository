package com.qzx.websocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

public class WebSocketHandshakeInterceptor implements HandshakeInterceptor {

	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Map<String, Object> attributes) throws Exception {  
		 
    	if (request instanceof ServletServerHttpRequest) {
    		ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;  
            HttpSession session = servletRequest.getServletRequest().getSession(false);  
            if (session != null) {  
                String userName = (String) session.getAttribute("SESSION_USERNAME");  //��߻�õ�¼ʱ���õ�Ψһ�û���ʶ
                if (userName == null) {  
                    userName = "δ֪" + session.getId();  
                }  
                attributes.put("WEBSOCKET_USERNAME", userName);  //���û���ʶ��������б����һ����websocket���������Զ�ȡ�����������
            }  
        }  
        return true;  
    }  
  
    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {  
        System.out.println("After Handshake");  
    }


}
