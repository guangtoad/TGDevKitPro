package com.toad.ApiService.entity.API;

import com.toad.ApiService.entity.APIBaseEntity;

public class APIEntity extends APIBaseEntity {
    public APIConfigEntity config;
    public String IF_Name;
    public String IF_description;
    public String responsePath;
    // 默认返回
    public APIResponse defaultResponse;
    public APIResponse defaultResposne;
    // 错误返回
    public APIResponse defaultErrorResponse;
    public String apiFilePath;
    public String contentType;
}
