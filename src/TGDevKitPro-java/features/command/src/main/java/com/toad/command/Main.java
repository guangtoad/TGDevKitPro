//package com.toad.command;
//
//import com.toad.java.tool.bsSprict.BSCConfig;
//import com.toad.java.tool.bsSprict.BSCException;
//import com.toad.java.tool.bsSprict.BSCTool;
//import com.toad.devkit.common.util .TGStringUtil;
//import java.io.File;
//import java.io.IOException;
//
///**
// * The type Main.
// */
//public class Main {
//
//    /**
//     * 判断文件夹是否纯在
//     *
//     * @param path the path 路径
//     * @return the boolean
//     */
//    public static Boolean existDir(String path){
//        File file = new File(path);
//        return file.exists() && file.isDirectory();
//    }
//
//
//    /**
//     * 比较文件.
//     */
//    public static void diffFiles(){
//        int step = 0;
//        BSCTool bsct = new BSCTool();
//        String out = bsct.out;
//        String diffPath = null;
//        while (true) {
//            try {
//                switch (step){
//                    case 0:{
//                        System.out.println("");
//                        String s = readLine("\n之前生成的files.diff.txt文件在哪:");
//                        if (!TGStringUtil.isEmpty(s)) {
//                            File file = new File(s);
//                            if (file.exists()) {
//                                throw new BSCException("文件不存在");
//                            }
//                            if (file.isDirectory()) {
//                                throw new BSCException("这是个路径");
//                            }
//                            diffPath = s;
//                        }
//                    }
//                    break;
//                    case 1:{ String s = readLine("\n输出到哪这个可以不输:");
//                        if (!TGStringUtil.isEmpty(s)) {
//                            if (!existDir(s)) {
//                                throw new BSCException("输入就给正确路径");
//                            }
//                            out = s;
//                        }
//                    }
//                    break;
//                    case 2:{
//                        bsct.out = out;
//                        if (null == diffPath) {
//                            File file = new File(bsct.out);
//                            diffPath = file.getCanonicalPath() + File.separator + "files.diff.txt";
//                        }
//                        else {
//
//                        }
//                        String s = readLine("\n使用的diff文件:" + diffPath  + "\n临时文件报告啥的输出到:" + out + "\n随便输入点啥继续");
//                        bsct.readDirDiffTxt(diffPath);
//                        return;
//                    }
//                    default:{
//                        System.out.println("不知道你干啥了");
//                        return;
//                    }
//                }
//                step++;
//            }
//            catch (BSCException exc){
//                System.out.println(exc.getMessage());
//            }
//            catch (Exception exc) {
//
//            }
//        }
//    }
//
//    /**
//     * 比较文件夹 .
//     */
//    public static void diffDir() {
//
//        int step = 0;
//        BSCTool bsct = new BSCTool();
//
//        String left = "";
//        String right = "";
//        String out = TGConfig.getInstance().bscConfig.out;;
//        while (true) {
//            try {
//                switch (step){
//                    case 0:{
//                        String s = readLine("\n左边的用啥:输入:");
//                        if (TGStringUtil.isEmpty(s)) {
//                            throw new BSCException("输入的啥呀");
//                        }
//                        if (!existDir(s)) {
//                            throw new BSCException("路径不对");
//                        }
//                        left = s;
//                    }
//                    break;
//                    case 1:{
//                        String s = readLine("\n右边的用啥:输入:");
//                        if (TGStringUtil.isEmpty(s)) {
//                            throw new BSCException("输入的啥呀");
//                        }
//                        if (!existDir(s)) {
//                            throw new BSCException("路径不对");
//                        }
//                        right = s;
//                    }
//                    break;
//                    case 2:{
//                        String s = readLine("\n dir.sprict.txt 输出路径这个可以不输默认输出到:" + out);
//                        if (!TGStringUtil.isEmpty(s)) {
//                            if (!existDir(s)) {
//                                throw new BSCException("输入就给正确路径");
//                            }
//                            out = s;
//                        }
//                        break;
//                    }
//                    case 3:{
//                        String s = readLine("\n左边的用:" + left
//                                + "\n右边的用：" + right
//                                + "\n临时文件报告啥的输出到:" + out + File.pathSeparator
//                                + "\n随便输入点啥继续");
//                        bsct.left = left;
//                        bsct.right = right;
//                        bsct.out = out;
//                        bsct.diffDir();
//                        return;
//                    }
//                    default:{
//                        System.out.println("不知道你干啥了");
//                        return;
//                    }
//                }
//                step++;
//            }
//            catch (BSCException exc){
//                System.out.println(exc.getMessage());
//            }
//            catch (Exception exc) {
//
//            }
//        }
//    }
//
//    /**
//     * 按行读取输入流第一行文字.
//     *
//     * @param disp    要显示的文字
//     * @param maxByte 缓冲区大小：128～4096
//     * @return 用户数据
//     * @throws Exception 不应定啥异常
//     */
//    public static String readLine(String disp,int maxByte) throws Exception {
//
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
//
//    /**
//     * The entry point of application.
//     *
//     * @param args the input arguments
//     * @throws IOException the io exception
//     */
//    public static void main(String[] args) throws IOException {
//        try {
//            System.out.println("初始化");
//            String thisPath = new Main().getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
//            thisPath = java.net.URLDecoder.decode(thisPath, "UTF-8");
//            File file = new File(thisPath);
//            thisPath = file.getParent();
//            File configPath = new File(thisPath + File.separator +TGConfig.getConfigFileName());
//            TGConfig.getInstance().readConfig(configPath);
//            if (args.length > 0){
//                for (int i = 0; i < args.length; i++ ) {
//                    String argc = args[i];
//                    System.out.println(argc);
//                    switch(argc.toLowerCase()) {
//                        case  "--debug":
//                        case "--version":
//                        case "--left":
//                            break;
//                        case "--right": {
//                            if (!(++i < args.length)) throw new Exception();
//                        }
//                        break;
//                        case "--config":{
//                            if (!(++i < args.length)) throw new Exception();
//                            TGConfig config = TGConfig.getInstance();
//                        }
//                        break;
//                        case "--type": {
//                            if (!(++i < args.length)) throw new Exception();
//                        }
//                        case "--out": {
//                            if (!(++i < args.length)) throw new Exception();
//                        }
//                        break;
//                        default: {
//
//                        }
//                        break;
//                    }
////                BSCTool bsct = new BSCTool();
//                }
//            }
//        }
//        catch (Exception e) {
//            System.out.println(e);
//        }
//        if (0 == args.length) {
//            int step = 0;
//            while (true) {
//                try {
//                    switch (step) {
//                        case 0:
//                            String s = readLine("\n干嘛？\n1.创建文件加比较\n2.创建文件比较列表\n输入:");
//                            if (!TGStringUtil.isEmpty(s)) {
//                                int i = Integer.parseInt(s);
//                                switch (i) {
//                                    case 1:
//                                        diffDir();
//                                        break;
//                                    case 2:
//                                        diffFiles();
//                                        break;
//                                    default:
//                                        System.out.println("暂时没有这个:" + s);
//                                        break;
//                                }
//                            }
//                            break;
//                        default:
//                            System.out.println("\n拜拜。。、\n");
//                            break;
//                    }
//                }
//                catch (NumberFormatException exc){
//                    System.out.println("输入错误");
//                    System.out.println(exc);
//                }
//                catch (Exception exc){
//                    System.out.println("输入错误");
//                    System.out.println(exc);
//                }
//            }
//        }
//        else {
//
//        }
//    }
//}
