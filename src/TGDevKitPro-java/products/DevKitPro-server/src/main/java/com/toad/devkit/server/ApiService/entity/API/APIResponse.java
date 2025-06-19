package com.toad.ApiService.entity.API;

import com.toad.ApiService.entity.APIBaseEntity;
import java.util.Map;

public class APIResponse extends APIBaseEntity {
    public int status;
    public String body;
    public Map<String,String> header;
}
