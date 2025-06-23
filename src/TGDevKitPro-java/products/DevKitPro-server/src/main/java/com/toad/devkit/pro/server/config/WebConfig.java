package com.toad.devkit.pro.server.config;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(new ResponseInterceptor())
//                .addPathPatterns("/**"); // 拦截所有请求
    }
}