package com.qzx.websocket;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.handler.TextWebSocketHandler;


@Configuration
@EnableWebSocket 
public class WebSocketConfig implements WebSocketConfigurer {

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {  
        //1.ע��WebSocket  
        String websocket_url = "/guidian/websocket/socketServer.do";                        //����websocket�ĵ�ַ  
        registry.addHandler(webSocketHandler(), websocket_url).                          //ע��Handler  
                addInterceptors(new WebSocketHandshakeInterceptor());                   //ע��Interceptor  
  
        //2.ע��SockJS���ṩSockJS֧��(��Ҫ�Ǽ���ie8)  
        String sockjs_url = "/guidian/sockjs/socketServer.do";                              //����sockjs�ĵ�ַ  
        registry.addHandler(webSocketHandler(), sockjs_url).                            //ע��Handler  
                addInterceptors(new WebSocketHandshakeInterceptor()).                   //ע��Interceptor  
                withSockJS();                                                           //֧��sockjsЭ��  
    }  
  
    @Bean
    public TextWebSocketHandler webSocketHandler() {  
        return new WebSocketHandler();  
    } 

}
