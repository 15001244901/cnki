package com.hsun.ywork.modules.exam.web;

import com.hsun.ywork.common.bean.BaseMessage;
import com.hsun.ywork.common.bean.BaseUrl;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.DateUtils;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.exam.entity.ExamHistory;
import com.hsun.ywork.modules.exam.entity.Paper;
import com.hsun.ywork.modules.exam.entity.PaperSection;
import com.hsun.ywork.modules.exam.service.ExamHistoryService;
import com.hsun.ywork.modules.exam.service.PaperService;
import com.hsun.ywork.modules.exam.service.UserPaperService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Created by GeCoderon 2017-03-06 .
 */
@Controller
@RequestMapping(value="/user/paper")
public class UserPaperController extends BaseController{

    @Autowired private UserPaperService userPaperService;
    @Autowired private PaperService paperService;
    @Autowired private ExamHistoryService examHistoryService;

    @RequiresPermissions("user")
    @RequestMapping("list")
    public String list(Paper paper , HttpServletRequest request , HttpServletResponse response , Model model){
//        this.getUserIP(request);//todo 测试获取ip地址，及时清理此代码
        Map ret = (Map)this.list(paper,request,response);
        if(((Boolean)ret.get("success"))) {
            model.addAttribute("page",ret.get("data"));
            return "modules/user/paper/list";
        } else {
            BaseMessage message = new BaseMessage();
            message.setSuccess(false);
            message.setMessage("系统忙...");
            model.addAttribute("message",message);
            return "common/message";
        }
    }

    @RequiresPermissions("user")
    @RequestMapping("startExam")
    public String startExam(HttpServletRequest request, Model model){
        Map ret = (Map)this.startExam(request);
        if(((Boolean)ret.get("success"))) {
            Paper paper = (Paper)ret.get("data");
            model.addAttribute("paper", paper);
            String viewPage = paper.getShowmode()==2?"paper_detail_singlemode":"paper_detail";
            return "modules/user/paper/"+viewPage;
        } else {
            BaseMessage message = new BaseMessage();
            message.addUrl(new BaseUrl("我的试卷", "user/paper/list"));
            message.addUrl(new BaseUrl("考试历史", "user/paper/history"));
            message.setSuccess(false);
            message.setMessage(ret.get("msg").toString());
            model.addAttribute("message",message);
            return "common/message";
        }
    }

