package com.toad.java.TGquote2schedule.uitl;

import java.io.File;
import java.io.UnsupportedEncodingException;

public class TGUitl {

    public String getClassPahth() {
        String result = null;
        try {
            System.out.println("初始化");
            String thisPath = this.getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
            thisPath = java.net.URLDecoder.decode(thisPath, "UTF-8");
            File file = new File(thisPath);
            result = file.getPath();
        }
        catch (UnsupportedEncodingException e){

        }
        return result;
    }
}
