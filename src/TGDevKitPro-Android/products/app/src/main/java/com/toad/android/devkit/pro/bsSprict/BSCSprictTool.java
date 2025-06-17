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

import java.io.File;

/**
 * The type Bsc sprict tool.
 */
public class BSCSprictTool {
    /**
     * Get dir sprict string.
     *
     * @param left   the left
     * @param right  the right
     * @param filter the filter
     * @param out    the out
     * @return the string
     */
    static public String getDirSprict(String left,String right ,String filter,String out){
        String result = "CRITERIA binary\n";
        result = result +  "load \"" + left + "\" \"" + right + "\"\n";
        result = result +  "expand all"+ "\n";
        result = result +  "filter "+ filter + "\n";
        BSCFolderReport dirDiff =
                (BSCFolderReport)new BSCFolderReport()
                        .setLayout("summary")
                        .setOptions("display-mismatches")
                        .setOutput_options("wrap-none")
                        .setTitle("目录")
                        .setOutput_to(out + File.separator + "files.diff.txt");

        result = result + dirDiff.toSprict() + "\n";
        BSCFolderReport dirDiffHtml =
                (BSCFolderReport)new BSCFolderReport()
                        .setLayout("side-by-side")
                        .setOptions("display-mismatches")
                        .setOutput_options("html-color")
                        .setTitle("目录")
                        .setOutput_to(out + File.separator + "diff" + File.separator + "目录.html");
        result = result + dirDiffHtml.toSprict() + "\n";
        return result;
    }
}
