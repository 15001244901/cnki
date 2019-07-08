/**
 *
 */
package com.hsun.ywork.modules.test.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.test.entity.Test;
import com.hsun.ywork.modules.test.dao.TestDao;

/**
 * 测试Service
 * @author GeCoder
 * @version 2013-10-17
 */
@Service
@Transactional(readOnly = true)
public class TestService extends CrudService<TestDao, Test> {

}
