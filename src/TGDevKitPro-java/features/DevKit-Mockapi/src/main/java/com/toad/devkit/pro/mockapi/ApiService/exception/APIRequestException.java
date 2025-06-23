package com.toad.devkit.pro.mockapi.ApiService.exception;


import com.toad.devkit.pro.mockapi.ApiService.entity.API.APIResponse;

/**
 * 接口请求异常
 */
public class APIRequestException extends APIException {
    public APIResponse response;
    public APIRequestException(int httpStatus,String message,APIResponse response){
        super(httpStatus,message);
        this.response = response;
    }
    /**
     * 请求错误异常
     * @param response 默认返回
     * @param message 错误信息
     * @return APIRequestException
     */
    static public APIRequestException RequestErrorException(APIResponse response, String message){
        APIRequestException exception = new APIRequestException(null != response ? response.status : 200,message,response);
        return exception;
    }
}