    /**
     * 后端-用户考试记录
     * @param examHistory
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping("history")
    public String history(ExamHistory examHistory , HttpServletRequest request , HttpServletResponse response , Model model){
        Map ret = (Map)this.history(examHistory,request,response);
        if(((Boolean)ret.get("success"))) {
            model.addAttribute("page",ret.get("data"));
            return "modules/user/paper/history";
        } else {
            BaseMessage message = new BaseMessage();
            message.setSuccess(false);
            message.setMessage("系统忙...");
            model.addAttribute("message",message);
            return "common/message";
        }
    }

    /**
     * 后端用户考试记录详情
     * @param param
     * @param request
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping("history_detail")
    public String historyDetail(ExamHistory param , HttpServletRequest request , Model model){
        Map ret = (Map)this.historyDetail(param,request);
        if(((Boolean)ret.get("success"))) {
            model.addAttribute("detail",ret.get("detail"));
            model.addAttribute("paper_basic",ret.get("paper_basic"));
            model.addAttribute("paper",ret.get("paper"));
            model.addAttribute("data",ret.get("data"));
            model.addAttribute("check",ret.get("check"));
            return "modules/user/paper/history_detail";
        } else {
            BaseMessage message = new BaseMessage();
            message.setSuccess(false);
            message.setMessage("系统忙...");
            model.addAttribute("message",message);
            return "common/message";
        }
    }

    /**
     * 个人考试记录明细接口
     * @param param
     * @param request
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("history_detail.jhtml")
    public Object historyDetail(ExamHistory param , HttpServletRequest request){
        Map ret = new HashMap();
        try {
            //param中的数据id,pid从前台传入
            param.setUid(UserUtils.getUser().getId());//后台获取当前登录人id
            param.setStatus("2");//必须查询已经批改完的结果
            ExamHistory detail = this.examHistoryService.get(param);
            ret.put("detail",detail);
            ret.put("paper_basic",this.paperService.getPaper(param.getPid()));
            ret.put("paper",this.paperService.getPaper(param.getUid(),param.getPid()));
            // TODO: 2017-03-14   个人收藏夹分类
            // ret.put("categories", this.userCollectionService.getAllCollectionType(uid))

            ret.put("data", JSONObject.fromObject(detail.getData()));
            ret.put("check", JSONObject.fromObject(detail.getChecks()));
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
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

    //-------------------前端接口部分--------------------

    /**
     * 前端接口-用户考试记录
     * @param param
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("history.jhtml")
    public Object history(ExamHistory param , HttpServletRequest request , HttpServletResponse response){
        Map ret = new HashMap();
        try {
            param.setUid(UserUtils.getUser().getId());
            ret.put("data",this.examHistoryService.findUserHistoryPage(new Page<ExamHistory>(request,response),param));
            ret.put("success",true);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
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
     * 个人待考试卷列表
     * @param paper
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("list.jhtml")
    public Object list(Paper paper , HttpServletRequest request , HttpServletResponse response){
        Map ret = new HashMap();
        try {
            String ouid = UserUtils.getUser().getOffice().getId();
            String uid = UserUtils.getUser().getId();
            Map opt = new HashMap();
            opt.put("uid",uid);
            opt.put("ouid",ouid);
            opt.put("isExpired",request.getParameter("isExpired"));
            paper.setOpt(opt);
            ret.put("data",userPaperService.findPage(new Page<Paper>(request,response),paper));
            ret.put("nowDate", DateUtils.formatDate(new Date(),"yyyy-MM-dd HH:mm:ss"));
            ret.put("success",true);
        } catch (Exception e){
            logger.error(e.getLocalizedMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
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
     * 个人开始考试接口
     * @param request
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("/startExam.jhtml")
    public Object startExam(HttpServletRequest request){
        Map ret = new HashMap();
        String pid = request.getParameter("pid");
        HttpSession session = request.getSession();
        String uid = UserUtils.getUser().getId();
        String ustatus = "0";//UserUtils.getUser().getStatus();
//        BaseMessage message = new BaseMessage();
//        message.addUrl(new BaseUrl("我的试卷", "user/paper/list.jhtml"));
//        message.addUrl(new BaseUrl("历史考试", "user/paper/history.jhtml"));
//        if("forbidden".equals(BaseUtil.getSystemConfig("sys_allow_exam")) && !"1".equals(ustatus)) {
//            message.setSuccess(false);
//            message.setMessage(MessageHelper.getMessage("message.user.paper.start.forbidden"));
//            modelMap.put("message", message);
//            return new ModelAndView("common/message", modelMap);
//        } else {
            Paper paper = this.paperService.getPaper(uid,pid);
            if(paper == null) {
                ret.put("success",false);
                ret.put("msg","试卷不存在，请联系管理员确认");
//                modelMap.put("message", message);
//                return new ModelAndView("common/message", modelMap);
            } else {
                int paper_show_mode = paper.getShowmode();
                long nowtime = System.currentTimeMillis();
                if(paper.getEndtime().getTime() < nowtime) {
                    ret.put("success",false);
                    ret.put("msg","对不起，考试已经结束");
//                    modelMap.put("message", message);
//                    return new ModelAndView("common/message", modelMap);
                } else if(paper.getStarttime().getTime() > nowtime) {
                    ret.put("success",false);
                    ret.put("msg","对不起，考试尚未开始");
//                    modelMap.put("message", message);
//                    return new ModelAndView("common/message", modelMap);
                } else {
                    boolean hasRight = false;
                    String user_branchid = UserUtils.getUser().getId();
                    Iterator i = paper.getUsers().iterator();

                    while(i.hasNext()) {
                        String info = (String)i.next();
                        if(user_branchid.equals(info)) {
                            hasRight = true;
                            break;
                        }
                    }

                    if(!hasRight) {
                        ret.put("success",false);
                        ret.put("msg","没有权限参加该考试");
//                        modelMap.put("message", message);
//                        return new ModelAndView("common/message", modelMap);
                    } else {
                        if(paper.getPapertype() != 1 && paper.getOrdertype() == 1) {
                            i = paper.getSections().iterator();

                            while(i.hasNext()) {
                                PaperSection info1 = (PaperSection)i.next();
                                Collections.shuffle(info1.getQuestions());
                            }
                        }

//                        if(1 == paper.getPapertype()) {
//                            paper = this.paperService.getPaper(uid, pid);
//                        }

                        ExamHistory eh = new ExamHistory();
                        eh.setUid(uid);
                        eh.setPid(pid);
                        eh.setIp(this.getUserIP(request));
                        eh.setStarttime(new Date());
                        eh.setScore("0");
                        eh.setStatus("0");
                        int i1 = this.userPaperService.startExam(eh);
                        if(i1 == -1) {
                            ret.put("success",false);
                            ret.put("msg","打开试卷发生异常，请返回稍后再试");
//                            modelMap.put("message", message);
//                            return new ModelAndView("common/message", modelMap);
                        } else if(i1 == 2) {
                            ret.put("success",false);
                            ret.put("msg","您已经参加过考试，请在考试记录中查看批改结果。");
//                            modelMap.put("message", message);
//                            return new ModelAndView("common/message", modelMap);
                        } else {
//                            modelMap.put("paper", paper);
//                            return paper_show_mode == 2?new ModelAndView("user/paper/paper_detail_singlemode", modelMap):new ModelAndView("user/paper/paper_detail", modelMap);
                            //paper.setData(null);//TODO 调试阶段暂时设置为空
                            ret.put("success",true);
                            ret.put("data",paper);
                        }
                    }
                }
            }
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
//        }
    }

    /**
     * 考试交卷接口
     * @param request
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("/submitPaper.jhtml")
    public Object submitPaper(HttpServletRequest request){
        Map ret = new HashMap();
        try {
            this.userPaperService.submitPaper(request.getParameterMap());
            ret.put("success",true);
            ret.put("msg","成功提交试卷");
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
            ret.put("success",false);
            ret.put("msg","提交试卷发生异常，请返回稍后再试");
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

    protected String getUserIP(HttpServletRequest request) {
        String strUserIp = "127.0.0.1";
        strUserIp = request.getHeader("X-Forwarded-For");
        if(strUserIp == null || strUserIp.length() == 0 || "unknown".equalsIgnoreCase(strUserIp)) {
            strUserIp = request.getHeader("Proxy-Client-IP");
        }

        if(strUserIp == null || strUserIp.length() == 0 || "unknown".equalsIgnoreCase(strUserIp)) {
            strUserIp = request.getHeader("WL-Proxy-Client-IP");
        }

        if(strUserIp == null || strUserIp.length() == 0 || "unknown".equalsIgnoreCase(strUserIp)) {
            strUserIp = request.getRemoteAddr();
        }

        if(strUserIp != null) {
            strUserIp = strUserIp.split(",")[0];
        } else {
            strUserIp = "127.0.0.1";
        }

        if(strUserIp.length() > 16) {
            strUserIp = "127.0.0.1";
        }

        return strUserIp;
    }

    /**
     * 获取剩余考试时间接口
     * @param pid
     * @param request
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("/{pid}/leftTime.jhtml")
    public Object fetchPaperLeftTime(@PathVariable String pid , HttpServletRequest request){
        Map ret = new HashMap();
        try {
            String uid = UserUtils.getUser().getId();
            ret.put("success",true);
            ret.put("data",this.userPaperService.getUserPaperLeftTime(pid,uid));
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
            ret.put("success",false);
            ret.put("msg","获取试卷剩余时间失败");
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
}
