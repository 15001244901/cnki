package com.hsun.ywork.modules.sys.web;

import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

import static oracle.net.aso.C01.u;

@Component
public class MyHandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request,
                                   ServerHttpResponse response, WebSocketHandler handler,
                                   Map map) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession(false);
            User u = UserUtils.getUser();
            if (u.getId()!=null) {
//                System.out.println("ok");
                map.put("httpSession",session);
                map.put("user", u);
            } else {
                map.remove("httpSession");
                map.remove("user");
//                return false;
            }
        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request,
                               ServerHttpResponse response, WebSocketHandler wsHandler,
                               Exception ex) {
//        System.out.println("afterHandshake!");
    }
}
