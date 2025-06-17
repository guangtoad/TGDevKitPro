//package com.toad.command;
//
//import com.google.gson.Gson;
//import com.thoughtworks.xstream.XStream;
//import com.toad.command.util.TGCommandInterface;
//import org.apache.commons.io.FilenameUtils;
//import org.yaml.snakeyaml.Yaml;
//
//import java.io.*;
//import java.security.AlgorithmParameters;
//
//public class AppMain extends TGCommandAppMain implements TGCommandInterface {
//
//    static public AppMain appMain;
//
//    public static String GetLocationPath() throws Exception{
//        if (null == appMain) {
//            throw new Exception("Main app is null");
//        }
//        return appMain.getLocationPath();
//    }
//
//     public void fileWirte(){
//        try {
//            String msg = "msgmsgmsgmsg";
//            String filePath = "/Users/toad/Desktop/out/testlog.log";
//            File logFile = new File(filePath);
//            if (!logFile.exists()){
//                logFile.createNewFile();
//            }
//
//
//            FileWriter fileWriter = new FileWriter(logFile,true);
//            PrintWriter printWriter = new PrintWriter(fileWriter);
//
//            printWriter.println(msg);
//            printWriter.flush();
//            fileWriter.flush();
//        }
//        catch (Exception a){
//            TGLog.Info("E:\n");
//        }
//
//    }
//    public ToolConfig loadConfig(File configFile, String fileExtension) throws Exception{
//        if (!configFile.exists()) {
//            throw new Exception("配置文件不存在：" + configFile.getPath());
//        }
//        ToolConfig config = null;
//        FileReader fileReader = new FileReader(configFile);
//        switch (fileExtension) {
//            case "yaml":
//                Yaml yaml = new Yaml();
//                config = yaml.loadAs(fileReader, ToolConfig.class);
//                break;
//            case "json":
//                Gson gson = new Gson();
//                config = gson.fromJson(fileReader, ToolConfig.class);
//                break;
//            case "xml":
//                XStream xStream = new XStream();
//                xStream.alias("config", ToolConfig.class);
//                config = (ToolConfig) xStream.fromXML(fileReader);
//                break;
//            default:
//                throw new Exception("未知配置文件类型：" + fileExtension);
//                // return;
//        }
//        return config;
//    }
//
//    public ToolConfig loadConfig(String configFilePath) throws Exception{
//        String fileExtension = FilenameUtils.getExtension(configFilePath);
//        File configFile = new File(configFilePath);
//        return loadConfig(configFile, fileExtension);
//    }
//
//    public void run(String[] args){
//
//        TGLog.Info("执行-开始");
//        try {
//            String configFilePath = null;
//            if (null != args && args.length > 0) {
//                TGCommandArguments arguments = TGCommandArguments.loadAs(args, TGCommandArguments.class);
//                if (arguments.helper) {
//                    arguments.printUsage();
//                    return;
//                }
//                else if (arguments.getVersion) {
//                    return;
//                }
//                if (null != arguments.configFilePath) {
//                    configFilePath = arguments.configFilePath;
//                }
//            }
//
//            ToolConfig config = null != configFilePath ? loadConfig(configFilePath) : new ToolConfig();
//            if (null == config) {
//                throw new Exception("程序设置加载失败");
//            }
//
//        }
//        catch (Exception e) {
//            TGLog.Error("异常：\n" + e);
//        }
//        finally {
//            TGLog.Info("执行-结束");
//        }
//    }
//
//    public void run(){
//        run(null);
//    }
//
//    public static void main(String[] args) {
//        TGDateUtil.isSameWeek("2022/12/31","2023/01/01");
//        TGDateUtil.isSameWeek("2022/10/01","2022/10/02");
//        TGDateUtil.testRun();
//        //明文
//        String plainTextString = "Hello,Bouncy Castle";
//        System.out.println("明文 : "+plainTextString);
//        byte[] key;
//        try {
//            String aaa = EncryptUtils.encryptAES("asdasd");
//            String bbb = EncryptUtils.decryptAES(aaa);
////            //初始化密钥
//////            key = AAESUtils.generateKey();
////            key = "db16a7eee539e93edb16a7eee539e93e".getBytes("UTF-8");
////            //初始化iv
////            AlgorithmParameters iv = AAESUtils.generateIV();
////            System.out.println("密钥 : ");
////            //打印密钥
////            for (int i = 0; i < key.length; i++) {
////                System.out.printf("%x", key[i]);
////            }
////            System.out.println();
////
////            //进行加密
////            byte[] encryptedData = AAESUtils.encrypt(plainTextString.getBytes(), key,iv);
////            //输出加密后的数据
////            System.out.println("加密后的数据 : ");
////            for (int i = 0; i < encryptedData.length; i++) {
////                System.out.printf("%x", encryptedData[i]);
////            }
////            System.out.println();
////
////            //进行解密
////            byte[] data = AAESUtils.decrypt(encryptedData, key,iv);
////            System.out.println("解密得到的数据 : " + new String(data));
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
////        try {
////            String decryptStr = AAESUtils.decrypt("AA", "BB", "032B8B0A090BAE3C","UTF-8");
////            System.out.println("decryptStr:\n" + decryptStr);
//////            AAESUtils.encrypt("AA", "bbb");
////        }
////        catch (Exception e){
////            System.out.println("Exc:\n" + e);
////        }
////        appMain = new AppMain();
////        appMain.fileWirte();
////        appMain.run(args);
//    }
//}
