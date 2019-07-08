/**
 *
 */
package com.hsun.ywork.modules.doc.dao;

import com.hsun.ywork.common.persistence.TreeDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.doc.entity.DocInfoDirectory;

import java.util.List;

/**
 * 文档目录DAO接口
 * @author GeCoder
 * @version 2016-12-21
 */
@MyBatisDao
public interface DocInfoDirectoryDao extends TreeDao<DocInfoDirectory> {

    public List<DocInfoDirectory> findListByUid(DocInfoDirectory docInfoDirectory);
}