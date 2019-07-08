package com.hsun.ywork.modules.mes.web;

/**
 * @Author: GeCoder
 * @Description: TODO
 * @Date: 15:43 2018-04-25
 * @ModifyBy: GeCoder
 */
public class BarcodeReqResponse {

    /// <summary>
    /// 流水号是否检测到
    /// </summary>
    public boolean SerialNoDetected;

    /// <summary>
    /// 流水号
    /// </summary>
    public String SerialNo;

    /// <summary>
    /// 允许作业
    /// </summary>
    public boolean IsOK;

    /// <summary>
    /// 标签种类
    /// </summary>
    public int LabelTypeCount;

    /// <summary>
    /// 异常消息
    /// </summary>
    public String Message;

    public boolean isSerialNoDetected() {
        return SerialNoDetected;
    }

    public void setSerialNoDetected(boolean serialNoDetected) {
        SerialNoDetected = serialNoDetected;
    }

    public String getSerialNo() {
        return SerialNo;
    }

    public void setSerialNo(String serialNo) {
        SerialNo = serialNo;
    }

    public boolean isOK() {
        return IsOK;
    }

    public void setOK(boolean OK) {
        IsOK = OK;
    }

    public int getLabelTypeCount() {
        return LabelTypeCount;
    }

    public void setLabelTypeCount(int labelTypeCount) {
        LabelTypeCount = labelTypeCount;
    }

    public String getMessage() {
        return Message;
    }

    public void setMessage(String message) {
        Message = message;
    }
}
