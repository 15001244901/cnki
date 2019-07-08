/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.user.entity.UserMessage;

import java.util.Map;

/**
 * 即时消息DAO接口
 * @author GeCoder
 * @version 2017-06-21
 */
@MyBatisDao
public interface UserMessageDao extends CrudDao<UserMessage> {

    public void update2Read(Map param);
}