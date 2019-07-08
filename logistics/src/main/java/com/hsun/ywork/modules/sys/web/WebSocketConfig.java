package com.hsun.ywork.modules.sys.web;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

// TODO 为方便jetty调试暂时关闭websocket相关模块
//@Configuration
//@EnableWebMvc
//@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements
        WebSocketConfigurer {
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(systemWebSocketHandler(), "/springWebSocketServer.do").addInterceptors(new MyHandshakeInterceptor());
        registry.addHandler(systemWebSocketHandler(), "/sockjs/springWebSocketServer.do").addInterceptors(new MyHandshakeInterceptor())
                .withSockJS();
    }
    @Bean
    public WebSocketHandler systemWebSocketHandler() {
        return new SystemWebSocketHandler();
    }
}
