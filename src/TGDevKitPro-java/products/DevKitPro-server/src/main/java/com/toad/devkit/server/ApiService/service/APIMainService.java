package com.toad.ApiService.service;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.fasterxml.jackson.databind.JsonNode;
import com.github.fge.jackson.JsonLoader;
import com.github.fge.jsonschema.core.exceptions.ProcessingException;
import com.github.fge.jsonschema.core.report.ProcessingReport;
import com.github.fge.jsonschema.main.JsonSchema;
import com.github.fge.jsonschema.main.JsonSchemaFactory;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.toad.ApiService.config.APIConstant;
import com.toad.ApiService.config.AppConfig;
import com.toad.ApiService.entity.API.*;
import com.toad.ApiService.exception.APIException;
import com.toad.ApiService.exception.APIRequestException;
import com.toad.ApiService.util.APILogger;
import com.toad.java.util.TGEncryptionUtil;
import com.toad.java.util.TGStringUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import javax.crypto.Cipher;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPMessage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

//@Service
//@Scope("prototype")
public class APIMainService  {

    public APILogger logger;
    /**
     * 应用设置
     */
//    @Resource
    protected AppConfig appConfig;

    public APIMainService(AppConfig appConfig,APILogger logger){
        this.appConfig = appConfig;
        this.logger = logger;
    }
    public ProcessingReport jsonValidate(String dataString, String schemaString) {
        ProcessingReport processingReport = null;
        try {
            JsonNode dataNode = JsonLoader.fromString(dataString);
            JsonNode schemaNode = JsonLoader.fromString(schemaString);
            JsonSchema schema = JsonSchemaFactory.byDefault().getJsonSchema(schemaNode);
            processingReport = schema.validate(dataNode);
            return processingReport;
        } catch (IOException | ProcessingException ex) {
//            Logger.getLogger(JsonService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return processingReport;
    }
    public String readData(String input){
        String result = input;
        if (input.startsWith(APIConstant.APIFilePrefix)){

        }
        return result;
    }
    /**
     * 加载API设置
     * @param path 路径
     * @return 返回设置实体
     * @throws Exception 不一定啥异常
     */
    public APIEntity loadAPI(String path) throws Exception {

            APIEntity result = null;
            List<String> apis= Arrays.asList(path.split("/"));
            String basepath = appConfig.basepath;
            StringBuilder stringBuilder = new StringBuilder("\n");
            if (apis.size() > 1){
                for (int i =  apis.size() - 1; i > 0; i--){
                    String temp = TGStringUtil.join(apis, File.separator, 1, i);
                    Path filePath = Paths.get(basepath,temp + "." + appConfig.fileType);
                    File file= new File(filePath.toUri());
                    stringBuilder.append("\n" + file.getPath());
                    if (!file.isDirectory() && file.exists()){
                        logger.writeDebug("读取：%s",file.getPath());
                        String context = FileUtils.readFileToString(file, "utf-8");
                        switch (appConfig.fileType){
                            case "yml":
                                break;
                            case "json": {
                                Gson gson = new Gson();
                                result = gson.fromJson(context, APIEntity.class);
                                if (null == result.apiFilePath || result.apiFilePath.length() < 1) {

                                    result.apiFilePath = FilenameUtils.removeExtension(filePath.toAbsolutePath().toString());

                                }
                            }
                            default:
                                break;
                        }
                        break;
                    }
                }
            }

        if (null == result) {
            throw APIException.NotFoundException("API 没找到：" + path + "\nBase Path:" + appConfig.basepath + "\n可以在一下路径放入文件:" + stringBuilder.toString());
        }
        return result;
    }
    /**
     * 解密
     * @param context 内容
     * @param apiCipher 解密
     * @return 机密侯数据
     */
    public String decryptionBody(String context , APIDecryptionCipher apiCipher) throws APIException{
        String result = context;
        if (null == context || context.length() < 1) {
            return "";
        }
        if (null == apiCipher){
            throw APIException.ErrorException("decryptionSetting is null");
        }
        try {
            if (apiCipher.mode.startsWith("AES")) {
                result = TGEncryptionUtil.AESCipher(apiCipher.mode, Cipher.DECRYPT_MODE, context, apiCipher.aesKey, apiCipher.aesIV, apiCipher.charsetName, apiCipher.codecType);
            }
            else if (apiCipher.mode.startsWith("RSA")){
                result = TGEncryptionUtil.RSACipher(apiCipher.mode, Cipher.DECRYPT_MODE, context, apiCipher.rsaKey,apiCipher.charsetName,apiCipher.codecType);
            }
            else {
                throw  APIException.ErrorException(apiCipher.mode + " 解密格式错误");
            }
        }
        catch (APIException e){
            logger.error(String.format("【%s】解密失败: %s",apiCipher.mode,e.getMessage()));
            throw e;
        }
        catch (Exception e){
            if (null != apiCipher.errorResponse) {

                throw APIRequestException.RequestErrorException(apiCipher.errorResponse,String.format("【%s】解密失败: %s",apiCipher.mode,e.getMessage()));
            }
            else {
                throw APIException.ErrorException(String.format("【%s】解密失败: %s",apiCipher.mode,e.getMessage()));
            }
        }
        return result;
    }
    /**
     * 加密
     * @param context 内容
     * @param apiCipher 加密设置
     * @return 加密字符串
     * @throws APIException
     */
    public String encryptionBody(String context , APICipher apiCipher) throws APIException {
        String result = context;
        if (null == apiCipher){
            throw APIException.ErrorException("encryptionSetting is null");
        }
        try {
            if (apiCipher.mode.startsWith("AES")) {
                result = TGEncryptionUtil.AESCipher(apiCipher.mode, Cipher.ENCRYPT_MODE, context, apiCipher.aesKey, apiCipher.aesIV, apiCipher.charsetName, apiCipher.codecType);
            }
            else if (apiCipher.mode.startsWith("RSA")){
                result = TGEncryptionUtil.RSACipher(apiCipher.mode, Cipher.ENCRYPT_MODE, context, apiCipher.rsaKey,apiCipher.charsetName,apiCipher.codecType);
            }
            else if (apiCipher.mode.startsWith("SHA256")) {
                result = TGEncryptionUtil.sha256(context,apiCipher.charsetName,apiCipher.codecType);
            }
            else {
                throw APIException.ErrorException(apiCipher.mode + " 加密格式错误");
            }


        }
        catch (APIException e){
            throw e;
        }
        catch (Exception e) {
            throw APIException.ErrorException("加密失败" + e.getMessage() + e.toString());
        }
        return result;
    }
    /**
     * 格式校验
     * @param schemasItemSetting 设置
     * @param context 请求内容
     * @param type 校验类型
     * @return
     * @throws Exception
     */
    public boolean formatChecks(String basePath,APISchemasSetting.APISchemasItemSetting schemasItemSetting,String context,int type) throws APIException{

        boolean result = true;
        if (null == context || context.length() < 1){
            if (true == schemasItemSetting.optional) {
                result = true;
                return result;
            }
            else {
                if (null != schemasItemSetting.errorResponse) {
                    String errorMessage = String.format("Check【 %s】 filed 。【%s】不符合【%s】格式",schemasItemSetting.path,context,schemasItemSetting.format);
                    throw APIRequestException.RequestErrorException(schemasItemSetting.errorResponse,errorMessage);
                }
                result = false;
                return result;
            }
        }
        if (APIConstant.APIChecksHeader == type || APIConstant.APIChecksParameter == type) {
            String pattern = schemasItemSetting.format;
            boolean isMatch = Pattern.matches(pattern, context);
            if (!isMatch) {
                if (null != schemasItemSetting.errorResponse) {
                    String errorMessage = String.format("Check【 %s】 filed 。【%s】不符合【%s】格式",schemasItemSetting.path,context,schemasItemSetting.format);
                    throw APIRequestException.RequestErrorException(schemasItemSetting.errorResponse,errorMessage);
                }
                result = false;
                return result;
            }
        }
        else if (APIConstant.APIChecksBody == type) {
            String schemaString = cloneBodyContext(basePath,schemasItemSetting.format,"UTF-8");
            ProcessingReport processingReport = jsonValidate(context,schemaString);
            if (!processingReport.isSuccess()){
                if (null != schemasItemSetting.errorResponse) {
                    String errorMessage = String.format("Check【 %s】 filed 。【%s】不符合【%s】格式",schemasItemSetting.path,context,schemasItemSetting.format);
                    throw APIRequestException.RequestErrorException(schemasItemSetting.errorResponse,errorMessage);
                }
                result = false;
                return result;
            }
        }
        else {
            if (null != schemasItemSetting.errorResponse) {
                String errorMessage = String.format("Check【 %s】 filed 。【%s】不符合【%s】格式",schemasItemSetting.path,context,schemasItemSetting.format);
                throw APIRequestException.RequestErrorException(schemasItemSetting.errorResponse,errorMessage);
            }
            else {
                throw APIException.ErrorException("Checks type 未知");
            }
        }
        return result;
    }
    /**
     * 格式校验
     * @param schemasSetting 设置
     * @param header 请求头
     * @param parameters 请求参数
     * @param context 请求内容
     * @return
     * @throws Exception
     */
    public boolean formatChecks(String basePath,APISchemasSetting schemasSetting,Map<String,String> header,Map<String, String[]> parameters,String context) throws APIRequestException,APIException{
        boolean result = true;
        if (null == schemasSetting) {
            throw APIException.ErrorException("APISchemasSetting null");
        }
        if (null != schemasSetting.header && schemasSetting.header.size() > 0){
            for (APISchemasSetting.APISchemasItemSetting schemasItemSetting : schemasSetting.header) {
                if (null == schemasItemSetting.path){
                    continue;
                }
                String headerValue = header.get(schemasItemSetting.path.toLowerCase());
                if (!formatChecks(basePath,schemasItemSetting,headerValue,APIConstant.APIChecksHeader)){
                    result = false;
                    return result;
                }
            }
        }
        if (null != schemasSetting.parameter && schemasSetting.parameter.size() > 0){
            for (APISchemasSetting.APISchemasItemSetting schemasItemSetting : schemasSetting.parameter) {
                String[] parameter = parameters.get(schemasItemSetting.path);
                String parameterValue = null;
                if (null != parameter){
                    parameterValue = String.join("", parameter);
                }
                if (!formatChecks(basePath,schemasItemSetting,parameterValue,APIConstant.APIChecksParameter)){
                    result = false;
                    return result;
                }
            }
        }
        if (null != schemasSetting.body){
            if (!formatChecks(basePath,schemasSetting.body,context,APIConstant.APIChecksBody)){
                result = false;
                return result;
            }
        }
        return result;
    }
    /**
     * 根据请求参数动态读取返回内容
     * @param basePath 基础路径
     * @param dynamicResponseSetting 读取设置
     * @param header 请求头
     * @param parameters 请求参数
     * @param context 请求体
     * @return
     * @throws Exception
     */
    public APIResponse dynamicResponse(String basePath,APIDynamicResponseSetting dynamicResponseSetting,Map<String,String> header,Map<String, String[]> parameters,String context) throws APIException{
        APIResponse result = null;
        StringBuilder stringBuilder = new StringBuilder();
        if (null == dynamicResponseSetting) {
            throw APIException.ErrorException("dynamicResponseSetting null");
        }
        if (null != dynamicResponseSetting.header && dynamicResponseSetting.header.size() > 0){
            for (String path : dynamicResponseSetting.header) {
                String value = header.get(path);
                if (null != value) {
                    stringBuilder.append(value);
                }
            }
        }
        if (null != dynamicResponseSetting.parameters && dynamicResponseSetting.parameters.size() > 0){
            for (String path : dynamicResponseSetting.parameters) {
                String[] parameter = parameters.get(dynamicResponseSetting.parameters);
                String parameterValue = null;
                if (null != parameter){
                    parameterValue = String.join("", parameter);
                }
            }
        }
        if (null != dynamicResponseSetting.body && dynamicResponseSetting.body.size() > 0){
            for (String path : dynamicResponseSetting.body) {
                String value  = APIPathSelect(path, context);
                stringBuilder.append(value);
            }
//            if (APIConstant.APIFormatTypeJson.equals(dynamicResponseSetting.bodyType.toLowerCase())){
//            }
//            else if (APIConstant.APIFormatTypeXML.equals(dynamicResponseSetting.bodyType.toLowerCase())){
//            }
        }
        if (stringBuilder.length() > 0) {
            if (null != dynamicResponseSetting.dynamicResponse) {
                result = dynamicResponseSetting.dynamicResponse.get(stringBuilder.toString());
                if (null != result) {
                    return result;
                }
            }
        }
        return result;
    }
    public String valueToString(List<String> list){
        if (null == list) {
            return "";
        }
        return String.join("", list);
    }
    public String valueToString(String[] strings){
        if (null == strings) {
            return "";
        }
        return String.join("", strings);
    }
    public String valueToString(Object obj){
        if (null == obj){
            return "";
        }
        if (obj instanceof String) {
            return (String) obj;
        }
        else if(obj instanceof Object){
            return obj.toString();
        }
        return "";
    }
    /**
     * 通过jsonpath 查找内容
     * @param jsonPath  jsonpath
     * @param context 内容
     * @return 查找结果，返货Obj.tostring() 结果
     */
    public String apiJsonPathBy(String jsonPath,String context) {
        try {
            if (null == context || null == jsonPath) {
                return "";
            }
            if (context.length() < 1  || jsonPath.length() < 1) {
                return "";
            }
            JSONObject jsonObject = JSONObject.parseObject(context);
            Object obj = JSONPath.eval(jsonObject, jsonPath);
            return valueToString(obj);
        } catch (Exception e) {

        }
        return "";
    }

    /**
     * 通过xpath 查找内容
     * @param xpath 查找的xpath
     * @param context 内容
     * @return 查找结果，如果多个结果按顺序拼接
     */
    public String apiXMLPathBy(String xpath,String context) {
        try {
            if (null == context || null == context) {
                return "";
            }
            if (xpath.length() < 1  || xpath.length() < 1) {
                return "";
            }
            Document document = DocumentHelper.parseText(context);
            List<Node> nodes = document.selectNodes(xpath);
            StringBuilder stringBuilder = new StringBuilder();
            if (null != nodes && nodes.size() > 0){
                for (Node node: nodes) {
                     String value = node.getStringValue();
                    stringBuilder.append(value);
                }
            }
            return stringBuilder.toString();
        }
        catch (Exception e){

        }
        return "";
    }

    public String apiSoapPathBy(String xpath,String context) {
        try {
            if (null == context || null == context) {
                return "";
            }
            if (xpath.length() < 1  || xpath.length() < 1) {
                return "";
            }
            try {
                Document document = DocumentHelper.parseText(context);
                Element element = document.getRootElement().element("body");
//
//                // 将字符串转换为输入流
//                ByteArrayInputStream inputStream = new ByteArrayInputStream(context.getBytes("UTF-8"));
//                // 创建SOAPMessage对象
//                SOAPMessage soapMessage = MessageFactory.newInstance().createMessage(null, inputStream);
//                soapMessage.setContentDescription(context);
//                // 从SOAPMessage中提取SOAPBody
//                SOAPBody soapBody = soapMessage.getSOAPBody();
//                org.w3c.dom.Node node = soapBody.getFirstChild();
//                org.w3c.dom.Document document = node.getOwnerDocument();
//                Document document = DocumentHelper.parseText(soapBodyString);

                List<Node> nodes = document.selectNodes(xpath);
                StringBuilder stringBuilder = new StringBuilder();
////                if (null != nodes && nodes.size() > 0){
//                    for (Node node: nodes) {
//                        String value = node.getStringValue();
//                        stringBuilder.append(value);
//                    }
//                }
                return stringBuilder.toString();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        catch (Exception e){

        }
        return "";
    }
    /**
     * 通过 jsonpath 或 xml xpath 在 context 中查找数据
     * @param path 路径 jsonpath:// 开头使用 jsonpath，xpath:// 使用 xpath 默认使用 xpath
     * @param context 查找内容 如果使用方式和格式不一致时会返回空值
     * @return 查找值
     */
    public String APIPathSelect(String path,String context){
        if (null == path || null == context) {
            return "";
        }
        if (path.length() < 1 || path.length() < 1){
            return "";
        }
        if (path.startsWith(APIConstant.JSONPathPrefix)) {
            return apiJsonPathBy(path.substring(APIConstant.JSONPathPrefix.length()),context);
        }
        else if (path.startsWith(APIConstant.XPathPrefix)) {
            return apiXMLPathBy(path.substring(APIConstant.XPathPrefix.length()),context);
        }
        else if (path.startsWith(APIConstant.SoapPrefix)){
            return apiSoapPathBy(path.substring(APIConstant.XPathPrefix.length()-1),context);
        }
        else {
            return apiJsonPathBy(path,context);
        }
    }
    public String apiPath(String path,String body,Map<String,String> header,Map<String, String[]> parameters){
        String result = "";
        if (null == path && path.length() < 1){
            if (path.startsWith(APIConstant.JSONPathPrefix)){
                result = apiJsonPathBy(path.substring(APIConstant.JSONPathPrefix.length()),body);
            }
            else if (path.startsWith(APIConstant.XPathPrefix)) {
                result = apiXMLPathBy(path.substring(APIConstant.JSONPathPrefix.length()),body);
            }
            else if (path.startsWith(APIConstant.HeaderPath)) {
                if (null == header) {
                    result = valueToString(header.get(path.substring(APIConstant.HeaderPath.length())));
                }
            }
            else if (path.startsWith(APIConstant.ParamsPath)) {
                if (null == parameters) {
                    result = valueToString(header.get(path.substring(APIConstant.ParamsPath.length())));
                }
            }
        }
        return result;
    }
    /**
     * 解析请求
     * @param api API设置
     * @param header 请求头
     * @param parameters 请求参数
     * @param context 请求内容
     * @return
     * @throws Exception
     */
    public APIResponse resolutionRequest(APIEntity api,Map<String,String> header,Map<String, String[]> parameters,String context) throws APIException,APIRequestException {
        APIResponse response = null;
        response = api.defaultResponse;
        if (null == response) {
            response = api.defaultResposne;
        }

        if (null == api.config) {
            return response;
        }
        String input = context;
        try {
            // 是否开启入参数解密
            if (api.config.decryptionEnabled){
                input = decryptionBody(context,api.config.decryptionSetting);
                logger.writeInfo("【%s】解密后的请求数据：%s",api.config.decryptionSetting.mode,input);
            }
            // 是否开启格式格式验证
            if (api.config.schemasVerificationEnabled) {

                if (!formatChecks(api.apiFilePath, api.config.schemasSetting,header,parameters,input)){
                    throw APIRequestException.RequestErrorException(api.defaultErrorResponse, "formatChecks failed");
                }
            }
            // 是否开启格式动态读取
            if (api.config.dynamicResponseEnabled) {
                if (null == api.config.dynamicResponseSetting) {
                    throw APIException.ErrorException("dynamicResponseSetting is null");
                }
                String basePath = api.config.dynamicResponseSetting.basePath;
//                if (null != api.config.dynamicResponseSetting.basePath && api.config.) {
//
//                }
                APIResponse tempResponse = dynamicResponse(basePath,api.config.dynamicResponseSetting,header, parameters, input);
                if (null != tempResponse) {
                    response = tempResponse;
                }
            }
        }
        catch (APIRequestException e){
            logger.writeError(e.getMessage());
            response = e.response;
        }
        catch (APIException e){
            throw e;
        }
        response.body = cloneBodyContext(api.apiFilePath,response.body,"utf-8");
        // 是否开启加密
        if (api.config.encryptionEnabled) {
            logger.writeInfo("返回【%s】加密前数据：%s",api.config.encryptionSetting.mode,response.body);
            response.body = encryptionBody(response.body,api.config.encryptionSetting);
        }
        else {

        }
        logger.writeInfo("返回数据：%s",response.body);

        return response;
    }
    /**
     * 获取返回
     * @param path 请求路径
     * @param header 请求头
     * @param parameters 请求参数
     * @param context 请求体
     * @return 请求结果
     * @throws APIException API 读取异常
     */
    public APIResponse getResponse(String path, Map<String,String> header,Map<String, String[]> parameters,String context) throws APIException {
        try {
            if (null == path || path.length() < 1 ) {
                throw APIException.NotFoundException("请求路径不对 path:" + path);
            }
            APIEntity api = loadAPI(path);
            if (null == api) {
                throw APIException.NotFoundException("Base Path:" + appConfig.basepath + "\nAPI:" + path + " not found");
            }
            APIResponse result = resolutionRequest(api,header,parameters,context);
//            APIResponse result =
//                    api.defaultResponse;
//
//            if (null != api.defaultResponse.body && api.defaultResponse.body.length() > 0){
//                if (api.defaultResponse.body.startsWith(APIConstant.APIFilePrefix)){
//                    String file = api.defaultResponse.body.substring(APIConstant.APIFilePrefix.length());
//                }
//            }
//
//            if (api.config.encryptionEnabled) {
//
//            }
//
//            // 返回数据加密
//            if (api.config.eq) {
//
//            }
            return result;
        }
        catch (APIException e){
            throw e;
        }
        catch (Exception e){
            throw APIException.ErrorException(e.getMessage());
        }
    }
    /**
     * 获取返回
     * @param path 请求路径
     * @param header 请求头
     * @param parameters 请求参数
     * @param input 输入内容
     * @return
     * @throws APIException AIP设置异常
     */
    public APIResponse getResponse(String path, Map<String,String> header,Map<String, String[]> parameters,byte[] input) throws APIException{
        try {
            if (null == path || path.length() < 1 ) {
                throw APIException.NotFoundException("请求路径不对 path:" + path);
            }
            APIEntity api = loadAPI(path);
            if (null == api) {
                throw APIException.NotFoundException("Base Path:" + appConfig.basepath + "\nAPI:" + path + " not found");
            }
            if (api.config.waitingTime > 0) {
                Thread.sleep(Math.min(20*1000, api.config.waitingTime));;
            }
            String inputBodyStr = "";
            if (null != input ){
                inputBodyStr = new String(input, api.config.encoding.length() > 0 ? api.config.encoding : "utf-8");
            }

            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("Request Info:");
            stringBuilder.append("\nPath:" + path);
            stringBuilder.append("\nHeader:");
            if (null != header) {
                for (String key : header.keySet()) {
                    stringBuilder.append(String.format("\n\t%s = %s", key,header.get(key)));
                }
            }
            stringBuilder.append("\nParameter:");
            if (null != parameters) {
                for (String key : parameters.keySet()) {
                    stringBuilder.append(String.format("\n\t%s = %s", key, parameters.get(key).toString()));
                }
            }
            stringBuilder.append("\nbody:");
            stringBuilder.append(String.format("\t%s", inputBodyStr));
            logger.writeInfo(stringBuilder.toString());

            APIResponse result = resolutionRequest(api,header,parameters,inputBodyStr);
//            APIResponse result =
//                    api.defaultResponse;
//
//            if (null != api.defaultResponse.body && api.defaultResponse.body.length() > 0){
//                if (api.defaultResponse.body.startsWith(APIConstant.APIFilePrefix)){
//                    String file = api.defaultResponse.body.substring(APIConstant.APIFilePrefix.length());
//                }
//            }
//
//            if (api.config.encryptionEnabled) {
//
//            }
//
//            // 返回数据加密
//            if (api.config.eq) {
//
//            }
            return result;
        }
        catch (APIException e){
            throw e;
        }
        catch (Exception e){
            throw APIException.ErrorException(e.getStackTrace().toString());
        }
    }
    /**
     * 获取返回
     * @param uri 请求URL
     * @param header 请求头
     * @param parameters 请求参数
     * @param input 输入内容
     * @return
     * @throws APIException
     */
    public ResponseEntity getResponseEntity(String uri, Map<String,String> header,Map<String, String[]> parameters,byte[] input) throws APIException{
        APIResponse apiResponse = getResponse(uri,header,parameters,input);
        HttpHeaders httpHeaders = new HttpHeaders();
        if (null != apiResponse.header && apiResponse.header.size() > 0){
            for (String key : apiResponse.header.keySet()) {
                httpHeaders.add(key,apiResponse.header.get(key));
            }
        }
        ResponseEntity responseEntity = ResponseEntity.status(apiResponse.status).headers(httpHeaders).body(apiResponse.body);
        return responseEntity;
    }
    /**
     * 读取文件内容
     * @param basePath 基础路径
     * @param filePath 文件路径
     * @param charsetName 字符集
     * @return
     */
    public String readFileToString(String basePath,String filePath,String charsetName) throws IOException{
        String result = null;
        File file = FileUtils.getFile(basePath, filePath);
        if (file.exists() || !file.isDirectory()) {
            result = FileUtils.readFileToString(file, charsetName);
        }
        return result;
    }
    /**
     * 获取内容
     * @param basePath 基础路径
     * @param body body内容 或者文件路径 file://
     * @param charsetName 字符集
     * @return
     * @throws APIException
     */
    public String cloneBodyContext(String basePath, String body, String charsetName) throws APIException{
        try {
            if (null != body && body.length() > 0) {
                if (body.startsWith(APIConstant.APIFilePrefix)){
                    String path = body.substring(APIConstant.APIFilePrefix.length());
                    String tempContext = readFileToString(basePath, path,charsetName);
                    if (null != tempContext) {
                        logger.writeInfo("读取返回内容：%s",basePath + File.pathSeparator +  path);
                        return tempContext;
                    }
                }
            }
        }
        catch (IOException e) {
            throw APIException.ErrorException("读取失败：" + "\nBasePath:" + basePath + "\bpath" + body);
        }
        return body;
    }

}
