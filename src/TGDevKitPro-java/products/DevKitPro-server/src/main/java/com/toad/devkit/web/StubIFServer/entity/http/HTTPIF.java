package com.toad.tool.StubIFServer.entity.http;

import java.io.File;

public class HTTPIF {

    protected static String IFPath;
    protected static String dataPath;

    public static synchronized boolean resetConfig(String inputIFPath, String inputDtaPath){
        boolean result = false;
        try {
            File tmpFile = null;

            tmpFile = new File(inputIFPath);
            if (tmpFile.exists() && tmpFile.isDirectory()){
                IFPath = inputIFPath;
            }

            tmpFile = new File(inputDtaPath);
            if (null != tmpFile && tmpFile.exists() && tmpFile.isDirectory()){
                dataPath = inputDtaPath;
            }

        }
        catch (Exception e){
            result = false;
        }

        return result;
    }
}
