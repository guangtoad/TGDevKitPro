package com.toad.devkit.pro.mockapi.ApiService.exception;

import org.springframework.http.HttpHeaders;

public class APIException extends Exception {

    /**
     * http Status
     */
    public int httpStatus = 500;

    public HttpHeaders headers = null;

    public APIException(int httpStatus,String message){
        super(message);
        this.httpStatus = httpStatus;
    }
    /**
     * @param message 错误信息
     * @return
     */
    static public APIException ErrorException(String message){
        return new APIException(500, message);
    }
    /**
     * 错误请求 默认Status 400
     * @param message 异常信息
     * @return APIException
     */
    static public APIException BadRequestException(String message){
        return new APIException(400, message);
    }
    /**
     * API 没找到的异常 默认返回 Status 404
     * @param message 异常信息
     * @return APIException
     */
    static public APIException NotFoundException(String message){
        return new APIException(404, message);
    }
}
