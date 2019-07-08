package com.hsun.ywork.common.utils;

import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by GeCoder on 2017-03-08 .
 */
public class SystemQueue {
    public static Queue<Map<String, Object>> USER_PAPER_QUEUE = new ConcurrentLinkedQueue();

    public SystemQueue() {
    }
}
