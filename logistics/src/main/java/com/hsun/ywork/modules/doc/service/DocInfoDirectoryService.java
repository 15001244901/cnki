/**
 *
 */
package com.hsun.ywork.modules.doc.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.service.TreeService;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.doc.entity.DocInfoDirectory;
import com.hsun.ywork.modules.doc.dao.DocInfoDirectoryDao;

/**
 * 文档目录Service
 * @author GeCoder
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class DocInfoDirectoryService extends TreeService<DocInfoDirectoryDao, DocInfoDirectory> {

	public DocInfoDirectory get(String id) {
		return super.get(id);
	}
	
	public List<DocInfoDirectory> findList(DocInfoDirectory docInfoDirectory) {
		if (StringUtils.isNotBlank(docInfoDirectory.getParentIds())){
			docInfoDirectory.setParentIds(","+docInfoDirectory.getParentIds()+",");
		}
		return super.findList(docInfoDirectory);
	}
	
	@Transactional(readOnly = false)
	public void save(DocInfoDirectory docInfoDirectory) {
		super.save(docInfoDirectory);
	}
	
	@Transactional(readOnly = false)
	public void delete(DocInfoDirectory docInfoDirectory) {
		super.delete(docInfoDirectory);
	}

    public List<DocInfoDirectory> findListByUser(DocInfoDirectory docInfoDirectory) {
		if (StringUtils.isNotBlank(docInfoDirectory.getParentIds())){
			docInfoDirectory.setParentIds(","+docInfoDirectory.getParentIds()+",");
		}
		return dao.findListByUid(docInfoDirectory);
    }
}