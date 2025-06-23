package com.toad.devkit.pro.server.interceptor;

import com.toad.devkit.springframework.model.ResponseResult;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

//@ControllerAdvice
//public class GlobalResponseHandler implements ResponseBodyAdvice<Object> {
//
//    @Override
//    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
//        return true;
//    }
//
//    @Override
//    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
//                                  Class<? extends HttpMessageConverter<?>> selectedConverterType,
//                                  ServerHttpRequest request, ServerHttpResponse response) {
//        String path = request.getURI().getPath();
//        if (null != path && path.length() > 0){
//            if (path.startsWith("mockapi")){
//                return body;
//            }
//        }
//        if (body instanceof ResponseResult) {
//            return body;
//        }
//        return ResponseResult.success(body);
//    }
//}