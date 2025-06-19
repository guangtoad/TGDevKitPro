package com.toad.java.util;
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


import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 字符串工具
 */
public class TGStringUtil extends TGUtil{
    /**
     * 判断null 或则 ""
     *
     * @param str 判断
     * @return 判断结果
     */
    public static boolean isNullOrEmpty(String str){

        boolean result = false;

        if (null != str){
            if (str instanceof String  && str.length() > 0){
                result = true;
            }
        }

        return result;
    }

    /***
     * 默认字符串字
     */
    final static public String defauleStrValue = "";
    /***
     * 默认整数值
     */
    final static public int defauleIntValue = 0;
    /***
     * 默认布尔值
     */
    final static public boolean defauleBooleanValue = false;
    /***
     * 默认时间格式
     */
    final static public String defauleDataFormat = "yyyy-MM-DD HH:SS";

    /***
     * 获取时间
     * @param str 入力字符串
     * @param pattern 格式
     * @param defValue 默认值
     * @return 转换后时间
     */
    public static Date dateValue(String str, String pattern, Date defValue){
        if (isNullOrEmpty(str)) {
            return defValue;
        }
        java.util.Date result = null;

        try {
            SimpleDateFormat dateFormat =new SimpleDateFormat(pattern);
            result = dateFormat.parse(str);
        }
        catch (ParseException exc){
            result = defValue;
        }
        catch (Exception exc){
            result = defValue;
        }
        return result;
    }

    /***
     * 获取时间
     * @param str 入力字符串
     * @param pattern 格式
     * @return 转换后时间 默认值为 Date()
     */
    public static Date dateValue(String str,String pattern){
        return dateValue(str, pattern, new Date());
    }

    /***
     * 获取时间
     * @param str 入力字符串
     * @return 转换后时间 默认值为 Date()
     */
    public static Date dateValue(String str){
        return dateValue(str, defauleDataFormat, new Date());
    }

    /***
     * 转字符串
     * @param obj 参数
     * @param defValue 默认字符串
     * @return 转换后
     */
    public static String stringValue(Object obj, String defValue){
        if (null == obj) {
            return defValue;
        }
        else if (obj instanceof String) {
            return (String)obj;
        }
        else if (obj instanceof Object) {
            String result = null;
            try {
                result = obj.toString();
            }
            catch (Exception exc) {
                result = defValue;
            }
            return result;
        }
        return defValue;
    }
    /***
     * 转字符串
     * @param obj 参数
     * @auth
     * @return 转换后
     */
    public static String stringValue(Object obj){
        return stringValue(obj, defauleStrValue);
    }

    public static int intValue(String str, int defValue){
        int result = defValue;

        if (isNullOrEmpty(str)) {

        }
        else {
            try {
                result = Integer.parseInt(str);
            }
            catch (NumberFormatException e) {
                result = defValue;
            }
            catch (Exception exc){
                result = defValue;
            }
        }
        return result;
    }
    public static int intValue(String str){
        return intValue(str, defauleIntValue);
    }

    public static boolean booleanValue(String str, boolean defValue){
        boolean result = defValue;
        if (isNullOrEmpty(str)) {

        }
        else {
            try {
                result = Boolean.parseBoolean(str);
            }
            catch (NumberFormatException e) {
                result = defValue;
            }
            catch (Exception exc){
                result = defValue;
            }
        }
        return result;
    }
    public static boolean booleanValue(String str){
        return booleanValue(str, defauleBooleanValue);
    }

    public static String join(List<String> list,String separator,int start,int end){
        String result = "";
        if (null != list && start < list.size()){
            List<String> tempList = new ArrayList<String>();
            for (int i = start;i <= end && i < list.size();i++){
                tempList.add(list.get(i));
            }
            result = String.join(separator, tempList);
        }
        return result;
    }

}
