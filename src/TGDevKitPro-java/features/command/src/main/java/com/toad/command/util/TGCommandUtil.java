//package com.toad.command.util;
//
//public class TGCommandUtil {
//    /**
//     * 按行读取输入流第一行文字.
//     *
//     * @param disp    要显示的文字
//     * @param maxByte 缓冲区大小：128～4096
//     * @return 用户数据
//     * @throws Exception 不应定啥异常
//     */
//    public static String readLine(String disp,int maxByte) throws Exception {
//        try {
//            System.out.print(disp);
//            byte[] input = new byte[Math.min(Math.max(128, maxByte), 4096)];
//            System.out.println();
//            System.in.read(input);
//            String s = new String(input);
//
//            String[] sa = s.split("\r\n");
//            if (sa.length > 0) {
//                return  sa[0];
//            }
//            sa = s.split("\r\n");
//            if (sa.length > 0) {
//                return  sa[0];
//            }
//            sa = s.split("\n\n");
//            if (sa.length > 0) {
//                return  sa[0];
//            }
//        }
//        catch (Exception exc) {
//            throw exc;
//        }
//        return null;
//    }
//    /**
//     * 按行读取输入流第一行文字.
//     * 缓冲区默认大小2048
//     * @param disp    要显示的文字
//     * @return 用户数据
//     * @throws Exception 不应定啥异常
//     */
//    public static String readLine(String disp) throws Exception{
//        return readLine(disp,2048).replaceAll(System.lineSeparator(), "").trim();
//    }
//    /**
//     * 按行读取输入流第一行文字.
//     * 缓冲区默认大小2048
//     * @return 用户数据
//     * @throws Exception 不应定啥异常
//     */
//    public static void coutLine(String msg){
//        System.out.println(msg + "");
//    }
//
//
//}
