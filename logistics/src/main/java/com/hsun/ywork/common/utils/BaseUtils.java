package com.hsun.ywork.common.utils;

import java.util.Random;

/**
 * Created by Administrator on 2017-03-08 .
 */
public class BaseUtils {
    public static String generateRandomString(int length) {
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();

        for(int i = 0; i < length; ++i) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }

        return sb.toString();
    }
}
