package com.hsun.ywork.modules.common.dao;

/**
 * Created by GeCoder on 2017-07-26 .
 */
import com.hsun.ywork.modules.common.entity.PageEntity;
import java.util.List;

public interface GenericDao {
    Long insert(String sqlKey, Object object);

    Long delete(String sqlKey, Object object);

    Long update(String sqlKey, Object object);

    <T> T selectOne(String sqlKey, Object params);

    <T> List<T> selectList(String sqlKey, Object params);

    <T> List<T> queryForListPage(String sqlKey, Object params, PageEntity page);
}
