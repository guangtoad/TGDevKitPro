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

public class BSCFolderReport extends  BSCSprict{
    @Override
    public String[] sprictArray() {
        return new String[]{
                "layout:" + this.layout,
                "options:" + this.options ,
                "output-to:\"" + this.output_to + "\"" ,
                "output-options:" + this.output_options
        };
    }
    @Override
    public String sprictName() {
        return "folder-report";
    }
}
