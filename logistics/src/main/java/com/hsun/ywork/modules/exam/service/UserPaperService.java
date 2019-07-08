package com.hsun.ywork.modules.exam.service;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.common.utils.BaseUtils;
import com.hsun.ywork.common.utils.CacheUtils;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.utils.SystemQueue;
import com.hsun.ywork.modules.exam.dao.ExamHistoryDao;
import com.hsun.ywork.modules.exam.dao.UserPaperDao;
import com.hsun.ywork.modules.exam.entity.ExamHistory;
import com.hsun.ywork.modules.exam.entity.Paper;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.*;

import static com.sun.star.drawing.CaptionEscapeDirection.auto;
import static java.awt.SystemColor.info;
import static oracle.net.aso.C01.i;
import static oracle.net.aso.C05.e;

/**
 * Created by GeCoder on 2017-03-06 .
 */
@Service
@Transactional(readOnly = true)
public class UserPaperService extends CrudService<UserPaperDao,Paper>{

    @Autowired private ExamHistoryService examHistoryService;

    public Page<Paper> findPage(Page<Paper> page, Paper paper) {
        return super.findPage(page, paper);
    }

    @Transactional(readOnly = false)
    public int startExam(ExamHistory eh) {
        logger.info(String.format("用户标记考试开始，info=%s", new Object[]{eh.toString()}));

        try {
            List<ExamHistory> list = examHistoryService.findList(eh);
            if(list!=null&&list.size()>0&&list.get(0)!=null){
                int status = "0".equals(list.get(0).getStatus())?0:2;
                return status;
            } else {
                this.examHistoryService.save(eh);
                return 0;
            }
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
            return -1;
        }
    }

    public int getUserPaperLeftTime(String pid, String uid) {
        try {
            Paper e = (Paper) CacheUtils.get("PaperCache", "P" + pid);
            int totalSeconds = e.getDuration() * 60;
            List<ExamHistory> list = examHistoryService.findList(new ExamHistory(pid,uid));
            if(list == null||list.size()==0) {
                return totalSeconds;
            } else {
                ExamHistory eh = list.get(0);
                String status = eh.getStatus();
                if("0".equals(status)) {
                    long joinTime = eh.getStarttime().getTime();
                    long nowTime = (new Date()).getTime();
                    long passedTime = nowTime - joinTime;
                    int passedSeconds = (new Long(passedTime / 1000L)).intValue();
                    int leftSeconds = totalSeconds - passedSeconds;
                    return leftSeconds;
                } else {
                    return -1;
                }
            }
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
            return -9;
        }
    }

    @Transactional(readOnly = false)
    public int submitPaper(Map params) {
        logger.info("用户提交试卷...");
        HashMap examData = new HashMap();
        String randcode = BaseUtils.generateRandomString(10);

        try {
            Iterator it = params.entrySet().iterator();

            while(it.hasNext()) {
                Map.Entry entry = (Map.Entry)it.next();
                examData.put((String)entry.getKey(), StringUtils.join((Object[])entry.getValue(), "`"));
            }
            examData.put("uid",UserUtils.getUser().getId());

            logger.info("用户提交试卷,随机码:" + randcode + ",试卷数据:" + examData);
            SystemQueue.USER_PAPER_QUEUE.add(examData);

            //------------不想单独写dao update数据方法了，用默认更新数据方法
            String pid = examData.get("pid").toString();
            String uid = UserUtils.getUser().getId();
            ExamHistory eh = examHistoryService.findList(new ExamHistory(pid,uid)).get(0);
            eh.setEndtime(new Date());
            eh.setStatus("1");
            this.examHistoryService.save(eh);
            //------------不想单独写dao update数据方法了，用默认更新数据方法
            //TODO 更合理的方法examHistoryService.updateEndtimeAndStatus(pid,uid);

            logger.info("用户提交试卷,随机码:" + randcode + ",提交结果:" + 1);
            return 1;
        } catch (Exception e) {
            logger.info("用户提交试卷失败,随机码:" + randcode);
            logger.error(e.getLocalizedMessage());
            return 0;
        }
    }
}
