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

package com.toad.java.tool.bsSprict;
import java.io.*;
import java.util.regex.*;
import java.util.ArrayList;
import java.util.List;

/**
 * The type Bsc tool.
 */
public class BSCTool {


    private static final String version = "0.0.0";

    /**
     * Gets version.
     *
     * @return the version
     */
    public static String getVersion() {
        return version;
    }

    /**
     * The Beyond compare path.
     */
    public String beyondComparePath = "";
    /**
     * The Left.
     */
    public String left = "";
    /**
     * The Right.
     */
    public String right = "";
    /**
     * The Filter.
     */
    public String filter = "*.h;*.m;*.mm;*.c;*.swift;*.xib;*.xml;*.plist;*.storyboard;*.json";
    /**
     * The Out.
     */
    public String out = "out";

    /**
     * The Dir diff txt name.
     */
    public String dirDiffTxtName = "dir.diff.txt";
    /**
     * The Dir diff sprict name.
     */
    public String dirDiffSprictName = "dir.sprict.txt";
    public String fileDiffSprictName = "files.sprict.txt";

    /**
     * Gets value.
     *
     * @return the value
     */
    public static String  getValue() {
        Runtime mt =Runtime.getRuntime();


        File  myfile =new File("d:\\b","ru.exe");
        String   path =myfile.getAbsolutePath();
        String[] cmd = {path};
        String content = "";
        try {
            //启动线程
            Process process = Runtime.getRuntime().exec(cmd);
            System.out.println("创建exe进程成功\n");
            //调用ConsleTestArea 里面的方法
            InputStream in=process.getInputStream();

            //<1>创建字节数组输出流，用来输出读取到的内容
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            //<2>创建缓存大小

            byte[] buffer = new byte[1024]; // 1KB
            //每次读取到内容的长度
            int len = -1;
            //<3>开始读取输入流中的内容
            while ((len = in.read(buffer)) != -1) { //当等于-1说明没有数据可以读取了
                baos.write(buffer, 0, len);   //把读取到的内容写到输出流中
            }
            //<4> 把字节数组转换为字符串
            content = baos.toString();
            System.out.println("结果："+content);
            in.close();
            baos.close();
        }
        catch(IOException e) {
            System.err.println("创建进程时出错\n" + e);
            System.exit(1);
        }
        return content;
    }

