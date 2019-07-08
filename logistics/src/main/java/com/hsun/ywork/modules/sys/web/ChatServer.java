package com.hsun.ywork.modules.sys.web;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.hsun.ywork.modules.sys.dao.UserDao;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.user.entity.UserMessage;
import com.hsun.ywork.modules.user.service.UserMessageService;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.*;

@ServerEndpoint(value="/webSocketServer.do",configurator = WebSocketConfigurator.class)
public class ChatServer {

	public static final ArrayList<Session> users = new ArrayList<Session>();;


	private static int onlineCount = 0; //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。

	public static List list = new ArrayList();   //在线列表,记录用户名称
	public static Map<String,List<Session>> routetab = new HashMap<String,List<Session>>();  //用户名和websocket的session绑定的路由表

	/**
	 * 用户接入
	 * @param session 可选
	 */
	@OnOpen
	public void onOpen(Session session,EndpointConfig config){

		users.add(session);
		User _bizUser = (User)config.getUserProperties().get("user");
		if(_bizUser.getId()!=null) {
			if (!list.contains(_bizUser)) {
				list.add(_bizUser);//将用户名加入在线列表
			}
			List<Session> sList = routetab.get(_bizUser.getId());
			if(sList==null||sList.size()==0)
				sList = new ArrayList<Session>();
			sList.add(session);
			routetab.put(_bizUser.getId(),sList);//将用户id和session绑定到路由表

			String message = "[" + _bizUser.getName() + "]加入聊天室,当前在线人数为" + getOnlineCount() + "位";//getMessage("[" + username + "]加入聊天室,当前在线人数为"+getOnlineCount()+"位", "notice",  list);

			UserMessage um = new UserMessage();
			um.setMsgtype("1");//代表系统消息
			um.setSenddate(new Date());
			um.setContent(message);
			um.setList(list);
			//系统消息不做数据库存储
//            userMessageService.save(um);
			Gson gson = new Gson();
			sendMessageToUsers(session.getId(), gson.toJson(um));
		} else {
			UserMessage um = new UserMessage();
			um.setMsgtype("1");//代表系统消息
			um.setSenddate(new Date());
			um.setContent("会话超时，请重新登录！");
			Gson gson = new Gson();
			sendMessageToUsers(session.getId(), gson.toJson(um));
		}
	}

	/**
	 * 接收到来自用户的消息
	 * @param message
	 * @param session
	 */
	@OnMessage
	public void onMessage(String message,Session session) throws Exception{


		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		UserMessageService userMessageService = (UserMessageService)wac.getBean("userMessageService");

		HttpSession httpSession = (HttpSession)session.getUserProperties().get("httpSession");
		String httpSessionId = httpSession.getId();
		User _bizUser = (User)session.getUserProperties().get("user");
		if(httpSessionId!=null) {

			JSONObject chat = JSON.parseObject(message);
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
					sendMessageToUsers(session.getId(), gson.toJson(um));
					userMessageService.save(um);
				}else{
					String [] userlist = msgData.get("to").toString().split(",");
					//发送给自己,这个别忘了
					um.setMsgtype("3");//代表私聊消息
					um.setRecieverid(msgData.get("to").toString());
					um.setRecievername(msgData.get("toUsername").toString());
					for(Session s : routetab.get(msgData.get("from"))) {
						sendMessageToUser(gson.toJson(um), s);
					}
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
							for(Session s : routetab.get(user)) {
								sendMessageToUser(gson.toJson(um1), s);
							}
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
				for(Session s : routetab.get(msgData.get("from"))) {
					sendMessageToUser(gson.toJson(um), s);
				}
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
						for(Session s : routetab.get(user)) {
							sendMessageToUser(gson.toJson(um1), s);
						}
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
			sendMessageToUser(gson.toJson(um),session);
		}
	}

	/**
	 * 用户断开
	 * @param session
	 */
	@OnClose
	public void onClose(Session session){
		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		UserDao userDao = (UserDao)wac.getBean("userDao");

		subOnlineCount();
		users.remove(session);
		for(Map.Entry<String,List<Session>> e :routetab.entrySet()){
			for(Session s : e.getValue()) {
				if(s.getId().equals(session.getId())) {
					User _bizUser = userDao.get(e.getKey());
					if(_bizUser!=null&&_bizUser.getId() != null) {

                        e.getValue().remove(s);
                        if(e.getValue().size()==0) {
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
							sendMessageToUsers(session.getId(), gson.toJson(um));
						}
					} else {
						UserMessage um = new UserMessage();
						um.setMsgtype("1");//代表系统消息
						um.setSenddate(new Date());
						um.setContent("会话超时，请重新登录！");
						Gson gson = new Gson();
						sendMessageToUsers(session.getId(), gson.toJson(um));
					}

//                    routetab.remove(e.getKey());
					break;
				}
			}
		}
	}

	/**
	 * 用户连接异常
	 * @param t
	 */
	@OnError
	public void onError(Session session , Throwable t) {
		try {
			WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
			UserDao userDao = (UserDao)wac.getBean("userDao");
			subOnlineCount();
			for(Map.Entry<String,List<Session>> e :routetab.entrySet()) {
				for(Session s : e.getValue()) {
					if (s.getId().equals(session.getId())) {
						User _bizUser = userDao.get(e.getKey());

                        e.getValue().remove(s);
                        if(e.getValue().size()==0) {
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
							sendMessageToUsers(session.getId(), gson.toJson(um));
						}
					}
				}
			}

			if(session.isOpen()){
				session.close();
			}
			users.remove(session);
		} catch (Exception e) {
			// TODO: 2017-08-01 异常断开简单异常处理，将来完善
		}
	}

	/**
	 * 给所有在线用户发送消息
	 * @param message
	 */
	public void sendMessageToUsers(String excep, String message) {
		for (Session user : users) {
			if (user.isOpen()) {
				user.getAsyncRemote().sendText(message);
			}
		}
	}

	/**
	 * 给所有指定用户发送消息
	 * @param message
	 */
	public void sendMessageToUser(String message , Session toUser) {
		if (toUser.isOpen()) {
			toUser.getAsyncRemote().sendText(message);
		}
	}

	public  int getOnlineCount() {
		if(list!=null)
			return list.size();
		return 0;
	}

	public  void addOnlineCount() {
		onlineCount++;
	}

	public  void subOnlineCount() {
		if(onlineCount!=0)
			onlineCount--;
	}
}
