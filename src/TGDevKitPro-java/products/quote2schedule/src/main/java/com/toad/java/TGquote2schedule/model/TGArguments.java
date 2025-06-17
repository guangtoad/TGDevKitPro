package com.toad.java.TGquote2schedule.model;

import com.toad.java.AppMain;
import org.kohsuke.args4j.Argument;
import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.Option;
import org.yaml.snakeyaml.composer.Composer;
import org.yaml.snakeyaml.parser.ParserImpl;
import org.yaml.snakeyaml.reader.StreamReader;

import java.io.File;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

public class TGArguments<T> {
    /**
     * 此字段主要用于容纳可能被多解析出来的无效的指令
     */
    @Argument
    public List<String> arguments = new ArrayList<>();
    /** *************************** 通过{@link Option}注解，将启动指令中的参数与此模型的字段关联起来 *************************** */
    @Option(name = "--config"
            , aliases = {"-c"}
            , metaVar = "<Config file>"
            , usage = "设定配置使用配置文件"
            , forbids = {"--output"}
            , depends = {"-output"}
    )
    public String config = AppMain.getLocationPath() + File.separator +  "TGConfig.yaml";

    @Option(name = "--output"
            , aliases = {"-o"}
            , metaVar = "<Output directory>"
            , usage = "输出路径"
            )
    public String output =  AppMain.getLocationPath() + File.separator +  "out";

    @Option(name = "--intput", aliases = {"-i"}, metaVar = "<Intput file>",usage = "输入文件路径")
    public String intput;

    @Option(name = "--debug", aliases = {"-d"}, metaVar ="[true|false]", usage = "是否开启调试模式" )
    public boolean debug = false;

    @Option(name = "--helper", aliases = {"-h"}, usage = "", help = true)
    public boolean helper;

    @Option(name = "--version", aliases = {"-v"}, usage = "", help = true)
    public Boolean getVersion = false;

//    @Option(name = "--test",required = true)
//    public String asdasd;

    static private Object loadFromReader(String[] args, Class<?> type) throws Exception{
        Object bean = type.newInstance();
        // Object bean = type.getDeclaredConstructor().newInstance();
        CmdLineParser cmdLineParser = new CmdLineParser(bean);
        try {
            cmdLineParser.parseArgument(args);
        } catch (CmdLineException e) {
            new CmdLineParser(type.newInstance()).printUsage(System.out);
            throw e;
        }
        return bean;
    }

    public void printUsage(){
        new CmdLineParser(this).printUsage(System.out);
    }
    static public <T> T loadAs(String[] args, Class<?> type) throws Exception{
        return (T) loadFromReader( args,  type);
    }

}
