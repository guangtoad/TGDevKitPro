package com.toad.ApiService.advice;

import com.toad.ApiService.annotation.APIRequestMapping;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import java.lang.annotation.Annotation;

//@ResponseBody
//@ControllerAdvice
public class ResponseAdvice implements ResponseBodyAdvice<Object> {
    // 自定义异常捕获
//    @ExceptionHandler(Exception.class)
//    public ResultPo customException(BusinessException bs){
//        ResultPo resultPo = new ResultPo();
//        resultPo.setCode(bs.getCode());
//        resultPo.setMsg(bs.getMsg());
//        resultPo.setData(null);
//        return resultPo;
//    }

    /**
     *return turn 代表此接口会进入beforeBodyWrite方法，进行逻辑处理
     */
    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return !returnType.getDeclaringClass().getName().contains("springfox");
//        return true;
    }

    @Nullable
    @Override
    public Object beforeBodyWrite(@Nullable Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        Annotation[] annotations = returnType.getMethodAnnotations();
        APIRequestMapping apiRequestMapping = returnType.getMethodAnnotation(APIRequestMapping.class);
        String abc = apiRequestMapping.apicode();
        // 如果接口返回为string类型，则需要单独处理
        if(returnType.getGenericParameterType().equals(String.class)){

//            ObjectMapper objectMapper = new ObjectMapper();
//            try {
//                HttpHeaders headers = response.getHeaders();
//                headers.setContentType(MediaType.APPLICATION_JSON);
//                return objectMapper.writeValueAsString(ResultPo.success(body));
//            } catch (JsonProcessingException e) {
//                e.printStackTrace();
//            }
        }
        // 接口出现自定义异常，已被customException方法捕获，则无需再次封装
//        if(returnType.getGenericParameterType().equals(ResultPo.class)){
//            return body;
//        }
        return body;
//        return ResultPo.success(body);
    }
}
