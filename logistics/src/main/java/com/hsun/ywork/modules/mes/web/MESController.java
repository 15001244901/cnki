package com.hsun.ywork.modules.mes.web;

import com.hsun.ywork.common.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017-04-18 .
 */
@Controller
@RequestMapping(value = "/")
public class MESController extends BaseController{

    @RequestMapping("Handler")
    @ResponseBody
    public Object getMESBarcode(String action , String BarcodeList , String SN, HttpServletRequest request) {
        Map ret = new HashMap();
        if("BarcodeInfoRequest".equals(action)) {
            BarcodeReqResponse data = new BarcodeReqResponse();
            try {
                data.setSerialNoDetected(true);
                data.setSerialNo("SN12373873982398");
                data.setOK(true);
                data.setLabelTypeCount(2);
                data.setMessage("允许作业");

                List<String> list = gson.fromJson(BarcodeList, List.class);
                logger.info("列表数据为："+list.size()+list.toString());
                if("aaaa".equals(list.get(0))) {
                    data.setSerialNoDetected(false);
                    data.setMessage("重新读取条码再请求，最多三次！");
                }

                if("bbbb".equals(list.get(0))) {
                    data.setOK(false);
                    data.setMessage("此卷不允许包装（前工序作业异常或MES异常），");
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
                data.setOK(false);
                data.setMessage("此卷不允许包装（前工序作业异常或MES异常），异常信息为：" + e.getMessage());
                e.printStackTrace();
            } finally {
                return this.getJSONOrJSONPString(request, data);
            }
        } else if("GotLabel1".equals(action)) {
            ret.put("success",true);
            ret.put("msg","请求Label1成功！");
            ret.put("requestParam",request.getParameterMap());
            return this.getJSONOrJSONPString(request, ret);
        } else if("GotLabel2".equals(action)) {
            ret.put("success",true);
            ret.put("msg","请求Label2成功！");
            ret.put("requestParam",request.getParameterMap());
            return this.getJSONOrJSONPString(request, ret);
        } else {
            return null;
        }
    }
}
