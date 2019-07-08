package com.hsun.ywork.modules.user.web;

import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.sys.entity.Role;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.service.MyTeamService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

import static com.sun.tools.javac.jvm.ByteCodes.ret;
import static oracle.net.aso.C01.t;

/**
 * @Author: GeCoder
 * @Description: TODO
 * @Date: 14:34 2018-01-25
 * @ModifyBy: GeCoder
 */
@Controller
@RequestMapping("/user/team")
public class MyTeamController extends BaseController {

    @Autowired
    MyTeamService myTeamService;

    /**
     * 前端我的团队数据统计(必须有管理员或者领导监管的角色)
     * @param request
     * @return
     */
    @RequiresPermissions("sys:team:admin")
    @RequestMapping("/countList.jhtml")
    @ResponseBody
    public Object countList(HttpServletRequest request) {
        Map ret = new HashMap();
        try {
            boolean JGLD = false;
            User manager = UserUtils.getUser();
            Map param = new HashMap();
            for(Object o : request.getParameterMap().keySet()) {
                param.put(o.toString(),request.getParameter(o.toString()));
            }

            manager.setParam(param);

            ret.put("DTB", myTeamService.countDTB(manager));
            ret.put("HYB", myTeamService.countHYB(manager));
            ret.put("QFB", myTeamService.countQFB(manager));

            // 数据权限是否为公司及以下数据
            for(Role role : manager.getRoleList()) {
                if(Role.DATA_SCOPE_COMPANY_AND_CHILD.equals(role.getDataScope()))
                    JGLD = true;
            }
            ret.put("JGLD",JGLD);
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
}
