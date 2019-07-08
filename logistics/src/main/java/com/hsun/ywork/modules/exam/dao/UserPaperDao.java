package com.hsun.ywork.modules.exam.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.exam.entity.Paper;

import java.util.List;
import java.util.Map;

/**
 * 个人试卷dao接口
 * Created by GeCoder on 2017-03-06 .
 */
@MyBatisDao
public interface UserPaperDao extends CrudDao<Paper>{
    public int startExam(Map param);
}
