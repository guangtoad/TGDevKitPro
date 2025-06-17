//package com.toad.command;
//
//import org.kohsuke.args4j.Argument;
//import org.kohsuke.args4j.CmdLineException;
//import org.kohsuke.args4j.CmdLineParser;
//import org.kohsuke.args4j.Option;
//
//import java.util.ArrayList;
//import java.util.List;
//
//public class CommandApplication {
//
//    /**
//     * 此字段主要用于容纳可能被多解析出来的无效的指令
//     */
//    @Argument
//    public List<String> arguments = new ArrayList<>();
//    /** *************************** 通过{@link Option}注解，将启动指令中的参数与此模型的字段关联起来 *************************** */
//    @Option(name = "--config-file"
//            , aliases = {"-c-f"}
//            , metaVar = "<Config file [yaml|json|xml]>"
//            , usage = "设定配置使用配置文件"
////            , forbids = {"--output"}
////            , depends = {"-output"}
//    )
//    public String configFilePath;//= AppMain.getLocationPath() + File.separator +  "TGConfig.yaml";
//
//    @Option(name = "--output"
//            , aliases = {"-o"}
//            , metaVar = "<Output directory>"
//            , usage = "输出路径"
//    )
//
//    public String output;
////    public String output =  AppMain.getLocationPath() + File.separator +  "out";
//
//    @Option(name = "--intput", aliases = {"-i"}, metaVar = "<Intput file>",usage = "输入文件路径")
//    public String intput;
//
//    @Option(name = "--debug", aliases = {"-d"}, metaVar ="[true|false]", usage = "是否开启调试模式" )
//    public boolean debug = false;
//
//    @Option(name = "--helper", aliases = {"-h"}, usage = "", help = true)
//    public boolean helper;
//
//    @Option(name = "--version", aliases = {"-v"}, usage = "", help = true)
//    public Boolean getVersion = false;
//
////    @Option(name = "--test",required = true)
////    public String asdasd;
//
//    static private Object loadFromReader(String[] args, Class<?> type) throws Exception{
//        Object bean = type.newInstance();
//        // Object bean = type.getDeclaredConstructor().newInstance();
//        CmdLineParser cmdLineParser = new CmdLineParser(bean);
//        try {
//            cmdLineParser.parseArgument(args);
//        } catch (CmdLineException e) {
//            new CmdLineParser(type.newInstance()).printUsage(System.out);
//            throw e;
//        }
//        return bean;
//    }
//
//    public void printUsage(){
//        new CmdLineParser(this).printUsage(System.out);
//    }
//    static public <T> T loadAs(String[] args, Class<?> type) throws Exception{
//        return (T) loadFromReader( args,  type);
//    }
//
//    public static void main(String[] args) {
//
//    }
//
//}
