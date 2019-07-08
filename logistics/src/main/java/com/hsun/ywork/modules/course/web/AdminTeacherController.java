package com.hsun.ywork.modules.course.web;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.utils.WebUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.entity.QuerySubject;
import com.hsun.ywork.modules.course.entity.QueryTeacher;
import com.hsun.ywork.modules.course.entity.Subject;
import com.hsun.ywork.modules.course.entity.Teacher;
import com.hsun.ywork.modules.course.service.SubjectService;
import com.hsun.ywork.modules.course.service.TeacherService;
import com.hsun.ywork.modules.qa.utils.ObjectUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.sun.tools.javac.jvm.ByteCodes.ret;

/**
 * ho后台管理
 * @author GeCoder
 */
@Controller
@RequestMapping("${adminPath}/teacher")
public class AdminTeacherController extends BaseController {
    //log日志
    private static final Logger logger = LoggerFactory.getLogger(AdminTeacherController.class);
    
    // 绑定变量名字和属性，参数封装进类
    @InitBinder("teacher")
    public void initBinderTeacher(WebDataBinder binder) {
        binder.setFieldDefaultPrefix("teacher.");
    }
    @InitBinder("queryTeacher")
    public void initBinderQueryTeacher(WebDataBinder binder) {
    	binder.setFieldDefaultPrefix("queryTeacher.");
    }
    @InitBinder({"page"})
    public void initBinderPage(WebDataBinder binder) {
        binder.setFieldDefaultPrefix("page.");
    }
    
    //教师 service
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private SubjectService subjectService;
    
    /** 到教师添加页面 */
    @RequestMapping("/toAdd")
    public ModelAndView toAddTeacher(HttpServletRequest request) {
    	ModelAndView model = new ModelAndView();
    	try{
    		model.setViewName(getViewPath("/teacher/teacherAdd"));//讲师添加页面
    		QuerySubject query = new QuerySubject();
    		List<Subject> subjectList = subjectService.getSubjectList(query);
    		model.addObject("subjectList", gson.toJson(subjectList));
    	}catch (Exception e) {
    		model.setViewName(this.setExceptionRequest(request, e));
			logger.error("toAddTeacher()---error",e);
		}
        return model;
    }

    /** 添加教师 */
    @RequestMapping("/add")
    public String addTeacher(HttpServletRequest request, @ModelAttribute("teacher") Teacher teacher) {
        try {
            // 添加讲师
            if (ObjectUtils.isNotNull(teacher)) {
                //状态:0正常1删除
                teacher.setStatus(0);
                //添加时间
                teacher.setCreateTime(new Date());
                teacher.setUpdateTime(new Date());
                teacherService.addTeacher(teacher);
            }
        } catch (Exception e) {
            logger.error("AdminTeacherController.addTeacher", e);
            return setExceptionRequest(request, e);
        }
        return "redirect:"+ Global.getAdminPath()+"/teacher/list";
    }

    /**
     * 到教师列表页面分页
     */
    @RequestMapping("/list")
    public ModelAndView teacherList(HttpServletRequest request, @ModelAttribute("queryTeacher") QueryTeacher queryTeacher, @ModelAttribute("page") PageEntity page) {
    	ModelAndView model = new ModelAndView();
    	try {
    		model.setViewName(getViewPath("/teacher/teacherList"));;//讲师列表页面
            //按条件查询教师分页
            List<Teacher> teacherList =  teacherService.queryTeacherListPage(queryTeacher, page);
            //教师数据
            model.addObject("teacherList",teacherList);
            //分数数据
            model.addObject("page",page);
            //讲师查询条件
            model.addObject("queryTeacher",queryTeacher);
        } catch (Exception e) {
        	model.setViewName(setExceptionRequest(request, e));
            logger.error("teacherList()--error", e);
        }
        return model;
    }
    /**
     * 根据老师id获得详情
     */
    @RequestMapping("/toUpdate/{id}")
    public ModelAndView toUpdateTeacher(HttpServletRequest request, @PathVariable("id") int id) {
    	ModelAndView model = new ModelAndView();
    	try {
    		model.setViewName(getViewPath("/teacher/teacherUpdate"));//讲师修改页面
            // 查詢老師
            Teacher teacher = teacherService.getTeacherById(id);
            // 把返回的数据放到model中
            model.addObject("teacher", teacher);
            QuerySubject query = new QuerySubject();
            //查询所有的专业
            List<Subject> subjectList = subjectService.getSubjectList(query);
            if(teacher!=null && teacher.getSubjectId()>0){
            	for(Subject s:subjectList){
                    //获得讲师对应的专业
            		if(s.getSubjectId()==teacher.getSubjectId()){
            			model.addObject("subject", s);
            			break;
            		}
            	}
            }
            model.addObject("subjectList", gson.toJson(subjectList));
        } catch (Exception e) {
        	model.setViewName(setExceptionRequest(request, e));
            logger.error("toUpdateTeacher()--error", e);
        }
        return model;
    }
    /**
     * 更新讲师
     */
    @RequestMapping("/update")
    public ModelAndView updateTeacher(HttpServletRequest request, @ModelAttribute("teacher") Teacher teacher) {
    	ModelAndView model = new ModelAndView();
    	try {
    		model.setViewName("redirect:"+ Global.getAdminPath()+"/teacher/list");
    		
            if (ObjectUtils.isNotNull(teacher)) {
                teacher.setUpdateTime(new Date());
                teacherService.updateTeacher(teacher);
            }
        } catch (Exception e) {
            logger.error("updateTeacher()--error", e);
            model.setViewName(setExceptionRequest(request, e));
        }
        return model;
    }
    /**
     * 刪除讲师
     */
    @RequestMapping("/delete/{id}")
    public ModelAndView deleteTeacher(HttpServletRequest request, @PathVariable("id") Integer id) {
    	ModelAndView model = new ModelAndView();
    	try {
    		model.setViewName("redirect:"+ Global.getAdminPath()+"/teacher/list");
            if (ObjectUtils.isNotNull(id)) {
                teacherService.deleteTeacherById(id);// 刪除讲师
            }
        } catch (Exception e) {
            logger.error("deleteTeacher()---error", e);
            model.setViewName(setExceptionRequest(request, e));
        }
        return model;
    }

