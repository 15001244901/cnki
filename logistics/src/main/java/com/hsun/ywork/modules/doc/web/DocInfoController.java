/**
 *
 */
package com.hsun.ywork.modules.doc.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.FileUtils;
import com.hsun.ywork.modules.doc.entity.DocInfo;
import com.hsun.ywork.modules.doc.entity.DocInfoDirectory;
import com.hsun.ywork.modules.doc.service.DocInfoDirectoryService;
import com.hsun.ywork.modules.doc.service.DocInfoService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.common.utils.StringUtils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.hsun.ywork.common.utils.DocConverter.callWordMacro;
import static com.hsun.ywork.common.utils.FileUtils.deleteFile;
import static oracle.net.aso.C01.i;
import static oracle.net.aso.C05.e;
import static org.bouncycastle.asn1.iana.IANAObjectIdentifiers.directory;

/**
 * 文档维护Controller
 * @author GeCoder
 * @version 2016-11-11
 */
@Controller
@RequestMapping(value = "${adminPath}/doc/docInfo")
public class DocInfoController extends BaseController {

	@Autowired
	private DocInfoService docInfoService;

	@Autowired
	private DocInfoDirectoryService docInfoDirectoryService;
	
	@ModelAttribute
	public DocInfo get(@RequestParam(required=false) String id) {
		DocInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = docInfoService.get(id);
		}
		if (entity == null){
			entity = new DocInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("doc:docInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(DocInfo docInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DocInfo> page = docInfoService.findPage(new Page<DocInfo>(request, response), docInfo);
		model.addAttribute("page", page);
		if(docInfo.getDirectory()!=null&&StringUtils.isNotEmpty(docInfo.getDirectory().getId())) {
			DocInfoDirectory directory = docInfoDirectoryService.get(docInfo.getDirectory().getId());
			docInfo.setDoctype(directory.getDtype());
			docInfo.setDomain(directory.getRtype());
			docInfo.setDirectory(directory);
			model.addAttribute("docInfo", docInfo);
		}
		return "modules/doc/docInfoList";
	}

	@RequiresPermissions("doc:docInfo:view")
	@RequestMapping(value = "form")
	public String form(DocInfo docInfo, Model model) {
		model.addAttribute("docInfo", docInfo);
		model.addAttribute("parentNames",getParentName(docInfo.getDirectory()));
		return "modules/doc/docInfoForm";
	}

	public String getParentName(DocInfoDirectory node){
		if(node==null)
			return "";
		String pname = node.getName();
		if(node.getParentId()!=null&&!"0".equals(node.getParentId())){
			DocInfoDirectory parent = docInfoDirectoryService.get(node.getParent().getId());
			pname = getParentName(parent)+" >> "+pname;
		}
		return pname;
	}

	@RequiresPermissions("doc:docInfo:edit")
	@RequestMapping(value = "save")
	public String save(DocInfo docInfo, Model model, HttpServletRequest request , RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, docInfo)){
			return form(docInfo, model);
		}
//		try {
//			if(StringUtils.isEmpty(docInfo.getContent())&&FileUtils.getFileSufix(docInfo.getFiles()).indexOf("doc")>=0) {
//				String fileURL = docInfo.getFiles();
//				String filePath = request.getSession().getServletContext().getRealPath(fileURL.replaceAll(request.getContextPath(), ""));
//
//				filePath = URLDecoder.decode(filePath, "UTF-8");
//				logger.info("-----开始处理文档："+filePath+"-----");
//				int pageSize = callWordMacro(filePath, "SplitPagesAsDocuments");
//				logger.info("-----拆分了："+pageSize+" 页文档！-----");
//				if (pageSize <= 30) {
//					logger.info("-----开始逐个转换html文件...-----");
//					String contentPaths = "";
//					List<String> tmpFiles = new ArrayList<String>();
//					for (int i = 1; i <= pageSize; i++) {
//						String subFilePath = filePath.substring(0, filePath.lastIndexOf(".")) + "_" + i + "." + filePath.substring(filePath.lastIndexOf(".") + 1);
//						callWordMacro(subFilePath, "SavePagesToMultipleHTMLFiles");
//						tmpFiles.add(subFilePath);
//						contentPaths += "|" + fileURL.substring(0, fileURL.lastIndexOf(".")) + "_" + i + ".html";
//					}
//					logger.info("-----转换完毕!-----");
//
//					logger.info("-----开始清理临时文件...-----");
//					for (String tmpFile : tmpFiles) {
//						deleteFile(tmpFile);
//					}
//					logger.info("-----清理临时文件完毕!-----");
//					docInfo.setContent(contentPaths);
//				} else {
//					throw new RuntimeException("文件页数太多，请重新上传文件");
//				}
//			}
//		} catch (Exception e) {
//			logger.error("转换过程出现异常："+e.getMessage());
//			e.printStackTrace();
//		}
		docInfoService.save(docInfo);
		addMessage(redirectAttributes, "保存文档维护成功");

