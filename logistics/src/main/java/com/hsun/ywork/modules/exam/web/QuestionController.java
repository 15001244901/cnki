/**
 *
 */
package com.hsun.ywork.modules.exam.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.servlet.ValidateCodeServlet;
import com.hsun.ywork.modules.cms.entity.Comment;
import com.hsun.ywork.modules.cms.service.CommentService;
import com.hsun.ywork.modules.exam.entity.*;
import com.hsun.ywork.modules.exam.service.QuestionService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.entity.UserQuestion;
import com.hsun.ywork.modules.user.service.UserQuestionService;
import com.thoughtworks.xstream.XStream;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.hash.Hash;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.common.utils.StringUtils;

import java.util.*;

import static com.sun.tools.javac.jvm.ByteCodes.ret;
import static oracle.net.aso.C05.b;
import static oracle.net.aso.C05.e;

/**
 * 试题管理Controller
 * @author GeCoder
 * @version 2016-12-23
 */
@Controller
@RequestMapping(value = "${adminPath}/exam/question")
public class QuestionController extends BaseController {

	@Autowired
	private QuestionService questionService;
    @Autowired
    private CommentService commentService;
	
	@ModelAttribute
	public Question get(@RequestParam(required=false) String id) {
		Question entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = questionService.get(id);
		}
		if (entity == null){
			entity = new Question();
		}
		return entity;
	}
	
	@RequiresPermissions("exam:question:view")
	@RequestMapping(value = {"list", ""})
	public String list(Question question, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Question> page = questionService.findPage(new Page<Question>(request, response), question);
		model.addAttribute("page", page);
		model.addAttribute("backURL","/exam/question/list");
		return "modules/exam/questionList";
	}

	@RequiresPermissions("exam:question:view")
	@RequestMapping(value = "listpreview")
	public String listpreview(Question question, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<Question> page = questionService.findPage(new Page<Question>(request, response), question);
//		model.addAttribute("page", page);
		model.addAttribute("backURL","/exam/question/listpreview");
		return "modules/exam/questionListPreview";
	}

	@RequiresPermissions("exam:question:view")
	@RequestMapping(value = "form")
	public String form(Question question, HttpServletRequest req , Model model) {
		model.addAttribute("question", question);
        if(question.getId()!=null&&question.getQData()!=null){
            XStream xStream = new XStream();
            Object o = xStream.fromXML(question.getQData());
            Gson gson = new Gson();
            model.addAttribute("json",gson.toJson(o));
        }

		String backURL = req.getParameter("backURL");
		model.addAttribute("backURL",backURL);
		return "modules/exam/questionForm";
	}

	@RequiresPermissions("exam:question:edit")
	@RequestMapping(value = "save")
	public String save(Question question, Model model, HttpServletRequest req , RedirectAttributes redirectAttributes) {
		question.set_options(req.getParameterValues("_options"));
		question.set_advOptions(req.getParameterMap());
		if (!beanValidator(model, question)){
			return form(question, req, model);
		}
		questionService.save(question);
		addMessage(redirectAttributes, "保存试题成功");

		String backURL = req.getParameter("backURL");
		if(StringUtils.isNotEmpty(backURL)) {
			redirectAttributes.addAttribute("backURL",backURL);
			return "redirect:" + Global.getAdminPath() + backURL;
		}
		return "redirect:"+ Global.getAdminPath()+"/exam/question/?repage";
	}
	
	@RequiresPermissions("exam:question:edit")
	@RequestMapping(value = "delete")
	public String delete(Question question, HttpServletRequest req , RedirectAttributes redirectAttributes) {
		questionService.delete(question);
		addMessage(redirectAttributes, "删除试题成功");
		String backURL = req.getParameter("backURL");
		if(StringUtils.isNotEmpty(backURL))
			return "redirect:"+Global.getAdminPath()+backURL;
		return "redirect:"+Global.getAdminPath()+"/exam/question/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "listjson")
	public String listJSON(Question question, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Question> page = questionService.findPage(new Page<Question>(request, response), question);
		Gson gson = new Gson();
		return gson.toJson(page);
	}

	//-------------------前端接口部分----------------------

	@ResponseBody
	@RequestMapping("list.jhtml")
	public Object list(Question question , HttpServletRequest request, HttpServletResponse response){
		Map ret = new HashMap();
		try {
			if(StringUtils.isEmpty(request.getParameter("fast"))) {
				//设置用id为查询收藏状态，试题篮状态用
				UserQuestion uq = new UserQuestion();
				uq.setUid(UserUtils.getUser().getId());
				question.setUserQuestion(uq);
			}

			Page<Question> page = questionService.findPage(new Page<Question>(request, response), question);
			List<QuestionVO> list = new ArrayList<QuestionVO>();
			for(Question q : page.getList()){
			    if(StringUtils.isEmpty(q.getQData()))
			        continue;
				XStream xStream = new XStream();
				xStream.autodetectAnnotations(true);
				QuestionVO vo =  (QuestionVO) xStream.fromXML(q.getQData());
				vo.setIsbasket(q.getIsbasket());
				vo.setQno(q.getQno());
				list.add(vo);
			}

			ret.put("success",true);
			ret.put("data",page);
			ret.put("datax",list);
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


	@ResponseBody
	@RequestMapping("{id}/view.jhtml")
	public Object view(@PathVariable String id , HttpServletRequest request){
		Map ret = new HashMap();
		try {
			Question question = this.get(id);
            QuestionVO qvo = questionService.getQuestion(id);
			ret.put("success",true);
			ret.put("data",question);
            ret.put("datax",qvo);
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

	/**
	 * http://localhost:8181/ywork/a/exam/question/d191f8c114504ba2ab77facfd4ebd264/check.jhtml?status=2
	 * 试题审核、待定、取消审核接口
	 * @param id 试题id
	 * @param status 要更新的状态
	 * @param request
	 * @return json对象
	 */
	@RequiresPermissions("exam:question:edit")
	@ResponseBody
	@RequestMapping("{id}/check.jhtml")
	public Object checkToggle(@PathVariable String id , @RequestParam("status") String status , HttpServletRequest request){
		//返回Map对象
		Map ret = new HashMap();
		//异常处理随时随地
		try {
			Question question = this.get(id);
			question.setQStatus(status);
			question.setUpdateDate(new Date());
			question.setUpdateBy(UserUtils.getUser());
			questionService.check(question);
			ret.put("msg","操作成功！");
			ret.put("success",true);
		} catch (Exception e){
			logger.error(e.getMessage());
			ret.put("msg","系统忙...");
			ret.put("success",false);
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

	@RequiresPermissions("exam:question:edit")
	@ResponseBody
	@RequestMapping(value = "checkSave.jhtml")
	public Object checkSave(Question question, Model model, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			Question _q = questionService.get(question.getId());
			_q.setQResolve(question.getQResolve());
			_q.setTopic(question.getTopic());
			_q.setPost(question.getPost());
			_q.setQLevel(question.getQLevel());
			if("1".equals(_q.getQType())) {
				_q.setQContent(question.getQContent());
				QuestionSingleChoice qv = (QuestionSingleChoice)questionService.getQuestion(_q.getId());
				String[] _options = new String[qv.getOptions().size()];
				for(int i=0;i<qv.getOptions().size();i++) {
					_options[i] = qv.getOptions().get(i).getText();
				}
				_q.set_options(_options);
			} else if("2".equals(_q.getQType())) {
				_q.setQContent(question.getQContent());
				QuestionMultipleChoice qv = (QuestionMultipleChoice)questionService.getQuestion(_q.getId());
				String[] _options = new String[qv.getOptions().size()];
				for(int i=0;i<qv.getOptions().size();i++) {
					_options[i] = qv.getOptions().get(i).getText();
				}
				_q.set_options(_options);
			} else if("4".equals(_q.getQType())) {
				QuestionBlankFill qv = (QuestionBlankFill)questionService.getQuestion(_q.getId());
				String[] bids = new String[qv.getBlanks().size()];
				String[] bvalues = new String[qv.getBlanks().size()];
				for(int i=0;i<qv.getBlanks().size();i++) {
					bids[i] = qv.getBlanks().get(i).getId()+"";
					bvalues[i] = qv.getBlanks().get(i).getValue();
				}
				Map map = new HashMap();
				map.put("q_blankids",bids);
				map.put("q_blanks",bvalues);
				map.put("q_iscomplex",new String[]{qv.isComplex()?"Y":"N"});
				_q.set_advOptions(map);
			} else {
				_q.setQContent(question.getQContent());
			}

			questionService.save(_q);
			ret.put("msg", "保存成功！");
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
     * 笔记列表
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "comment.jhtml", method=RequestMethod.GET)
    public Object comment(Comment comment, HttpServletRequest request, HttpServletResponse response) {
        Map ret = new HashMap();
        try {
            Page<Comment> page = new Page<Comment>(request, response);
			comment.setUid(UserUtils.getUser().getId());
            if(comment.getCtype()!=null&&comment.getCtype() == 2) {
                comment.setIspublic(1);
                comment.setDelFlag(Comment.DEL_FLAG_NORMAL);
            }

            if(comment.getCtype()!=null&&comment.getCtype() == 3) {
				comment.setDelFlag(null);
			}
            page = commentService.findPage(page, comment);
            ret.put("data", page);
            ret.put("success", true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            e.printStackTrace();
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
     * 试题笔记保存
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "commentsave.jhtml")
    public Object commentSave(Comment comment, String validateCode,@RequestParam(required=false) String replyId, HttpServletRequest request) {
        Map ret = new HashMap();
        try {
            if (StringUtils.isNotBlank(validateCode)){
                if (ValidateCodeServlet.validate(request, validateCode)){
                    if (StringUtils.isNotBlank(replyId)){
                        Comment replyComment = commentService.get(replyId);
                        if (replyComment != null){
                            comment.setContent("<div class=\"reply\">"+replyComment.getName()+":<br/>"
                                    +replyComment.getContent()+"</div>"+comment.getContent());
                        }
                    }
                    comment.setIp(request.getRemoteAddr());
                    comment.setCreateDate(new Date());
                    comment.setDelFlag(Comment.DEL_FLAG_AUDIT);
                    if(comment.getCtype() == 2) //笔记直接审核通过
                        comment.setDelFlag(Comment.DEL_FLAG_NORMAL);
                    comment.setUid(UserUtils.getUser().getId());
                    comment.setName(UserUtils.getUser().getName());
                    commentService.save(comment);
                    ret.put("success",true);
                    ret.put("msg","提交成功！");
                }else{
                    ret.put("success",false);
                    ret.put("msg","验证码不正确！");
                }
            }else{
                ret.put("success",false);
                ret.put("msg","验证码不能为空！");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            e.printStackTrace();
            ret.put("msg","系统忙...");
            ret.put("success",false);
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

    @RequestMapping("countQuestionNums.jhtml")
	@ResponseBody
	public Object countQuestionNums(Question question,HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			ret.put("data", this.questionService.countQuestionNums(question));
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