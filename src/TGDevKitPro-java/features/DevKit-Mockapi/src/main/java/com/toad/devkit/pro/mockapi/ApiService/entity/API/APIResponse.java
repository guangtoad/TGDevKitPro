package com.toad.devkit.pro.mockapi.ApiService.entity.API;

import com.toad.devkit.pro.mockapi.ApiService.entity.APIBaseEntity;

import java.util.Map;

public class APIResponse extends APIBaseEntity {
    public int status;
    public String body;
    public Map<String,String> header;
}
