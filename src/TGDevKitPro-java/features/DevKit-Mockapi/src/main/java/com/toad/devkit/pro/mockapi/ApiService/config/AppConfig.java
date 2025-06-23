package com.toad.devkit.pro.mockapi.ApiService.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration()
@ComponentScan(basePackages = "com.toad.devkit.server.ApiService.config")
public class AppConfig {

//    @Value("${stubApi.pathignore}")
    public String pathignore;
//    @Value("${stubApi.basepath}")
    public String basepath;
//    @Value("${stubApi.encoding}")
//    public String encoding;
//    @Value("${stubApi.root.text.type:json}")
//    public String text_type;

//    public int maxLen;
//    @Value("${if.root.site.prefix}")
//    public String site_prefix;
//    @Value("${stubApi.file.type}")
    public String fileType;

}
