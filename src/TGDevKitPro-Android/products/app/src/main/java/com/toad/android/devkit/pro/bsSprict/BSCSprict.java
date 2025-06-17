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

/**
 * The type Bsc sprict.
 */
public abstract class BSCSprict {
    /**
     * 样式 .
     */
    public String layout = "side-by-side";
    /**
     * 对比设置.
     */
    public String options = "display-all,line-numbers";
    /**
     * 输出设置.
     */
    public String output_options = "html-color";
    /**
     * 输出路径.
     */
    public String output_to = "";
    /**
     * 左边的.
     */
    public String left = "";
    /**
     * 右边的.
     */
    public String right = "";
    /**
     * 标题？.
     */
    public String title = "";
    /**
     * Sets layout.
     *
     * @param layout the layout
     * @return the layout
     */
    public BSCSprict setLayout(String layout) {
        this.layout = layout;
        return this;
    }

    /**
     * Sets options.
     *
     * @param options the options
     * @return the options
     */
    public BSCSprict setOptions(String options) {
        this.options = options;
        return this;
    }

    /**
     * Sets output options.
     *
     * @param output_options the output options
     * @return the output options
     */
    public BSCSprict setOutput_options(String output_options) {
        this.output_options = output_options;
        return this;
    }

    /**
     * Sets output to.
     *
     * @param output_to the output to
     * @return the output to
     */
    public BSCSprict setOutput_to(String output_to) {
        this.output_to = output_to;
        return this;
    }

    /**
     * Sets left.
     *
     * @param left the left
     * @return the left
     */
    public BSCSprict setLeft(String left) {
        this.left = left;
        return this;
    }

    /**
     * Sets right.
     *
     * @param right the right
     * @return the right
     */
    public BSCSprict setRight(String right) {
        this.right = right;
        return this;
    }

    /**
     * Gets title.
     *
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets title.
     *
     * @param title the title
     * @return the title
     */
    public BSCSprict setTitle(String title) {
        this.title = title;
        return this;
    }

    /**
     * 设置转化为字符串数组.
     *
     * @return the string [ ]
     */
    abstract public String[] sprictArray();

    /**
     * 脚本前面写的啥.
     *
     * @return the string
     */
    abstract public String sprictName();

    /**
     * 脚本内容.
     *
     * @return 脚本内容
     */
    public String sprictBody(){
        String[] sa = this.sprictArray();
        String out = "";
        for (int i = 0 ; i < sa.length ; i++) {
            String s = sa[i];
            out = out + " " + s;
        }
        return out;
    }

    /**
     * 转换为脚本字符串.
     *
     * @return the string
     */
    public String toSprict() {
        return this.sprictName() + this.sprictBody();
    }
}
