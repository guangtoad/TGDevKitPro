package com.toad.devkit.springframework.model;

import com.toad.devkit.springframework.constants.DevKitConstants;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ResultBean<T> {
    String code;
    String message;
    String responseDate;
    T data;

    ResultBean(String code, String message, T data, String responseDate) {
        this.code = code;
        this.message = message;
        this.data = data;
        this.responseDate = responseDate;
    }

    ResultBean(String code, String message, T data) {
        this(code, message, data, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }

    ResultBean(T data) {
        this(DevKitConstants.defaultSuccessCode, DevKitConstants.defaultSuccessMessage, data, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }

    // 成功方法
    public static <T> ResultBean<T> success(T data) {
        ResultBean<T> result = new ResultBean<>("200", "成功", data);
        return result;
    }

    // 失败方法
    public static <T> ResultBean<T> failed(String code, String message) {
        ResultBean<T> result = new ResultBean<>(code, message, null);
        return result;
    }
}
