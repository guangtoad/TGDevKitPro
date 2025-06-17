//package com.toad.command.util;
//
//import java.io.File;
//
//public interface TGCommandInterface {
//
//    public default boolean loadArguments(){
//        return false;
//    }
//
//    public default String getLocationPath(){
//        try {
//            String thisPath = this.getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
//            thisPath = java.net.URLDecoder.decode(thisPath, "UTF-8");
//            File tempfile = new File(thisPath);
//            thisPath = tempfile.getParent();
//            return tempfile.getParent();
//        }
//        catch (Exception e){
//
//        }
//        return "";
//    }
//
//}
