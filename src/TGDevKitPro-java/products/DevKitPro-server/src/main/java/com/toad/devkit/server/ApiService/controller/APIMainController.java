package com.toad.ApiService.controller;

import com.toad.ApiService.annotation.APIRequestMapping;
import com.toad.ApiService.config.AppConfig;
import com.toad.ApiService.exception.APIException;
import com.toad.ApiService.service.APIMainService;
import com.toad.ApiService.util.APILogger;
import com.toad.ApiService.util.APISpringbootUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import java.lang.reflect.*;
/**
 * 站点入口
 */
@RestController
@RequestMapping("/")
public class APIMainController {

//    @Autowired
//    APIMainService loginService ;
    @Resource
    protected AppConfig appConfig;

    @RequestMapping(value = "**")
    @PostMapping(value = "parent/controller")
//    @APIRequestMapping(apicode = "E1001",value ="")
    public ResponseEntity<String> stubAPI(HttpServletRequest request, HttpServletResponse response) {
        ResponseEntity<String> responseEntity = null;

        String uri = request.getRequestURI();
        APILogger logger = new APILogger("APILogger");;
        try {
            logger.writeInfo("request" + uri);
            if (null != this.appConfig.pathignore && this.appConfig.pathignore.length() > 0){
                int index = uri.indexOf(this.appConfig.pathignore);
                if (index > 0) {
                    index = index + this.appConfig.pathignore.length();
                    if (index < uri.length()){
                        uri = uri.substring(index);
                    }
                    else {

                    }
                }
                else {

                }
            }
            else {

            }
            Map<String, String[]> parameter = request.getParameterMap();
            Map<String, String> header = new HashMap<String, String>();
            Enumeration<String> headerNames = request.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                String key = (String) headerNames.nextElement();
//                // 排除Cookie字段
//                if (key.equalsIgnoreCase("Cookie")) {
//                    continue;
//                }
                String value = request.getHeader(key);
                header.put(key, value);
            }
            byte[] input = APISpringbootUtil.readAsBytes(request);
            APIMainService loginService = new APIMainService(appConfig,logger);
            responseEntity = loginService.getResponseEntity(uri,header,parameter,input);

//            APIResponse apiResponse = loginService.getResponse(uri,null,parameter,null);
//            HttpHeaders httpHeaders = new HttpHeaders();
//            if (null != apiResponse.header && apiResponse.header.size() > 0){
//                for (String key : apiResponse.header.keySet()) {
//                    httpHeaders.add(key,apiResponse.header.get(key));
//                }
//            }
//            responseEntity = ResponseEntity.status(apiResponse.status).headers(httpHeaders).body(apiResponse.body);
        }
        catch (APIException e){
            logger.writeError("请求异常：" + e);
            responseEntity = ResponseEntity.status(e.httpStatus)
                    .body(e.getMessage());
        }
        catch (Exception e){
            logger.writeError("发生异常:" + e.getMessage());
            responseEntity = ResponseEntity.status(500)
                    .body("Exception:\n"+ e.getMessage() + e.getStackTrace());

        }
        return responseEntity;
    }
}
