package com.hsun.ywork.modules.user.service;

import com.hsun.ywork.common.service.BaseService;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.sys.entity.Role;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.dao.MyTeamDao;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: GeCoder
 * @Description: 我的团队业务类
 * @Date: 14:40 2018-01-25
 * @ModifyBy: GeCoder
 */
@Service
public class MyTeamService extends CrudService<MyTeamDao,User> {

    /**
     * 统计我的团队成员的答题情况
     * @param manager
     * @return
     */
    public List countDTB(User manager) {

        manager.getSqlMap().put("dsf", dataScopeFilter(UserUtils.getUser(), "o", null));

        return dao.countDTB(manager);
    }

    /**
     * 统计我的团队活跃榜（数据支撑来源于问答模块）
     * @param manager
     * @return
     */
    public List countHYB(User manager) {

        manager.getSqlMap().put("dsf", dataScopeFilter(UserUtils.getUser(), "o", null));

        return dao.countHYB(manager);
    }

    /**
     * 统计我的团队勤奋榜（学习时间：考试耗时+练习耗时+视频播放次数）
     * @param manager
     * @return
     */
    public List countQFB(User manager) {

        manager.getSqlMap().put("dsf", dataScopeFilter(UserUtils.getUser(), "o", null));

        return dao.countQFB(manager);
    }
}
