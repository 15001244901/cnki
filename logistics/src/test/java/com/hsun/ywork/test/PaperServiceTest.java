package com.hsun.ywork.test;

import com.hsun.ywork.common.test.SpringTransactionalContextTests;
import com.hsun.ywork.modules.exam.service.PaperService;
import org.junit.*;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Administrator on 2017-03-08 .
 */
public class PaperServiceTest extends SpringTransactionalContextTests {

    @Autowired private PaperService paperService;

    @org.junit.Test
    public void testPaperCheck(){
        int row = paperService.doCheckPaperQueue();
        System.out.println(row);
    }
}
