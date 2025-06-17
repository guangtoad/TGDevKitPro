//package com.toad.utils.tgpict;
//
//
//import java.io.File;
//
//public class TGPICTMain {
//    public static final String helpString = "\n" +
//            "用法：java -jar <#jarPath#> \n" +
//            "\n" +
//            "\n" +
//            "参数介绍\n" +
//            "   --file,-f             文件路径 <#Path#>\n" +
//            "   --out,-o              输出路径 <#Path#>\n"  +
//            "   --type,-t             test:测试用例，all:所有\n" +
//            "   --text,-t             输入字符串\n" ;
//
//    public static void main(String[] args) {
//
//        try {
//            if (args.length ==  0){
//                throw new TGException();
//            }
//            String filePath = null;
//            String outPath = null;
//            String inputString = null;
//
//            for (int i = 0 ; i < args.length ; i++ ){
//                String str = args[i].toLowerCase();
//                switch (str.toLowerCase()) {
//                    case "--file":
//                    case "-f": {
//                        int index = (++i);
//                        if (index >= args.length) {
//                            throw new TGException().setErrorMessage("缺少文件参数");
//                        } else {
//                            filePath = args[index];
//                        }
//                    }
//                    break;
//                    case "--out":
//                    case "-o":
//                    {
//                        int index = (++i);
//                        if (index >= args.length) {
//                            throw new TGException().setErrorMessage("缺少文件参数");
//                        } else {
//                            outPath = args[index];
//                        }
//                    }
//                    break;
//                    case "--text":
//                    case "-t":
//                    {
//                        int index = (++i);
//                        if (index >= args.length) {
//                            throw new TGException().setErrorMessage("缺少文件参数");
//                        } else {
//                            inputString = args[index];
//                        }
//                    }
//                    break;
//                    default:
//                        break;
//                }
//            }
//
//            if (!TGStringUtils.isNullOrEmpty(filePath)){
//                File file = new File(filePath);
//                if (!file.exists()) {
//                    throw new TGException().setErrorMessage("文件不存在");
//                }
//
//                if (file.isDirectory()) {
//                    throw new TGException().setErrorMessage("这是个目录");
//                }
//
//                inputString = TGFileUtils.readFile(file);
//                if (TGStringUtils.isNullOrEmpty(inputString)){
//                    throw new TGException().setErrorMessage("文件内容读取失败");
//                }
//            }
//            else if (!TGStringUtils.isNullOrEmpty(inputString)){
//
//            }
//            else {
//                throw new TGException().setErrorMessage("参数错误");
//            }
//
//            TGPICT pict;
//            pict = new TGPICT();
//            String outStr = pict.createPICTStr(inputString);
//
//            if (TGStringUtils.isNullOrEmpty(outPath)) {
//                System.out.println(outStr);
//            }
//            else {
//                throw new TGException().setErrorMessage("输出目录错误");
//            }
//        }
//        catch (TGException exc){
//            System.out.println(exc.getErrorMessage());
//            System.out.println(helpString);
//        }
//        catch (Exception exc){
//            System.out.println(helpString);
//        }
//
//    }
//}
