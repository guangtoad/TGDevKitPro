/**
 * Project Name:cgcz
 * File Name:ShellUtils.java
 * Package Name:com.jarxiaobai.cgcz.utils
 * Date:2019年9月4日下午3:49:43
 * Copyright (c) 2019, chenzhou1025@126.com All Rights Reserved.
 *
 */

package com.toad.android.devkit.utils;

/**
 * ClassName:ShellUtils <br/>
 * Date:     2019年9月4日 下午3:49:43 <br/>
 * @author   jiaxiaobai
 * @version
 * @since    JDK 1.8
 * @see
 */
public class ShellUtils {
    /**
     *
     * @Description: 执行shell入口
     * @return
     * @throws Exception
     */
    public String executeShell() throws Exception {
        String script = "/data/tomcat/webapp/startTask.sh";
        System.out.println("shell脚本 【" + script + "】准备开始");
        try {
            // 执行脚本
            callScript(script);
            return "sucess";
        } catch (Exception e) {
            System.out.println("【" + script + "】命令执行异常：" + e.getMessage());
            return "faile";
        }
    }

    /**
     *
     * @Description: 执行脚本
     * @param script
     * @throws Exception
     */
    private void callScript(String script) throws Exception {
        String cmd = "sh " + script;

        // 启动独立线程
        CommandWaitForThread commandThread = new CommandWaitForThread(cmd);
        commandThread.start();

        System.out.println("shell脚本 【" + script + "】准备结束");
    }

    /**
     * 脚本函数执行线程
     * @author jiaxiaobai
     * @version 1.0
     * @since JDK1.8
     * @date 2019年9月4日 下午4:03:36
     */
    public class CommandWaitForThread extends Thread {
        private String cmd;
        private int exitValue = -1;

        public CommandWaitForThread(String cmd) {
            this.cmd = cmd;
        }

        public void run() {
            try {
                // 执行脚本
                Runtime.getRuntime().exec(cmd);
            } catch (Throwable e) {
                System.out.println("执行脚本出错，异常原因：" + e.getMessage());
                exitValue = 110;
            }
        }

        public int getExitValue() {
            return exitValue;
        }
    }
}
