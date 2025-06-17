//package com.toad.command.util;
//
//import java.net.URL;
//import java.text.SimpleDateFormat;
//import java.util.Calendar;
//import java.util.Date;
//
//public class TGDateUtil {
//    public static Date dateWithString(String timeStr){
////        URL url = new URL("https://www.baidu.com");
////        url.getPath()
//        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
//        Date result = null;
//        try {
//            result = simpleDateFormat.parse(timeStr);
//        }
//        catch (Exception e){
//
//        }
//        return result;
//    }
//
//    public static boolean isSameWeek(Date date1, Date date2){
//        if (null == date1 || null == date2){
//            return false;
//        }
//        Calendar calendar1 = Calendar.getInstance();
////        calendar1.setFirstDayOfWeek(2);
//        calendar1.setFirstDayOfWeek(Calendar.MONDAY);
//        Calendar calendar2 = Calendar.getInstance();
////        calendar2.setFirstDayOfWeek(2);
//        calendar2.setFirstDayOfWeek(Calendar.MONDAY);
//        calendar1.setTime(date1);
//
//        calendar2.setTime(date2);
//        int year1 = calendar1.get(Calendar.YEAR);
//        int week1 = calendar1.get(Calendar.WEEK_OF_YEAR);
//        int day1 = calendar1.get(Calendar.DAY_OF_WEEK);
//
//        int year2 = calendar2.get(Calendar.YEAR);
//        int week2 = calendar2.get(Calendar.WEEK_OF_YEAR);
//        int day2 = calendar2.get(Calendar.DAY_OF_WEEK);
//        return false;
//    }
//
//    public static boolean isSameWeek(String timeStr1, String timeStr2){
//        return isSameWeek(dateWithString(timeStr1), dateWithString(timeStr2));
//    }
//    //------------------------------
//
////类名称:isWeekSame
//
////包含方法:1.isSameDate
//
//// 2.main
//
////作者:lzueclipse
//
////时间:2005-11-13
//
////------------------------------
//
////----------------------------
//
////方法名称：isSameDate(String date1,String date2)
//
////功能描述：判断date1和date2是否在同一周
//
////输入参数：date1,date2
//
////输出参数：
//
////返 回 值：false 或 true
//
////其它说明：主要用到Calendar类中的一些方法
//
////-----------------------------
//
//    public static boolean isSameDate(String date1,String date2)
//    {
//        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//        Date d1 = null;
//        Date d2 = null;
//        try
//        {
//            d1 = format.parse(date1);
//            d2 = format.parse(date2);
//        }
//        catch(Exception e)
//        {
//            e.printStackTrace();
//        }
//        Calendar cal1 = Calendar.getInstance();
//        Calendar cal2 = Calendar.getInstance();
//        cal1.setFirstDayOfWeek(Calendar.MONDAY);
//        cal2.setFirstDayOfWeek(Calendar.MONDAY);
//        cal1.setTime(d1);
//        cal2.setTime(d2);
//        int subYear = cal1.get(Calendar.YEAR)-cal2.get(Calendar.YEAR);
//        int week1 = cal1.get(Calendar.WEEK_OF_YEAR);
//        int week2 = cal2.get(Calendar.WEEK_OF_YEAR);
////subYear==0,说明是同一年
//        if(subYear == 0)
//        {
//            if(cal1.get(Calendar.WEEK_OF_YEAR) == cal2.get(Calendar.WEEK_OF_YEAR))
//                return true;
//        }
//        else if(subYear==1 && cal2.get(Calendar.MONTH)==11)
//        {
//            if(cal1.get(Calendar.WEEK_OF_YEAR) == cal2.get(Calendar.WEEK_OF_YEAR))
//                return true;
//        }
////例子:cal1是"2004-12-31"，cal2是"2005-1-1"
//        else if(subYear==-1 && cal1.get(Calendar.MONTH)==11)
//        {
//            if(cal1.get(Calendar.WEEK_OF_YEAR) == cal2.get(Calendar.WEEK_OF_YEAR))
//                return true;
//        }
//        return false;
//    }
//
//    public static void testRun()
//
//    {
////测试3
//        boolean d = isSameDate("2022-12-31","2023-1-1");
//        if(d)
//        {
//            System.out.println("2005-1-1和2004-12-26是同一周！");
//        }
//        else
//        {
//            System.out.println("2005-1-1和2004-12-26不是同一周！");
//        }
//    }
//}
