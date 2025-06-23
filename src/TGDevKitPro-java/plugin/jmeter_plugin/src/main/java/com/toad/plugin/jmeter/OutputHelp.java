package com.toad.plugin.jmeter;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

//import com.opencsv.CSVWriter;

//import com.fasterxml.jackson.dataformat.csv.CsvMapper;

public class OutputHelp {

    /**
     * 输出格式
     */
    OutputStyle style;

    String Path;
    String fileName;

    protected Map<String,Object> dataMap;

    private final static OutputHelp INSTANCE = new OutputHelp();
    public OutputHelp(){
        dataMap = new HashMap<>();
    }
    /**
     * @return 获取单例
     */
    public static OutputHelp getInstance(){
        return INSTANCE;
    }
    protected void initDefaultSetting(){
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateString = formatter.format(date);
        this.fileName = dateString;
    }
    public OutputHelp setupDefaultSetting(){
        this.initDefaultSetting();
        return this;
    }
    public OutputHelp setFileName(String fileName){
        this.fileName = fileName;
        return this;
    }

    public void saveToFile(String fileName,final List<String[]> data){
//        CSVWriter writer = null;
//        try {
//            // 创建文件所在目录
//            FileOutputStream fileOutputStream = new FileOutputStream(fileName);
//            fileOutputStream.write(0xef); //加上这句话
//            fileOutputStream.write(0xbb); //加上这句话
//            fileOutputStream.write(0xbf); //加上这句话
//            writer = new CSVWriter(new OutputStreamWriter(fileOutputStream, StandardCharsets.UTF_8.name()), CSVWriter.DEFAULT_SEPARATOR, CSVWriter.NO_QUOTE_CHARACTER, CSVWriter.DEFAULT_ESCAPE_CHARACTER, CSVWriter.DEFAULT_LINE_END);
//            writer.writeAll(data);
//        } catch (Exception e) {
//            System.out.println("将数据写入CSV出错："+e);
//        } finally {
//            if (null != writer) {
//                try {
//                    writer.flush();
//                    writer.close();
//                } catch (IOException e) {
//                    System.out.println("关闭文件输出流出错："+e);
//                }
//            }
//        }
    }

    public String getCSVTxt(){
        StringBuilder stringBuilder = new StringBuilder();
        this.dataMap.get("");
        return "aaaa";
    }

    public void addObjectTo(Object object, String... keys) {
        if (keys.length > 0) {

        }
        for (int i = 1;i < keys.length;i++) {
            String key = keys[i];
        }
        return;
    }

}
