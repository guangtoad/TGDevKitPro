package com.toad.ApiService.entity.API;

import java.util.List;

public class APISchemasSetting {

    public class APISchemasItemSetting{
        public String format;
        public String path;
        public boolean optional = false;
        public String type;
        public APIResponse errorResponse;
    }

    public APISchemasItemSetting body;
    public List<APISchemasItemSetting> header;
    public List<APISchemasItemSetting> parameter;
}
