package com.hsun.ywork.modules.exam.task;

import com.hsun.ywork.modules.exam.service.PaperService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Created by GeCoder on 2017-03-08 .
 */
@Component @Lazy(false)
public class PaperTask {
    private static final Logger logger = Logger.getLogger(PaperTask.class);
    @Autowired
    private PaperService paperService;

    private boolean loaded = false;

    public PaperTask() {
    }

    @Scheduled(
            fixedRate = 3600000L
    )
    public void doLoadPapers() {
        if (!this.loaded) {
            this.paperService.loadAllPapers();
            this.loaded = true;
        }

    }

    @Scheduled(
            fixedRate = 5000L
    )
    public void doPaperCheck() {
        int rows = this.paperService.doCheckPaperQueue();
        if (rows > 0) {
            logger.info("定时任务:成功批改" + rows + "份试卷.");
        }
    }
}
