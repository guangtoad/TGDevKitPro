//package com.toad.command.util;
//
////import com.toad.TGExcelUtil.FCH.CTReportUtil;
////import com.toad.TGExcelUtil.FCH.PTSytle;
////import com.toad.TGExcelUtil.FCH.PTUtil;
//
//import java.util.List;
//
////import org.apache.commons.c
//public class AppMain {
//    public static void main(String[] args) {
//        try {
////            String[] testStrs = {"ad"
////                    ,"absdfSR"
////            ,"SRADASDS"
////                    ,"asdasSRADASDS"};
////
////            for (String str: testStrs
////                 ) {
////                System.out.println("结果" + (str.startsWith("SR") ? "YES" : "NO"));
////            }
////            "asdasd".contains("SR");
////            "asSRsd".contains("SR");
////            TGExcelUtil tgExcelUtil = new TGExcelUtil();
////            String filePath = "/Users/toad/MyWork/Fujitsu/Template/PT实名认证Template.xlsx";
////            String sheetName = "变更履历";
////            tgExcelUtil.readEx(filePath,sheetName);
//
//            String templatePath = "/Users/toad/MyWork/Fujitsu/Template/PT实名认证Template.xlsx";
////            PTUtil ptUtil =  new PTUtil();
////            ptUtil.createReport(new PTSytle(),templatePath);
//
////            CTReportUtil ctReportUtil = new CTReportUtil();
////            ctReportUtil.createReport(new PTSytle(),templatePath);
////            ptUtil.createReport(new PTSytle());
//        }
//        catch (Exception e){
//            System.out.println(e);
//        }
//////option的容器
////
////        Options options = new Options();
////
//////boolean型的option
////
////        options.addOption("help",false,"help information");
////
//////当第二参数是true时，可以是这样的参数 -O4
////
////        options.addOption("O",true,"you can set a value after the O");
////
////        Option c = Option.builder("c") //option的名字,判断的时候要使用这个名字
////
////                .required(false) //是否必须有这个选项
////
////                .hasArg() //带一个参数
////
////                .argName("filename") //参数的名字
////
////                .desc("return sum of characters") //描述
////
////                .build(); //必须有
////
//////将c这个option添加进去
////
////        options.addOption(c);
////
//////parser
////
////        CommandLineParser parser = new DefaultParser();
////
////        CommandLine cmd = parser.parse(options,args);
////
//////询问是否有help
////
////        if(cmd.hasOption("help")) {
////
//////调用默认的help函数打印
////
////            HelpFormatter formatter = new HelpFormatter();
////
////            formatter.printHelp( "java wordcount [OPTION] ", options );
////
////            return;
////
////        }
////
////        if(cmd.hasOption("c")){
////
////// 获得相应的选项(c)的参数
////
////            String filename = cmd.getOptionValue("c");
////
////            System.out.println(filename);
////
////// do something
////
////        }
//
//
//    }
//}
