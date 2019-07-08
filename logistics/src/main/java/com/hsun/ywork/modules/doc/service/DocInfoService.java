/**
 *
 */
package com.hsun.ywork.modules.doc.service;

import java.util.List;

import com.hsun.ywork.common.utils.FileUtils;
import com.hsun.ywork.common.utils.OpenOfficePDFConverter;
import com.hsun.ywork.modules.doc.dao.DocInfoDao;
import com.hsun.ywork.modules.user.dao.UserDocInfoDao;
import com.hsun.ywork.modules.user.entity.UserDocInfo;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.doc.entity.DocInfo;

/**
 * 文档维护Service
 * @author GeCoder
 * @version 2016-11-11
 */
@Service
@Transactional(readOnly = true)
public class DocInfoService extends CrudService<DocInfoDao, DocInfo> {

	@Autowired
	private UserDocInfoDao userDocInfoDao;

	public DocInfo get(String id) {
		return super.get(id);
	}
	
	public List<DocInfo> findList(DocInfo docInfo) {
		return super.findList(docInfo);
	}
	
	public Page<DocInfo> findPage(Page<DocInfo> page, DocInfo docInfo) {
		return super.findPage(page, docInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(DocInfo docInfo) {
		docInfo.setContent(StringEscapeUtils.unescapeHtml4(docInfo.getContent()));
		super.save(docInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(DocInfo docInfo) {
		super.delete(docInfo);
	}

	@Transactional(readOnly = false)
	public void userCollect(String uid , String did){
		if(userDocInfoDao.findByUidAndDid(uid,did)==null){
			UserDocInfo ud = new UserDocInfo(uid,did);
			ud.preInsert();
			userDocInfoDao.insert(ud);
		}
	}

    @Transactional(readOnly = false)
    public void cancelCollect(String uid , String did) {
        UserDocInfo udi = new UserDocInfo();
        udi.setUid(uid);
        udi.setDid(did);
        userDocInfoDao.delete(udi);
    }

	/**
	 * 将源文件转换为pdf或swf，根据文件路径、文件名，获取目标文件路径
	 * @param filePath
	 * @param fileName
	 * @param exePath
	 * @return
	 */

//	public String getTargetFilePath(String filePath , String fileName , String exePath) {
//		String targetFilePath = null;
//		DocConverter converter = new DocConverter(filePath+"\\"+fileName,filePath,exePath);
//		converter.convert();
//		targetFilePath = filePath + "\\"+fileName.substring(0,fileName.lastIndexOf("."))+(exePath==null?".pdf":".swf");
//		return targetFilePath;
//	}

	public String getTargetFilePath(String filePath , String fileName , String exePath) {
		String targetFilePath = null;

		//考虑上传的资料全部为pdf格式，暂时关闭文档转换服务
//		OpenOfficePDFConverter converter = new OpenOfficePDFConverter();
//		converter.convert2PDF(filePath+"\\"+fileName);

		targetFilePath = FileUtils.getFilePrefix(filePath+"\\"+fileName)+(exePath==null?".pdf":".swf");
		return targetFilePath;
	}
}