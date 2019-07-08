/**
 *
 */
package com.hsun.ywork.modules.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.cms.dao.ArticleDataDao;
import com.hsun.ywork.modules.cms.entity.ArticleData;

/**
 * 站点Service
 * @author GeCoder
 * @version 2013-01-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleDataService extends CrudService<ArticleDataDao, ArticleData> {

}
