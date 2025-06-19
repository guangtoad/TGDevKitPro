package com.toad.ApiService.util;


import com.toad.java.util.TGEncryptionUtil;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import java.util.Random;

public class APILogger {
    private Logger logger;
    private String loggerID;


    protected static String randomID(String name){
        Random random = new Random(System.currentTimeMillis());
        String loggerID = TGEncryptionUtil.md5(name + random.nextInt(10000));
        return loggerID;
    }

    public APILogger(String name){
        this(name,randomID(name));
    }

    public APILogger(String name,String loggerID){
//        this.logger = LoggerFactory.getLogger(name);
//        this.logger = LoggerFactory.getLogger(this.getClass());
//        this.logger = LogManager.getLogger(name);
        this.logger = LogManager.getLogger(name);
        this.loggerID = loggerID;
    }
    public String formatLogMessage(String message){
        return String.format("[%s] %s",loggerID,message);
    }
    public String formatLogMessage(String format, Object... arg){
        return formatLogMessage(String.format(format,arg));
    }

    public void debug(String message){
        logger.debug(message);
    }
    protected void info(String message){
        logger.info(message);
    }
    public void warn(String message){
        logger.warn(message);
    }
    public void error(String message){
        logger.error(message);
    }
    public void writeDebug(String message){
        debug(formatLogMessage(message));
    }
    public void writeDebug(String format, Object... arg){
        info(formatLogMessage(format,arg));
    }
    public void writeInfo(String message){
        info(formatLogMessage(message));
    }
    public void writeInfo(String format, Object... arg){
        info(formatLogMessage(format,arg));
    }
    public void writeWarn(String message){
        warn(formatLogMessage(message));
    }
    public void writeWarn(String format, Object... arg){
        warn(formatLogMessage(format,arg));
    }
    public void writeError(String message){
        error(formatLogMessage(message));
    }
    public void writeError(String format, Object... arg){
        error(formatLogMessage(format,arg));
    }
}
