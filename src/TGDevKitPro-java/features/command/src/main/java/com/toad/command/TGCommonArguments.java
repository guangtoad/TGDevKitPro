//package com.toad.command;
//
//import org.kohsuke.args4j.CmdLineException;
//import org.kohsuke.args4j.CmdLineParser;
//import org.kohsuke.args4j.Option;
//
//public class TGCommonArguments<T>  {
//    @Option(name = "--version", aliases = {"-v"}, usage = "", help = true)
//    public Boolean getVersion = false;
//    @Option(name = "--help", aliases = {"-h"}, usage = "", help = true)
//    public Boolean pringHelp = false;
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
//    static public <T> T loadAs(String[] args, Class<?> type) throws Exception{
//        return (T) loadFromReader( args,  type);
//    }
//}
