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

package com.toad.devkit.common.util ;

/**
 * 字符串工具
 */
public class TGStringUtil {
    /**
     * 判断null 或则 ""
     *
     * @param s 判断
     * @return 判断结果
     */
    static public Boolean isEmpty(String s) {
        return (s == null || s.length() <= 0);
    }
}
