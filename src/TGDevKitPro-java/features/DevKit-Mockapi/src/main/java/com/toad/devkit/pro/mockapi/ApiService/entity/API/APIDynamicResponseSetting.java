package com.toad.devkit.pro.mockapi.ApiService.entity.API;

import java.util.List;
import java.util.Map;

public class APIDynamicResponseSetting {
    public String bodyType = "json";
    public String basePath;
    public List<String> header;
    public List<String> parameters;
    public List<String> body;
    public Map<String,APIResponse> dynamicResponse;

}
