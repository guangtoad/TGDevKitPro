package com.toad.android.devkit.pro.utils;

import android.content.Context;
import android.content.DialogInterface;

import androidx.appcompat.app.AlertDialog;

public interface DialogActivity  {
    public default boolean showAlertDialog(String message, final DialogInterface.OnClickListener listener){
        Context context = null;
        if (this instanceof Context) {
            context = (Context)this;
        }
        else {
        }
        if (null == context) {
            return false;
        }
        AlertDialog.Builder alertDialog = new AlertDialog.Builder(context);
        alertDialog.setTitle("提示");
        alertDialog.setMessage(message);
        alertDialog.setCancelable(false);//表示点击dialog其它部分不能取消(除了“取消”，“确定”按钮)
        if (null != listener){
            alertDialog.setPositiveButton("确定", new
                    DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {

                        }
                    });
        }
        alertDialog.setNegativeButton("取消", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
            }
        });
        alertDialog.show();
        return true;
    }

    public default boolean showAlertDialog(String message){

        return showAlertDialog(message,null);
    }
}
