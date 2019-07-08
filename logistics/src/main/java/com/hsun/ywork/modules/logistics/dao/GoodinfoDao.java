/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.logistics.entity.Goodinfo;

/**
 * 货物信息DAO接口
 * @author 白云飞
 * @version 2018-04-09
 */
@MyBatisDao
public interface GoodinfoDao extends CrudDao<Goodinfo> {

    /**
     * app中更新物流订单状态，可在收费环节中更新退货金额和少收金额
     * @param goodinfo
     */
    void updateStatus(Goodinfo goodinfo);

    /**
     * 标记数据是否已读，在物流消息点击唤起app相关界面中调用
     * @param goodinfo
     */
    void updateIsread(Goodinfo goodinfo);

    /**
     * 通过单号获取物流信息
     * @param gno
     * @return
     */
    Goodinfo getByGno(String gno);
}