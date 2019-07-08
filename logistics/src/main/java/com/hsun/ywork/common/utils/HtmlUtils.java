package com.hsun.ywork.common.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by GeCoder on 2016-12-29 .
 */
public class HtmlUtils {
    public static String Html2TextFormat(String inputString) {
        String htmlStr = inputString;
        String textStr = "";

        try {
            String e = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>";
            String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>";
            String regEx_html = "<[^>]+>";
            Pattern p_script = Pattern.compile(e, 2);
            Matcher m_script = p_script.matcher(htmlStr);
            htmlStr = m_script.replaceAll("");
            Pattern p_style = Pattern.compile(regEx_style, 2);
            Matcher m_style = p_style.matcher(htmlStr);
            htmlStr = m_style.replaceAll("");
            Pattern p_html = Pattern.compile(regEx_html, 2);
            Matcher m_html = p_html.matcher(htmlStr);
            htmlStr = m_html.replaceAll("");
            textStr = htmlStr;
        } catch (Exception var12) {
            System.err.println("Html2Text: " + var12.getMessage());
        }

        return textStr;
    }
}
