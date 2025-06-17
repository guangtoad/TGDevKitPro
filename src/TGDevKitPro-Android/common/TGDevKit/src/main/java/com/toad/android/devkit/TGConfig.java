/*
 * *
 * @Description $description$
 * @Param $params$
 * @Return $returns$
 * @Author Mr.Ren
 * @Date $date$
 * @Time $time$
 * /
 */

package com.toad.android.devkit;
//
//import com.toad.java.tool.bsSprict.BSCConfig;
//import org.yaml.snakeyaml.Yaml;
//
//import java.io.File;
//import java.io.FileReader;
//
//public class TGConfig {
//    private static TGConfig instance = null;
//    public boolean isDebug;
//    public BSCConfig bscConfig = new BSCConfig();
//
//    public static String getConfigFileName(){
//        return "TGJavaConfig.yaml";
//    }
//    public boolean readConfig(String filePath){
//        File file = new File(filePath);
//        return this.readConfig(file);
//
//    }
//    public boolean readConfig(File file){
//        try {
//            System.out.println("读取配置文件：" + file.getPath());
//            if (file.exists()) {
//                Yaml yaml = new Yaml();
//                FileReader fileReader = new FileReader(file);
//                BSCConfig bscConfig = yaml.loadAs(fileReader, BSCConfig.class);
//                if (null != bscConfig) {
//                    this.bscConfig = bscConfig;
//                }
//                System.out.println("diffBeginRegex:" +this.bscConfig.diffBeginRegex);
//                System.out.println("diffLineRegex:" +this.bscConfig.diffLineRegex);
//                System.out.println("diffLineSuffixRegex:" +this.bscConfig.diffLineSuffixRegex);
//                System.out.println("diffLeftPrefixRegex:" +this.bscConfig.diffLeftPrefixRegex);
//                System.out.println("diffRigtPrefixRegex:" +this.bscConfig.diffLeftPrefixRegex);
//
//            }
//        }
//        catch (Exception e){
//            System.out.println(e);
//        }
//        return true;
//    }
//    public static TGConfig getInstance(){
//        if (null == instance){
//            instance = new TGConfig();
//        }
//        return instance;
//    }
//}
