package com.hsun.ywork.modules.sys.web;

/**
 * Created by Administrator on 2017-07-31 .
 */
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.utils.UserUtils;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;
/*
 * 获取HttpSession
 *
 */

public class WebSocketConfigurator extends Configurator {

    @Override
    public void modifyHandshake(ServerEndpointConfig sec,
                                HandshakeRequest request, HandshakeResponse response) {
        HttpSession httpSession=(HttpSession) request.getHttpSession();
        User u = UserUtils.getUser();
        if(StringUtils.isNotEmpty(u.getId())) {
            sec.getUserProperties().put("httpSession", httpSession);
            sec.getUserProperties().put("user", u);
        } else {
            sec.getUserProperties().remove("httpSession");
            sec.getUserProperties().remove("user");
        }
    }

}
