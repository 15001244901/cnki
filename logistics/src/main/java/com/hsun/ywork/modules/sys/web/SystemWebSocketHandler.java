package com.hsun.ywork.modules.sys.web;

import java.io.IOException;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.hsun.ywork.modules.sys.dao.UserDao;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.entity.UserMessage;
import com.hsun.ywork.modules.user.service.UserMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import javax.servlet.http.HttpSession;

import static oracle.net.aso.C05.e;
import static org.apache.shiro.web.filter.mgt.DefaultFilter.user;
import static org.apache.taglibs.standard.resources.Resources.getMessage;

public class SystemWebSocketHandler implements WebSocketHandler {

    @Autowired
    private UserMessageService userMessageService;

    public static final ArrayList<WebSocketSession> users = new ArrayList<WebSocketSession>();;


    private static int onlineCount = 0; //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。

    public static List list = new ArrayList();   //在线列表,记录用户名称
    public static Map<String,WebSocketSession> routetab = new HashMap<String,WebSocketSession>();  //用户名和websocket的session绑定的路由表

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//        System.out.println("连接已打开...");
        users.add(session);
        User _bizUser = (User)session.getAttributes().get("user");
        if(_bizUser.getId()!=null) {
            if (!list.contains(_bizUser)) {
                list.add(_bizUser);//将用户名加入在线列表
                routetab.put(_bizUser.getId(),session);   //将用户id和session绑定到路由表
            }

            String message = "[" + _bizUser.getName() + "]加入聊天室,当前在线人数为" + getOnlineCount() + "位";//getMessage("[" + username + "]加入聊天室,当前在线人数为"+getOnlineCount()+"位", "notice",  list);

            UserMessage um = new UserMessage();
            um.setMsgtype("1");//代表系统消息
            um.setSenddate(new Date());
            um.setContent(message);
            um.setList(list);
            //系统消息不做数据库存储
//            userMessageService.save(um);
            Gson gson = new Gson();
            sendMessageToUsers(session.getId(), new TextMessage(gson.toJson(um)));
        } else {
            UserMessage um = new UserMessage();
            um.setMsgtype("1");//代表系统消息
            um.setSenddate(new Date());
            um.setContent("会话超时，请重新登录！");
            Gson gson = new Gson();
            sendMessageToUsers(session.getId(), new TextMessage(gson.toJson(um)));
        }
    }
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
//        System.out.println( "ws session id:" + session.getId());
        HttpSession httpSession = (HttpSession)session.getAttributes().get("httpSession");
        String httpSessionId = httpSession.getId();
        User _bizUser = (User)session.getAttributes().get("user");
        if(httpSessionId!=null) {

            JSONObject chat = JSON.parseObject(message.getPayload().toString());
            JSONObject msgData = JSON.parseObject(chat.get("data").toString());

            UserMessage um = new UserMessage();
            um.setSenderid(_bizUser.getId());
            um.setSendername(_bizUser.getName());
            um.setSenddate(new Date());
            um.setContent(msgData.get("content").toString());

            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

            if(msgData.get("msgtype") == null || msgData.get("msgtype").equals("")) {
                if(msgData.get("to") == null || msgData.get("to").equals("")){      //如果to为空,则广播;如果不为空,则对指定的用户发送消息
                    um.setMsgtype("2");//代表群聊消息
                    sendMessageToUsers(session.getId(), new TextMessage(gson.toJson(um)));
                    userMessageService.save(um);
                }else{
                    String [] userlist = msgData.get("to").toString().split(",");
                    //发送给自己,这个别忘了
                    um.setMsgtype("3");//代表私聊消息
                    um.setRecieverid(msgData.get("to").toString());
                    um.setRecievername(msgData.get("toUsername").toString());
                    sendMessageToUser(new TextMessage(gson.toJson(um)),(WebSocketSession)routetab.get(msgData.get("from")));
                    for(String user : userlist){
                        if(!user.equals(msgData.get("from"))){
                            //分别发送给每个指定用户
                            UserMessage um1 = new UserMessage();
                            um1.setMsgtype("3");//代表私聊消息
                            um1.setSenderid(_bizUser.getId());
                            um1.setSendername(_bizUser.getName());
                            um1.setSenddate(new Date());
                            um1.setRecieverid(msgData.get("to").toString());
                            um1.setRecievername(msgData.get("toUsername").toString());
                            um1.setContent(msgData.get("content").toString());
                            sendMessageToUser(new TextMessage(gson.toJson(um1)),(WebSocketSession)routetab.get(user));
                            userMessageService.save(um1);
                        }
                    }
                }
            } else {
                String [] userlist = msgData.get("to").toString().split(",");
                //发送给自己,这个别忘了
                um.setMsgtype("3");//代表私聊消息
                um.setRecieverid(msgData.get("to").toString());
                um.setRecievername(msgData.get("toUsername").toString());
                sendMessageToUser(new TextMessage(gson.toJson(um)),(WebSocketSession)routetab.get(msgData.get("from")));
                for(String user : userlist){
                    if(!user.equals(msgData.get("from"))){
                        //分别发送给每个指定用户
                        UserMessage um1 = new UserMessage();
                        um1.setMsgtype(msgData.get("msgtype").toString());//代表特殊消息，用于处理特殊业务
                        um1.setSenderid(_bizUser.getId());
                        um1.setSendername(_bizUser.getName());
                        um1.setSenddate(new Date());
                        um1.setRecieverid(msgData.get("to").toString());
                        um1.setRecievername(msgData.get("toUsername").toString());
                        um1.setContent(msgData.get("content").toString());
                        sendMessageToUser(new TextMessage(gson.toJson(um1)),(WebSocketSession)routetab.get(user));
                    }
                }
            }
        } else {
            UserMessage um = new UserMessage();
            um.setMsgtype("1");//代表系统消息
            um.setSenddate(new Date());
            um.setContent("会话超时，请重新登录！");
            Gson gson = new Gson();
            //会话超时信息只发给当前发送人
            sendMessageToUser(new TextMessage(gson.toJson(um)),session);
        }
    }

    @Autowired
    private UserDao userDao;

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {

        subOnlineCount();
        for(Map.Entry<String,WebSocketSession> e :routetab.entrySet()) {
            if (e.getValue().getId().equals(session.getId())) {
                User _bizUser = userDao.get(e.getKey());
                list.remove(_bizUser);        //从在线列表移除这个用户
                routetab.remove(e.getKey());
                String message = "[" + _bizUser.getName() + "]离开了聊天室,当前在线人数为" + getOnlineCount() + "位";
                UserMessage um = new UserMessage();
                um.setMsgtype("1");//代表系统消息
                um.setSenddate(new Date());
                um.setContent(message);
                um.setList(list);
                //系统消息不做数据库存储
//                userMessageService.save(um);

                Gson gson = new Gson();
                sendMessageToUsers(session.getId(), new TextMessage(gson.toJson(um)));
            }
        }

        if(session.isOpen()){
            session.close();
        }
        users.remove(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        subOnlineCount();
        users.remove(session);
        for(Map.Entry<String,WebSocketSession> e :routetab.entrySet()){
            if(e.getValue().getId().equals(session.getId())) {
                User _bizUser = userDao.get(e.getKey());
                if(_bizUser!=null&&_bizUser.getId() != null) {
                    list.remove(_bizUser);        //从在线列表移除这个用户
                    routetab.remove(e.getKey());
                    String message = "[" + _bizUser.getName() + "]离开了聊天室,当前在线人数为" + getOnlineCount() + "位";
                    UserMessage um = new UserMessage();
                    um.setMsgtype("1");//代表系统消息
                    um.setSenddate(new Date());
                    um.setContent(message);
                    um.setList(list);

                    //系统消息不做数据库存储
//                    userMessageService.save(um);

                    Gson gson = new Gson();
                    sendMessageToUsers(session.getId(), new TextMessage(gson.toJson(um)));
                } else {
                    UserMessage um = new UserMessage();
                    um.setMsgtype("1");//代表系统消息
                    um.setSenddate(new Date());
                    um.setContent("会话超时，请重新登录！");
                    Gson gson = new Gson();
                    sendMessageToUsers(session.getId(), new TextMessage(gson.toJson(um)));
                }
                routetab.remove(e.getKey());
                break;
            }

        }
    }
    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 给所有在线用户发送消息 
     * @param message
     */
    public void sendMessageToUsers(String excep, TextMessage message) {
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
     * 给所有指定用户发送消息
     * @param message
     */
    public void sendMessageToUser(TextMessage message , WebSocketSession toUser) {
        try {
            if (toUser.isOpen()) {
                toUser.sendMessage(message);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public  int getOnlineCount() {
        if(list!=null)
            return list.size();
        return 0;
    }

    public  void addOnlineCount() {
        SystemWebSocketHandler.onlineCount++;
    }

    public  void subOnlineCount() {
        if(onlineCount!=0)
            SystemWebSocketHandler.onlineCount--;
    }
}  
