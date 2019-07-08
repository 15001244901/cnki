package com.hsun.ywork.modules.sys.web;

import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.sys.entity.Office;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.service.OfficeService;
import com.hsun.ywork.modules.sys.service.SystemService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017-04-18 .
 */
//@Controller
//@RequestMapping(value = "${studyPath}")
public class WebController extends BaseController{

    @Autowired
    private SystemService systemService;

    @Autowired
    private OfficeService officeService;

    /**
     * 系统首页
     */
    @RequestMapping
    public String index(Model model) {
//        return "modules/front/library/knowledge_library";
        return "modules/front/index";
    }

    /**
     * 跳转前台登录页面
     * @return
     */
    @RequestMapping(value = "/frontlogin",method = RequestMethod.GET)
    public String login(){
        return "modules/user/auth/frontlogin";
    }

    /**
     * 跳转前台企业注册页面
     * @return
     */
    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String register() {
        return "modules/user/auth/register";
    }

    //--------------- 前端企业用户注册接口 ------------------
    @RequestMapping(value = "register",method = RequestMethod.POST)
    @ResponseBody
    public Object register(User user, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        Map ret = new HashMap();
        try {
            if(!checkCompanyName(user.getCompany().getName())) {
                ret.put("success", false);
                ret.put("msg", "注册失败，单位名称 " + user.getCompany().getName() + " 已存在");
            } else {
                if (!"true".equals(checkLoginName(user.getOldLoginName(), user.getLoginName()))) {
                    ret.put("success", false);
                    ret.put("msg", "注册失败，用户 " + user.getLoginName() + " 已存在");
                } else {
                    systemService.registerUser(user);
                    ret.put("data", user);
                    ret.put("userRoles",user.getRoleList());
                    ret.put("msg", "注册成功！");
                    ret.put("success", true);
                    // TODO: 2017-04-20  注册后直接登录，需研究shiro机制
                    ret.put("returnURL", "http://www.fyketang.com");
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success", false);
            ret.put("msg", "注册失败，请重新注册！");
            e.printStackTrace();
        } finally {
            return this.getJSONOrJSONPString(request, ret);
        }
    }

    /**
     * 验证登录名是否有效
     * @param oldLoginName
     * @param loginName
     * @return
     */
    @ResponseBody
    @RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "checkLoginName")
    public String checkLoginName(String oldLoginName, String loginName) {
        if (loginName !=null && loginName.equals(oldLoginName)) {
            return "true";
        } else if (loginName !=null && systemService.getUserByLoginName(loginName) == null) {
            return "true";
        }
        return "false";
    }

    private boolean checkCompanyName(String companyName) {
        Office company = new Office();
        company.setName(companyName);
        return officeService.getByName(company)==null;
    }

    @ResponseBody
    @RequestMapping("/validateUser.jhtml")
    public Object getUserId(HttpServletRequest request){
        Map ret = new HashMap();
        try {
            String uid = UserUtils.getUser().getId();
            ret.put("data", uid);// TODO: 将null替换为业务数据
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

    @RequestMapping("page/**/*.html")
    public String header(HttpServletRequest request){
        String url = request.getRequestURL().toString().split("/page/")[1].replace(".html","");
        return "modules/front/"+url;
    }

    @RequiresPermissions("user")
    @RequestMapping("front/talkView.html")
    public String talkView() {
        return "modules/front/talkView";
    }


    @RequiresPermissions("user")
    @RequestMapping("impage")
    public String impage() {
        return "modules/sys/impage";
    }

    @RequestMapping("error/{errorCode}.html")
    public String error403(@PathVariable String errorCode){
        return "error/"+errorCode;
    }
}
