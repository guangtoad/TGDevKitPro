package com.toad.android.devkit.log;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.util.Log;

import androidx.annotation.RequiresApi;
import androidx.core.content.ContextCompat;
import androidx.core.content.FileProvider;

import android.content.pm.PackageManager;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class TGLog {

    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    static TGLog singleton = new TGLog();
    PrintWriter printWriter = null;
    FileWriter fileWriter = null;
    File logFile = null;
    String packageName = "";

    public boolean debug = false;
    public TGLog setDebug(boolean debug){
        debug = false;
        return this;
    }
    static public TGLog shareSingleton(){
        return singleton;
    }

    public String logFileName(){
        return "e_log.txt";
    }

    public TGLog init(File logFile) throws Exception{
        Activity a = new Activity();
        String packageName = a.getPackageName();
//        PackageManager manager = this.getPackageManager();
        // String packageName = Activity.class.getPackageName();
        // RequestInterfaceInitConfiguration.class.getCanonicalName();
        this.logFile = logFile;
        if (!this.logFile.exists()) {
            this.logFile.createNewFile();
        }
        fileWriter = new FileWriter(this.logFile,true);
        printWriter = new PrintWriter(fileWriter);

        return this;
    }

    public TGLog init(Context context,String logFileName) throws Exception{
//        File logFile = context.getExternalFilesDir(logFileName());
        String logPath = Environment.getExternalStorageDirectory().getAbsolutePath() + File.separator + logFileName();
//        File logFile = context.getFileStreamPath(logFileName());
        File logFile = new File(logPath);
        return init(logFile);
    }

    public TGLog init(Context context) throws Exception{
        return init(context,logFileName());
    }

    public void close(){
        try {

        }
        catch (Exception e){

        }
    }

    public TGLog closeAndClear(){
        try {
            if (null != printWriter) {
                printWriter.close();
            }
            if (null != fileWriter) {
                fileWriter.close();
            }
        }
        catch (Exception e){
            this.printWriter = null;
            this.logFile = null;
            this.fileWriter = null;
        }
        return this;
    }
    synchronized public String read(){
        String result = null;
//        String tempPah = "";
        try {
            if (null == this.logFile) {
                result = "读取失败：" + "Log File is Null";
                return result;
            }
            result = new String(Files.readAllBytes(this.logFile.toPath()));
        }
        catch (Exception e){
            result = "读取失败：" + this.logFile.toPath() + "\n" + e;
        }
        return result;
    }
    synchronized public void write(String msg){
        try {
            this.printWriter.println(msg);
            this.printWriter.flush();
            this.fileWriter.flush();
        }
        catch (Exception e){
            if (debug) {
                Log.d("--TGLog","写入日志异常" + e);
            }
        }
        finally {

        }
    }

    public String logFormat(String msg){
        Date date = new Date();
        return String.format("[%s] %s",dateFormat.format(date),msg);
    }

    public void log(String msg){
        if (debug) {
            Log.d("--TGLog",msg);
        }
        String logMessage = logFormat(msg);
        write(logMessage);
    }

    static public void Log(String msg){
        singleton.log(msg);
    }
    @RequiresApi(api = Build.VERSION_CODES.M)

    private void makeAnExtraRequest(Activity activity) {
        int code = 100;
        String[] permissions = {
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };

        for (String string : permissions) {
            if (activity.checkSelfPermission(string) != PackageManager.PERMISSION_GRANTED) {
                activity.requestPermissions(permissions, code);
                code++;
                return;
            }
        }
    }
    public boolean shareLog(Activity activity){
        boolean result = false;

        String packageName = activity.getPackageName();

        if(ContextCompat.checkSelfPermission(activity,Manifest.permission.WRITE_EXTERNAL_STORAGE)!=
                PackageManager.PERMISSION_GRANTED||(ContextCompat.checkSelfPermission(activity,Manifest.permission.READ_EXTERNAL_STORAGE)!=PackageManager.PERMISSION_GRANTED)){
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                makeAnExtraRequest(activity);
            }
        }
        else{

//            val uriForFile = FileProvider.getUriForFile(activity, packageName + ".fileProvider", this.logFile);

            Intent shareIntent = new Intent(Intent.ACTION_SEND);
            shareIntent.putExtra(Intent.EXTRA_STREAM, logFile);
            shareIntent.setAction(Intent.ACTION_SEND);
            shareIntent.setType("*/*");
            activity.startActivity(Intent.createChooser(shareIntent, "分享到"));
            result = true;
        }
        return result;
    }

}