    /**
     * 挑选讲师列表
     */
    @RequestMapping("/selectlist/{type}")
    public ModelAndView queryselectTeacherList(HttpServletRequest request, @ModelAttribute("page") PageEntity page, @ModelAttribute("queryTeacher") QueryTeacher queryTeacher, @PathVariable("type") String type) {
    	ModelAndView model = new ModelAndView();
    	try {
    		model.setViewName(getViewPath("/teacher/selectTeacherList"));// 选择讲师列表页面
            // 查詢讲师
            List<Teacher> teacherList = teacherService.queryTeacherListPage(queryTeacher, page);
            // 把返回的数据放到model中
            model.addObject("teacherList", teacherList);
            model.addObject("page", page);
            model.addObject("queryTeacher", queryTeacher);
            model.addObject("type", type);
        } catch (Exception e) {
        	model.setViewName(this.setExceptionRequest(request, e));
            logger.error("AdminTeacherController.queryTeacherList", e);
        }
        return model;
    }

    //------------------------前后端分离开发模式接口部分------------------

    /** 到列表页面 */
    @RequestMapping("/toList.jhtml")
    @RequiresPermissions("teacher:view")
    public String toList(HttpServletRequest request) {
        return getViewPath("/teacher/teacherList");
    }

    /** 到添加页面 */
    @RequestMapping("/toAdd.jhtml")
    @RequiresPermissions("teacher:edit")
    public String toAdd(HttpServletRequest request) {
        return getViewPath("/teacher/teacherAdd");
    }

    /** 到修改页面 */
    @RequestMapping("/toUpdate.jhtml")
    @RequiresPermissions("teacher:edit")
    public String toUpdate(HttpServletRequest request) {
        return getViewPath("/teacher/teacherUpdate");
    }

    @ResponseBody
    @RequestMapping("add.jhtml")
    @RequiresPermissions("teacher:edit")
    public Object addTeacherAjax(HttpServletRequest request , @ModelAttribute("teacher") Teacher teacher) {
        Map ret = new HashMap();
        try {
            // 添加讲师
            if (ObjectUtils.isNotNull(teacher)) {
                //状态:0正常1删除
                teacher.setStatus(0);
                //添加时间
                teacher.setCreateTime(new Date());
                teacher.setUpdateTime(new Date());
                teacherService.addTeacher(teacher);
            }
            ret.put("data", teacher);
            ret.put("msg","新增讲师成功！");
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

    @ResponseBody
    @RequestMapping("list.jhtml")
    @RequiresPermissions("teacher:view")
    public Object teacherListAjax(HttpServletRequest request, @ModelAttribute("queryTeacher") QueryTeacher queryTeacher, @ModelAttribute("page") PageEntity page) {
        Map ret = new HashMap();
        try {
            //按条件查询教师分页
            List<Teacher> teacherList =  teacherService.queryTeacherListPage(queryTeacher, page);
            //教师数据
            ret.put("teacherList",teacherList);
            //分页数据
            ret.put("page",page);
            //讲师查询条件
            ret.put("queryTeacher",queryTeacher);
            request.getSession().setAttribute("teacher_list", WebUtils.getServletRequestUriParms(request));
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
     * 更新讲师
     */
    @ResponseBody
    @RequestMapping("/update.jhtml")
    @RequiresPermissions("teacher:edit")
    public Object updateTeacherAjax(HttpServletRequest request, @ModelAttribute("teacher") Teacher teacher) {
        Map ret = new HashMap();
        try {
            if (ObjectUtils.isNotNull(teacher)) {
                teacher.setUpdateTime(new Date());
                teacherService.updateTeacher(teacher);
            }
            ret.put("msg","更新讲师成功！");
            ret.put("data", teacher);
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
     * 刪除讲师
     */
    @ResponseBody
    @RequestMapping("/{id}/delete.jhtml")
    @RequiresPermissions("teacher:edit")
    public Object deleteTeacherAjax(HttpServletRequest request, @PathVariable("id") Integer id) {
        Map ret = new HashMap();
        try {
            if (ObjectUtils.isNotNull(id)) {
                teacherService.deleteTeacherById(id);// 刪除讲师
            }
            ret.put("msg","删除讲师成功！");
            ret.put("data", id);
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
     * 根据id获得讲师
     */
    @RequestMapping("/{id}/get.jhtml")
    @ResponseBody
    @RequiresPermissions("teacher:view")
    public Object getTeacher(HttpServletRequest request, @PathVariable("id") int id) {
        Map ret = new HashMap();
        try {
            // 查詢老師
            Teacher teacher = teacherService.getTeacherById(id);
            // 把返回的数据放到model中
            ret.put("teacher", teacher);
            QuerySubject query = new QuerySubject();
            //查询所有的专业
            List<Subject> subjectList = subjectService.getSubjectList(query);
            if(teacher!=null && teacher.getSubjectId()>0){
                for(Subject s:subjectList){
                    //获得讲师对应的专业
                    if(s.getSubjectId()==teacher.getSubjectId()){
                        ret.put("subject", s);
                        break;
                    }
                }
            }
            ret.put("subjectList", subjectList);
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