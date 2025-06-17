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

package com.toad.android.devkit.pro.bsSprict;

public class BSCConfig {

    public String diffBeginRegex = "^不同的文件[\\S ]*";
    public String diffLeftRegex = "^左边基点文件夹： [/\\S.]*";
    public String diffRigtRegex = "^右边基点文件夹： [/\\S.]*";
    public String diffLeftPrefixRegex = "^左边基点文件夹： ";
    public String diffRigtPrefixRegex = "^右边基点文件夹： ";
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
    public String diffLineRegex = "[\\S]*[ ]*[0-9,]*[ ][0-9]{1,4}/[0-9]{1,2}/[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}";
    public String diffLineSuffixRegex = "[ ]*[0-9,]*[ ][0-9]{1,4}/[0-9]{1,2}/[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}";
}