    /**
     * Run shell list.
     *
     * @param shStr the sh str
     * @return the list
     */
    public static List<String> runShell(String shStr) {
        List<String> strList = new ArrayList<String>();
        try {
            Process process = Runtime.getRuntime().exec(new String[]{"/bin/sh","-c",shStr},null,null);
            InputStreamReader ir = new InputStreamReader(process.getInputStream());
            LineNumberReader input = new LineNumberReader(ir);
            String line;
            process.waitFor();
            while ((line = input.readLine()) != null){
                strList.add(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return strList;
    }

    /**
     * Exec shell.
     *
     * @param shell the shell
     */
    public static void execShell(String shell){
        try {
            Runtime.getRuntime().exec(shell);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Exec shell bin.
     *
     * @param shell the shell
     */
    public static void execShellBin(String shell){
        try {
            Runtime.getRuntime().exec(new String[]{"/bin/sh","-c",shell},null,null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Abd.
     */
    public void abd(){
        File directory = new File("");//设定为当前文件夹

        try{
            System.out.println(directory.getCanonicalPath());//获取标准的路径
            System.out.println(directory.getAbsolutePath());//获取绝对路径
        }catch(Exception e){}
    }

    /**
     * Read dir diff txt.
     *
     * @param txtPath the txt path
     * @throws Exception the exception
     */
    public void readDirDiffTxt(String txtPath) throws Exception{
        File leftBase = null;
        File rightBase = null;
        File outPath = new File("out");
        if (!outPath.exists()) {
            outPath.mkdir();
        }
        File sprictFile = new File(outPath.getCanonicalPath() + File.separator + this.fileDiffSprictName);
        if (sprictFile.exists()) {
            sprictFile.delete();
        }
        sprictFile.createNewFile();
        System.out.println(sprictFile.getCanonicalPath());

        FileWriter sprictFileWritter = new FileWriter(sprictFile.getCanonicalPath(),true);

        /* 读取数据 */
        File file = new File(txtPath);
        BufferedReader reader = null;
        String tempString = null;
        int line =1;
        Boolean beginDiff = false;
        BSCTextReport textReport = new BSCTextReport();
        try {
            reader = new BufferedReader(new FileReader(file));
            while ((tempString = reader.readLine()) != null) {
                if (beginDiff) {
                    if (Pattern.matches("[\\S]*[ ]*[0-9,]*[ ][0-9]{1,4}/[0-9]{1,2}/[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}",tempString)) {
                        String diff = tempString.replaceAll("[ ]*[0-9,]*[ ][0-9]{1,4}/[0-9]{1,2}/[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}","");
                        if (diff.length() > 0) {
                            String left = leftBase.getCanonicalPath() + File.separator + diff;
                            String right = rightBase.getCanonicalPath() + File.separator + diff;
                            String out = outPath.getCanonicalPath() + File.separator + "diff" + File.separator + diff + ".html";
                            textReport.output_to = out;
                            textReport.left = left;
                            textReport.right = right;
                            String outString = textReport.toSprict() + "\n";
//                            String textreport = "text-report layout:side-by-side options:display-all,line-numbers output-to:" + out + " output-options:html-color " + left + " " + right + "\n";
                            sprictFileWritter.write(outString);
                            System.out.println(outString);
                        }
                    }
                }
                else if (Pattern.matches("^不同的文件[\\S ]*", tempString)){
                    beginDiff = true;
                    System.out.println("开始不同了");
                }
                else if (Pattern.matches("^左边基点文件夹： [/\\S.]*", tempString)) {
                    leftBase = new File(tempString.replaceAll("^左边基点文件夹： ",""));
                    System.out.println("左边:" + leftBase.getCanonicalPath());
                }
                else if (Pattern.matches("^右边基点文件夹： [/\\S.]*", tempString)){
                    rightBase = new File(tempString.replaceAll("^右边基点文件夹： ",""));
                    System.out.println("左边:" + rightBase.getCanonicalPath());
                }
            }
            sprictFileWritter.close();
            reader.close();
        }
        catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        finally{
            if(reader != null){
                try {
                    reader.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    }


    /**
     * Create dir diff sprict string.
     *
     * @return the string
     * @throws Exception the exception
     */
    public String createDirDiffSprict() throws Exception{

        String resutl = "";
        try {

            File outPuth = new File(this.out);
            if (outPuth.exists() ){
                if (!outPuth.isDirectory()) {
                    throw  new BSCException(outPuth.getCanonicalPath() + " 不是个文件夹");
                }
            }
            else if (!outPuth.mkdir()) {
                throw  new BSCException(outPuth.getCanonicalPath() + " 创建失败");
            }
            File difSprictTxtFile =  new File(outPuth.getCanonicalPath() + File.separator + this.dirDiffSprictName);
            if (difSprictTxtFile.exists()){
                if (difSprictTxtFile.isDirectory()){
                    throw  new BSCException(difSprictTxtFile.getCanonicalPath() + " 是个文件夹?");
                }
                if (difSprictTxtFile.delete()){
                    throw  new BSCException(difSprictTxtFile.getCanonicalPath() + " 删除失败");
                }
            }
            FileWriter fileWritter = new FileWriter(difSprictTxtFile.getCanonicalPath(),true);

            String sprict = BSCSprictTool.getDirSprict(this.left,this.right,this.filter,outPuth.getCanonicalPath());
            fileWritter.write(sprict);
            fileWritter.close();

            resutl = difSprictTxtFile.getCanonicalPath();
        }
        catch (Exception e){
            throw e;
        }
        return resutl;
    }

    /**
     * The entry point of application.
     *
     * @param args the input arguments
     */
    public static void main(String[] args) {
        // BSCTool.runShell("echo a");
        // System.out.println(BSCTool.runShell("echo a"));
        // String os = System.getProperty("os.name");
        // if(os.toLowerCase().startsWith("win")){
        //     System.out.println(os + " can't gunzip");
        // }
        // else{
        //     System.out.println(os + " can't gunzip");
        // }
        // System.out.println("Hello World");
        try {
            BSCTool bscTool = new BSCTool();
            bscTool.abd();
            bscTool.readDirDiffTxt("/Users/toad/Desktop/testby/diff/BSCTool/out/dir.diff.txt");
        }
        catch (Exception e){
            System.out.println("Exception:" + e);
        }
    }

    /**
     * Run by sell boolean.
     *
     * @param com the com
     * @return the boolean
     * @throws Exception the exception
     */
    public boolean runBYSell(String com) throws  Exception{
        return true;
    }

    /**
     * Diff dir.
     *
     * @throws BSCException the bsc exception
     * @throws Exception    the exception
     */
    public void diffDir() throws BSCException,Exception{
        try {
            String fp = this.createDirDiffSprict();
            String com = "becoyong" + " @" + fp;
            if (!this.runBYSell(com)){
                throw new BSCException("命令执行失败");
            }
        }
        catch (BSCException exc){
            throw exc;
        }
        catch (Exception exc) {
            throw exc;
        }
    }
}