		String directoryid = docInfo.getDirectory().getId();
		return "redirect:"+ Global.getAdminPath()+"/doc/docInfo/?repage&directory.id="+directoryid;
	}
	
	@RequiresPermissions("doc:docInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(DocInfo docInfo, RedirectAttributes redirectAttributes) {
		String directoryid = docInfo.getDirectory().getId();
		docInfoService.delete(docInfo);
		addMessage(redirectAttributes, "删除文档维护成功");
		return "redirect:"+Global.getAdminPath()+"/doc/docInfo/?repage&directory.id="+directoryid;
	}

	@RequiresPermissions("doc:docInfo:view")
	@RequestMapping(value = "attachPreview")
	public String attachPreview(HttpServletRequest req ,
                             HttpServletResponse resp ,
                             String fileURL ,
                             String showType ,
                             Model model){
	    if(showType==null)
	        showType = "pdf";
		String targetFileURL = fileURL.substring(0,fileURL.lastIndexOf(".")+1)+showType;
        String fileName = null;
		fileURL = fileURL.replaceAll(req.getContextPath(),"");
		String filePath = req.getSession().getServletContext().getRealPath(fileURL.substring(0,fileURL.lastIndexOf("/")));
		String exePath = req.getSession().getServletContext().getRealPath("/static/flash");
		try {
			fileName = URLDecoder.decode(fileURL.substring(fileURL.lastIndexOf("/")+1),"UTF-8");
            String targetFileRealPath = docInfoService.getTargetFilePath(filePath,fileName,"swf".equals(showType)?exePath:null);
            model.addAttribute("fileSize", FileUtils.getFileSize(targetFileRealPath));
            targetFileURL = URLDecoder.decode(targetFileURL,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		model.addAttribute("targetFileURL",targetFileURL);
        model.addAttribute("showType",showType);
        return "modules/doc/docInfoAttachPreview";
	}

    @RequiresPermissions("doc:docInfo:view")
    @RequestMapping(value = "{fileType}/preview")
    public String preview(HttpServletRequest req ,
                          HttpServletResponse resp ,
                          @PathVariable String fileType ,
                          DocInfo docInfo,
                          Model model){
    	model.addAttribute("m",docInfo);
    	Map ret = (Map)this.preview(req,resp,docInfo);
		model.addAllAttributes(ret);
        if("swf".equals(fileType))
            return "modules/doc/docInfoSwfPreview";
        else
            return "modules/doc/docInfoPdfPreview";
    }

	@RequiresPermissions("doc:docInfo:view")
	@RequestMapping(value = {"listf"})
	public String listInFront(DocInfo docInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DocInfo> page = docInfoService.findPage(new Page<DocInfo>(request, response), docInfo);
		page.setPageStyle(2);
		model.addAttribute("page", page);
		return "modules/doc/docInfoListInFront";
	}

	//----------------以下为供前端调用接口--------------------

	/**
	 * 文档列表页json内容
	 * @param docInfo
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "list.jhtml")
	@ResponseBody
	public Object listJson(DocInfo docInfo, HttpServletRequest request, HttpServletResponse response) {
		Map ret = new HashMap();

		try {
			Page<DocInfo> page = docInfoService.findPage(new Page<DocInfo>(request, response), docInfo);
			ret.put("success",true);
			ret.put("data",page);
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
	 * 文档详情页json内容
	 * @param req
	 * @param resp
	 * @param docInfo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "preview.jhtml",method = RequestMethod.GET)
	public Object preview(HttpServletRequest req ,
					   HttpServletResponse resp ,
					   DocInfo docInfo){
		Map ret = new HashMap();
		try {
			docInfo.setFiles(URLDecoder.decode(docInfo.getFiles(),"UTF-8"));
			docInfo.setPvcount(docInfo.getPvcount()+1);
			docInfoService.save(docInfo);

			String showType = req.getParameter("showType");
			if("file".equals(showType)) {
				if(StringUtils.isNotEmpty(docInfo.getFiles())) {
					String[] urls = docInfo.getFiles().split("\\|");
					String fileURL = null;
					for (String url : urls) {
						if (!"".equals(url)) {
							fileURL = url;//如果有多个附件，目前只取第一个
							break;
						}
					}
					this.attachPreview(ret, req, resp, fileURL, "pdf");
				} else {
					//找不到文件附件时，将错误信息返回到错误页面，或者定位到一个固定的PDF文件中，显示错误信息
					ret.put("success",true);
					ret.put("msg","文档被上传到火星上了!!!");
				}
			} else {
				if(StringUtils.isNotEmpty(docInfo.getContent())) {
					String[] urls = docInfo.getContent().split("\\|");
					List<String> urlList = new ArrayList<String>();
					for (String url : urls)
						if (StringUtils.isNotEmpty(url)) {
							url = URLDecoder.decode(url,"UTF-8");
							urlList.add(url);
						}

					int pageNo = 1;
					if (StringUtils.isNotEmpty(req.getParameter("pageNo")))
						pageNo = Integer.parseInt(req.getParameter("pageNo"));
					Page<String> page = new Page<String>(pageNo, 1, (long) urlList.size());
					page.setList(urlList);
					page.setPageStyle(2);
					ret.put("page", page);
					ret.put("htmlURL", page.getList().get(pageNo - 1));
				} else {
					//找不到文件内容时，将错误信息返回到错误页面，或者定位到一个固定的PDF文件中，显示错误信息
					ret.put("success",true);
					ret.put("msg","文档被上传到火星上了!!!");
				}
			}
			ret.put("data",docInfo);
			ret.put("directoryName",getParentName(docInfo.getDirectory()));
			ret.put("success",true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","文档缺失...");
			e.printStackTrace();
		} finally {
			String callback = req.getParameter("callback");
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
	 * 文档用户收藏前端操作
	 * @param did
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value="collect.jhtml",method = RequestMethod.GET)
	public Object collect(@RequestParam("did") String did , HttpServletRequest request){
		Map ret = new HashMap();
		try {
			String uid = UserUtils.getUser().getId();
		    String udid = request.getParameter("iscollected");//用户文档收藏记录id
			String pid = request.getParameter("pid");
            ret.put("success",true);
            if(StringUtils.isEmpty(udid)||"0".equals(udid)) {
                this.docInfoService.userCollect(uid, pid);
                this.docInfoService.userCollect(uid, did);
                ret.put("msg","收藏成功！");
            } else {
                this.docInfoService.cancelCollect(uid,did);
                ret.put("msg","取消收藏成功！");
            }
		} catch (Exception e){
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

	private void attachPreview(Map ret , HttpServletRequest req ,
								HttpServletResponse resp ,
								String fileURL ,
								String fileType){
		if(fileType==null)
			fileType = "pdf";
		String targetFileURL = fileURL.substring(0,fileURL.lastIndexOf(".")+1)+fileType;
		String fileName = null;
		fileURL = fileURL.replaceAll(req.getContextPath(),"");
		String filePath = req.getSession().getServletContext().getRealPath(fileURL.substring(0,fileURL.lastIndexOf("/")));
		String exePath = req.getSession().getServletContext().getRealPath("/static/flash");
		try {
			fileName = URLDecoder.decode(fileURL.substring(fileURL.lastIndexOf("/")+1),"UTF-8");
			String targetFileRealPath = docInfoService.getTargetFilePath(filePath,fileName,"swf".equals(fileType)?exePath:null);
			ret.put("fileSize", FileUtils.getFileSize(targetFileRealPath));
			targetFileURL = URLDecoder.decode(targetFileURL,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ret.put("targetFileURL",targetFileURL);
		ret.put("fileType",fileType);
	}
}