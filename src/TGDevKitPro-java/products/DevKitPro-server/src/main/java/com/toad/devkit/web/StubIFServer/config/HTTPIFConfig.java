package com.toad.tool.StubIFServer.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
public class HTTPIFConfig {

    @Value("${if.root.path}")
    public String rootPath;
    @Value("${if.root.encoding}")
    public String encoding;
    @Value("${if.root.text.type}")
    public String text_type;

    @Value("${if.file.name.maxLen}")
    public int maxLen;
    @Value("${if.root.site.prefix}")
    public String site_prefix;

//    public String getText_type() {
//        return null != text_type && text_type.length() > 0 ? text_type : "json";
//    }
//
//    public String getRootPath() {
//        return null != rootPath ? rootPath:"";
//    }
//
//    public String getEncoding() {
//        return null != encoding && encoding.length() > 0 ? encoding : "utf-8";
//    }
}
