package com.toad.java;

import com.toad.java.TGquote2schedule.Config;
import com.toad.java.TGquote2schedule.TGquote2schedule;
import com.toad.java.TGquote2schedule.model.TGArguments;
import com.toad.java.TGquote2schedule.uitl.TGUitl;
import com.toad.java.TGquote2schedule.uitl.command.TGUitlCommand;
import org.yaml.snakeyaml.Yaml;

import java.io.*;

public class AppMain extends TGUitl {
    public static Config buildConfig(String Path) throws FileNotFoundException {
        Yaml yaml = new Yaml();
        File yamlFile = new File(Path);
        TGUitlCommand.coutLine("读取配置文件：" + yamlFile.getAbsolutePath().toString());
        FileReader fileReader = new FileReader(yamlFile);
        Config config = yaml.loadAs(fileReader, Config.class);
        return config;
    }
    public static String helpertext(){
        return " -i,--input              输入文件路径\n" +
                " -o,--output <dir>       输出路径\n" +
                " -c,--config             配置文件路径";
    }
    public static String getLocationPath(){
        try {
            String thisPath = new AppMain().getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
            thisPath = java.net.URLDecoder.decode(thisPath, "UTF-8");
            File tempfile = new File(thisPath);
            thisPath = tempfile.getParent();
            return tempfile.getParent();
        }
        catch (Exception e){

        }
        return "";
    }

    public static void main(String[] args) {
        try{

            TGArguments arguments = TGArguments.loadAs(args, TGArguments.class);
            if (arguments.helper) {
                arguments.printUsage();
                return;
            }
            else if (arguments.getVersion) {
                return;
            }

            String resourceSettingPath = "/setting/TGSetting.yaml";
            InputStream inputStream = new AppMain().getClass().getResourceAsStream(resourceSettingPath);
            if (null != inputStream){
//                TGUitlCommand.coutLine("读取内部配置：");
//                InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
//                BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
//                String line = null;
//                while ((line = bufferedReader.readLine()) != null) {
//                    TGUitlCommand.coutLine(line);
//                }
//                bufferedReader.close();
//                inputStreamReader.close();
            }
            else {
                throw new Exception("配置文件找不到了：" + resourceSettingPath);
            }

            Yaml yaml = new Yaml();
            String thisPath = new AppMain().getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
            thisPath = java.net.URLDecoder.decode(thisPath, "UTF-8");
            File tempfile = new File(thisPath);
            thisPath = tempfile.getParent();
            File yamlFile = new File(thisPath + File.separator + "setting/TGSetting.yaml");
            TGUitlCommand.coutLine("读取配置文件：" + yamlFile.getAbsolutePath().toString());
            FileReader fileReader = new FileReader(yamlFile);
            Config config = yaml.loadAs(fileReader, Config.class);
            if (null == config.quotePath || config.quotePath.length() < 1){
                config.quotePath = thisPath + File.separator + "output";
            }
            if (args.length > 0){
                for (int i = 0; i < args.length; i++ ) {
                    String argc = args[i];
                    System.out.println(argc);
                    switch(argc.toLowerCase()) {
                        case "--endrow":
                        case "-e":{
                            if (!(++i < args.length)) throw new Exception();
                            String inputStr = args[i];
                            int endrow = Integer.parseInt(inputStr);
                            config.endrow = endrow;
                        }
                        break;
                        case "--beginrow":
                        case "-b":{
                            if (!(++i < args.length)) throw new Exception();
                            String inputStr = args[i];
                            int beginrow = Integer.parseInt(inputStr);
                            config.beginrow = beginrow;
                        }
                        break;
                        case "--config":
                        case "-c":{
                            if (!(++i < args.length)) throw new Exception();
                            String inputStr = args[i];
                            TGUitlCommand.coutLine("读取配置文件：" + inputStr);
                            config = buildConfig(args[i]);
                        }
                        break;
                        case "--file":
                        case "-f":{
                            if (!(++i < args.length)) throw new Exception();
                            config.quotePath = args[i];
                        }
                        break;
                        case "--out":
                        case "-o":{
                            if (!(++i < args.length)) throw new Exception();
                            config.outputPath = args[i];
                        }
                        break;
                        case "--help":
                        case "-h":{
                            TGUitlCommand.coutLine(helpertext());
                        }
                        return;
                        default: {

                        }
                        break;
                    }
                }
            }
            TGquote2schedule tGquote2schedule = new TGquote2schedule(config);
            tGquote2schedule.run();
        }
        catch (Exception e){
            TGUitlCommand.coutLine("异常：" + e);
        }
    }
}
