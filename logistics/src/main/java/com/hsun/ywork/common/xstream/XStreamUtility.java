package com.hsun.ywork.common.xstream;

import com.thoughtworks.xstream.XStream;

/**
 * Created by GongXunyao on 2015/12/29.
 */
public class XStreamUtility {

    private static final XStream xStream = XStreamFactory.getXStream ();

    /**
     * Javabean 转XML
     * @param t 待转javabean对象
     * @param <T>
     * @return xml字符串
     */
    public static <T> String toXml(T t){
        return xStream.toXML ( t );
    }

    /**
     * XML字符串转javabean
     * @param xmlStr xml字符串
     * @param <T>
     * @return Java对象
     */
    public static <T> T toJavaBean(String xmlStr){
        return (T) xStream.fromXML ( xmlStr);
    }
}