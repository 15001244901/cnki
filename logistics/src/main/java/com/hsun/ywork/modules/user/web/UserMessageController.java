package com.hsun.ywork.modules.user.web;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.entity.UserMessage;
import com.hsun.ywork.modules.user.service.UserMessageService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static oracle.net.aso.C05.e;

/**
 * Created by Administrator on 2017-07-06 .
 */
@Controller
@RequestMapping("/user/message")
public class UserMessageController extends BaseController {

    @Autowired
    private UserMessageService userMessageService;


    /**
     * 查询用户收到的所有历史消息
     * @param userMessage
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping("/list.jhtml")
    @ResponseBody
    public Object list(UserMessage userMessage , HttpServletRequest request , HttpServletResponse response) {
        Map ret = new HashMap();
        try {
            List<UserMessage> data = userMessageService.findList(userMessage);
            if(!CollectionUtils.isEmpty(data)) {
                StringBuffer _ids = new StringBuffer();
                _ids.setLength(0);
                for (UserMessage um : data) {
                    if("1".equals(um.getIsread())) {
                        um.setIsread("0");//请求该接口时就标记消息为已读
                        _ids.append(",'").append(um.getId()).append("'");
                    }
                }
                String ids = _ids.toString().replaceFirst(",", "");
                if(StringUtils.isNotEmpty(ids)) {
                    Map param = new HashMap();
                    param.put("ids", ids);
                    userMessageService.update2Read(param);
                }
            }
            ret.put("data", data);
            ret.put("success", true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success", false);
            ret.put("msg", "系统忙...");
            e.printStackTrace();
        } finally {
            return this.getJSONOrJSONPString(request, ret);
        }
    }

    /**
     * 查询发给当前用户的所有未读私聊消息
     * @param userMessage
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping("/listUnRead.jhtml")
    @ResponseBody
    public Object listUnRead(UserMessage userMessage , HttpServletRequest request , HttpServletResponse response) {
        Map ret = new HashMap();
        try {
            userMessage.setRecieverid(UserUtils.getUser().getId());
            userMessage.setIsread("1");//未读
            userMessage.setMsgtype("3");//私聊
            List<UserMessage> data = userMessageService.findAllList(userMessage);
            ret.put("data", data);
            ret.put("success", true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success", false);
            ret.put("msg", "系统忙...");
            e.printStackTrace();
        } finally {
            return this.getJSONOrJSONPString(request, ret);
        }
    }

    @RequiresPermissions("user")
    @RequestMapping("/send.jhtml")
    @ResponseBody
    public Object send(UserMessage userMessage , HttpServletRequest request) {
        Map ret = new HashMap();
        try {
            userMessage.setIsread("1");//离线消息标记为未读
            userMessageService.save(userMessage);
            ret.put("data",userMessage);
            ret.put("msg", "消息发送成功");
            ret.put("success", true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success", false);
            ret.put("msg", "消息发送失败，请稍后再试...");
            e.printStackTrace();
        } finally {
            return this.getJSONOrJSONPString(request, ret);
        }
    }
}
