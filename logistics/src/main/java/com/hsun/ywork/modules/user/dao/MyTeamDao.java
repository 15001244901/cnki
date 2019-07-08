package com.hsun.ywork.modules.user.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.sys.entity.User;

import java.util.List;

/**
 * @Author: GeCoder
 * @Description: 我的团队DAO
 * @Date: 14:41 2018-01-25
 * @ModifyBy: GeCoder
 */
@MyBatisDao
public interface MyTeamDao extends CrudDao<User> {
    /**
     * 统计我的团队成员的答题情况
     * @param manager
     * @return
     */
    public List countDTB(User manager);

    /**
     * 统计我的团队活跃榜（数据支撑来源于问答模块）
     * @param manager
     * @return
     */
    public List countHYB(User manager);

    /**
     * 统计我的团队勤奋榜（学习时间：考试耗时+练习耗时+视频播放次数）
     * @param manager
     * @return
     */
    public List countQFB(User manager);
}
