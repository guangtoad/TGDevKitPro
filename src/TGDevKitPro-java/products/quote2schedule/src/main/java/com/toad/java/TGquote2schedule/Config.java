package com.toad.java.TGquote2schedule;

import org.kohsuke.args4j.Option;

import java.util.List;

@SuppressWarnings("all")
public class Config {

    @Option(name = "--config", aliases = {"-c"}, usage = "开始的行数")
    public String configPath;
    @Option(name = "--quote", aliases = {"-q"}, usage = "报价路径")
    public String quotePath;
    @Option(name = "--sheet", aliases = {"-s"}, usage = "页名称")
    public String sheetName = "1.1 見積詳細";
    @Option(name = "--begin", aliases = {"-b"}, usage = "开始的行数")
    public int beginrow = 10;
    @Option(name = "--end", aliases = {"-e"}, usage = "结束行数")
    public int endrow = 10000;
    @Option(name = "--type", aliases = {"-t"}, required = false, usage = "导出类型")
    public String outputType;
    @Option(name = "--outputPath", aliases = {"-o"}, required = false, usage = "导出路径")
    public String outputPath = "csv";
    @Option(name = "--min", usage = "最小列数")
    public String titleColumnMin = "C";
    @Option(name = "--max", usage = "最大列数")
    public String titleColumnMax = "G";

    public List<Assigned> frontwork;
    public List<Assigned> assigneds;
    public List<Assigned> postwork;
    public List<TaskInfo> otherTask;
    public String templatePath;
//    public Config(){
//
//    }
//    public Config(String filePath){
//
//    }
//
//    static public Config build(String path){
//        Config config = new Config(path);
//        return config;
//    }
//    static public Config build(){
//        return build("");
//    }
//

}
