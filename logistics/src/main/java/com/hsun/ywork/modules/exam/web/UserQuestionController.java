package com.hsun.ywork.modules.exam.web;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.exam.entity.Question;
import com.hsun.ywork.modules.exam.entity.QuestionVO;
import com.hsun.ywork.modules.exam.service.QuestionService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.entity.UserQuestion;
import com.hsun.ywork.modules.user.service.UserQuestionService;
import com.thoughtworks.xstream.XStream;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.sun.tools.javac.jvm.ByteCodes.ret;
import static oracle.net.aso.C01.u;
import static oracle.net.aso.C05.e;

/**
 * 用户收藏试题记录、错题记录
 * Created by Administrator on 2017-03-30 .
 */
@Controller
@RequestMapping("/user/question")
public class UserQuestionController extends BaseController {

    @Autowired
    private QuestionService questionService;
    @Autowired
    private UserQuestionService userQuestionService;

    /**
     * 试题收藏接口
     * @param id
     * @param request
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("{id}/collect.jhtml")
    public Object collect(@PathVariable String id , HttpServletRequest request){
        Map ret = new HashMap();
        try {
            String uid = UserUtils.getUser().getId();
            String uqid = request.getParameter("iscollected");//用户试题收藏记录id
            UserQuestion uq = new UserQuestion();
            uq.setQid(id);
            uq.setUid(uid);
            uq.setDtype(1);
            uq.setWtype(0);
            ret.put("success",true);
            if(StringUtils.isEmpty(uqid)||"0".equals(uqid)) {
                userQuestionService.save(uq);
                ret.put("msg","收藏成功！");
            } else {
                uq.setId(uqid);
                userQuestionService.delete(uq);
                ret.put("msg","取消收藏成功！");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
            e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

    /**
     * 试题收藏列表接口
     * @param question
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("favorite.jhtml")
    public Object userFavoriteList(Question question , HttpServletRequest request , HttpServletResponse response) {
        Map ret = new HashMap();
        try {
            UserQuestion uq = new UserQuestion();
            uq.setUid(UserUtils.getUser().getId());
            uq.setDtype(1);//1代表收藏记录
            question.setUserQuestion(uq);
            Page<QuestionVO> page = questionService.findUserQuestionPage(new Page<Question>(request, response), question);
            ret.put("data",page);
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("msg","系统忙...");
            ret.put("success",false);
            e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

    /**
     * 试题纠错列表接口
     * @param question
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("wrong.jhtml")
    public Object userWrongList(Question question , HttpServletRequest request , HttpServletResponse response) {
        Map ret = new HashMap();
        try {
            UserQuestion uq = new UserQuestion();
            uq.setUid(UserUtils.getUser().getId());
            uq.setWtype(1);//wtype=1代表错题记录，包括练习和考试两种数据来源(dtype=2,3)
            question.setUserQuestion(uq);
            Page<QuestionVO> page = questionService.findUserQuestionPage(new Page<Question>(request, response), question);
            ret.put("data",page);
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("msg","系统忙...");
            ret.put("success",false);
            e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

    /**
     * 试题篮数据查询接口
     * @param question
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("basketList.jhtml")
    public Object basketList(Question question , HttpServletRequest request , HttpServletResponse response) {
        Map ret = new HashMap();
        try {
            UserQuestion uq = new UserQuestion();
            uq.setUid(UserUtils.getUser().getId());
            uq.setDtype(5);//dtype=5代表试题篮数据
            question.setUserQuestion(uq);
            Page<QuestionVO> page = questionService.findUserQuestionPage(new Page<Question>(request, response), question);
            ret.put("data",page);
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("msg","系统忙...");
            ret.put("success",false);
            e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

    /**
     * 试题篮数据统计接口
     * @param question
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("basketCount.jhtml")
    public Object basketCount(Question question , HttpServletRequest request , HttpServletResponse response) {
        Map ret = new HashMap();
        try {
            String uid = UserUtils.getUser().getId();
            List list = userQuestionService.countQuestionBasket(uid);
            UserQuestion uq = new UserQuestion();
            uq.setUid(uid);
            uq.setDtype(5);//查询用户试题篮明细
            ret.put("data",list);
            ret.put("basketList",userQuestionService.findList(uq));
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("msg","系统忙...");
            ret.put("success",false);
            e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

    /**
     * 试题篮数据保存接口
     * @param id
     * @param request
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("{id}/basket.jhtml")
    public Object basket(@PathVariable String id , HttpServletRequest request){
        Map ret = new HashMap();
        try {
            String isbasket = request.getParameter("isbasket");
            String qtype = request.getParameter("qtype");
            String uid = UserUtils.getUser().getId();
            UserQuestion uq = new UserQuestion();
            uq.setQid(id);
            uq.setUid(uid);
            uq.setDtype(5);
            uq.setWtype(0);
            uq.setQtype(qtype);

            if("0".equals(isbasket)||isbasket==null) {
                userQuestionService.save(uq);
                ret.put("msg","加入试题篮成功！");
            } else {
                uq.setId(isbasket);
                userQuestionService.delete(uq);
                ret.put("msg","从试题篮移除成功！");
            }
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
            e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

    /**
     * 试题篮数据保存接口
     * @param qtype
     * @param request
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("{qtype}/basketDel.jhtml")
    public Object basketDel(@PathVariable String qtype , HttpServletRequest request){
        Map ret = new HashMap();
        try {
            String uid = UserUtils.getUser().getId();
            UserQuestion uq = new UserQuestion();
            uq.setUid(uid);
            uq.setQtype(qtype);
            userQuestionService.deleteByUidAndQtype(uq);
            ret.put("msg","从试题篮移除成功！");
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
            e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

    @RequiresPermissions("user")
    @RequestMapping("delete.jhtml")
    @ResponseBody
    public Object delete(UserQuestion uq , HttpServletRequest request) {
        Map ret = new HashMap();
        try {
            userQuestionService.delete(uq);
            ret.put("msg", "错题移除成功！");
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
