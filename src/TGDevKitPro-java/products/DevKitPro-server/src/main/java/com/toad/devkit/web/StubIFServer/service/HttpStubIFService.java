package com.toad.tool.StubIFServer.service;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.google.gson.Gson;
import com.toad.java.util.TGFileUtil;
import com.toad.java.util.TGStringUtil;
import com.toad.springboot.TGBaseService;
import com.toad.tool.StubIFServer.StubException;
import com.toad.tool.StubIFServer.config.HTTPIFConfig;
import com.toad.tool.StubIFServer.entity.http.HTTPIFRequest;
import com.toad.tool.StubIFServer.entity.http.HTTPIFResponse;

import org.dom4j.DocumentHelper;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.xml.sax.InputSource;

@Service
public class HttpStubIFService extends TGBaseService {

    @Resource
    protected HTTPIFConfig config;

    public String getFileText(String pathStr){
        String result = null;
        try {
            if (null != pathStr && pathStr.length() > 0) {
                Path path = Paths.get(pathStr);
                if (path.isAbsolute()){

                }
                else {
                    path = Paths.get(this.config.rootPath, pathStr);
                }
                File file = path.toFile();
                if (file.exists()) {
                    TGFileUtil.readFile(file);
                    result = TGFileUtil.readFile(file);
                }
            }
        }
        catch (Exception e){

        }
        return result;
    }

    public String getMessage(HTTPIFResponse ifResponse){
        String result = null;
        if (null != ifResponse) {
            String tmpTxt =  this.getFileText(ifResponse.bodyPath);
            if (null != tmpTxt) {
                result = tmpTxt;
            }
            result = ifResponse.body;
        }
        return result;
    }

    public static HttpStubIFService create(){
        return new HttpStubIFService();
    }

    /**
     * 将数据进行 MD5 加密，并以16进制字符串格式输出
     * @param data
     * @return
     */
    public static String md5(String data) {
        StringBuilder sb = new StringBuilder();
        try {
            MessageDigest md = MessageDigest.getInstance("md5");
            byte[] md5 = md.digest(data.getBytes(StandardCharsets.UTF_8));

            // 将字节数据转换为十六进制
            for (byte b : md5) {
                sb.append(Integer.toHexString(b & 0xff));
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }
    // 二进制读取
    public byte[] readAsBytes(HttpServletRequest request){

        if (!"POST".equals(request.getMethod())){
            return null;
        }

        int len = request.getContentLength();
        if (len < 1){
            return null;
        }

        byte[] buffer = new byte[len];
        ServletInputStream in = null;

        try
        {
            in = request.getInputStream();
            in.read(buffer, 0, len);
            in.close();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            if (null != in)
            {
                try
                {
                    in.close();
                }
                catch (IOException e)
                {
                    e.printStackTrace();
                }
            }
        }
        return buffer;
    }

    public HTTPIFRequest getStubRequest(String uri,String rootPath){
        HTTPIFRequest result = null;
        try {
            HTTPIFRequest reqeust = null;
            List<String> apis= Arrays.asList(uri.split("/"));

            if (apis.size() > 1){
                for (int i =  apis.size() - 1; i > 0; i--){
                    String temp = TGStringUtil.join(apis, File.separator, 1, i);
                    System.out.println("temp:" + temp);
                    Path filePath = Paths.get(rootPath,temp + ".json");
                    File file= new File(filePath.toUri());
                    if (file.exists()){
                        String txt = TGFileUtil.readFile(file);
                        Gson gson = new Gson();
                        reqeust = gson.fromJson(txt, HTTPIFRequest.class);
                        reqeust.filePath = filePath.toAbsolutePath().toString();
                        break;
                    }
                }
            }
            result = reqeust;
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    public HTTPIFRequest getStubRequest(String uri){
        String rootPath = null != this.config.rootPath ? this.config.rootPath : "";
        return this.getStubRequest(uri, rootPath);
    }

    public void outputResponse(HttpServletResponse response, Map<String,String> header, String message, int status, String charsetName) throws IOException {

        if (null != header && header.size() > 0){
            for (String key : header.keySet()) {
                response.addHeader(key, header.get(key));
                System.out.println("key = " + key);
            }
        }
        response.setStatus(status);
        ServletOutputStream outputStream = response.getOutputStream();
        OutputStreamWriter outputStreamWriter = new OutputStreamWriter(outputStream,"UTF-8");
        outputStreamWriter.write(message);
        outputStreamWriter.flush();
        outputStreamWriter.close();
    }

    public void outputResponse(HttpServletResponse response, Map<String,String> header, String message, int status) throws IOException {
        this.outputResponse(response, header, message, status, null != this.config.encoding && this.config.encoding.length() > 0 ? this.config.encoding : "utf-8");
    }

    public void outputResponse(HttpServletResponse response, HTTPIFResponse ifResponse) throws Exception{
        this.outputResponse(response,ifResponse.header ,ifResponse.body ,ifResponse.status);
    }

    public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        boolean result = false;

        try {

            if (null == request || null == response) {
                throw new NullPointerException();
            }
            Path rootPath = Paths.get(this.config.rootPath);

            int resStatus = 404;
            String resMessage = "Error";
            Map<String,String> resHeader = null;
            String uri = request.getRequestURI();
            if (null != this.config.site_prefix && uri.startsWith(this.config.site_prefix)){
                uri = uri.replace(this.config.site_prefix,"");
            }
            this.logInfo("IF URL:" + uri);
            HTTPIFRequest ifRequest = this.getStubRequest(uri);

            if (null == ifRequest){
                this.outputResponse(response, null , "API Not Found: " + this.config.rootPath + "\nuri:" + uri, 404);
                return false;
            }

            byte[] readBytes =  this.readAsBytes(request);
            String inputBodyStr = "";
            if (null != readBytes ){
                inputBodyStr = new String(readBytes, this.config.encoding.length() > 0 ? this.config.encoding : "utf-8");
            }

            StringBuffer stringBuffer = new StringBuffer();

            resStatus = ifRequest.defaultResposne.status;
            resHeader = ifRequest.defaultResposne.header;
            resMessage = ifRequest.defaultResposne.body;

            String tmpTxt = this.getMessage(ifRequest.defaultResposne);
            if (null != tmpTxt) {
                resMessage = tmpTxt;
            }

            String fileTxt = this.getFileText(ifRequest.defaultResposne.defResponseFilePath);

            Gson gson = new Gson();
            HTTPIFResponse tmpIFResponse = gson.fromJson(fileTxt, HTTPIFResponse.class);
            if (null != tmpIFResponse){
                tmpTxt = this.getMessage(ifRequest.defaultResposne);
                if (null != tmpTxt) {
                    resMessage = tmpTxt;
                }
            }

            if (ifRequest.config.useExamples){

                if (null != ifRequest.examples.header && ifRequest.examples.header.size() > 1){
                    for (int i = 0; i < ifRequest.examples.header.size(); i++){
                        String key = ifRequest.examples.header.get(i);
                        String value = request.getHeader(key);
                        if (null != value) {
                            stringBuffer.append(value);
                        }
                    }
                }

                if (null != ifRequest.examples.parameters && ifRequest.examples.parameters.size() > 1){
                    for (int i = 0; i < ifRequest.examples.parameters.size(); i++){
                        String key = ifRequest.examples.parameters.get(i);
                        String value = request.getParameter(key);
                        if (null != value) {
                            stringBuffer.append(value);
                        }
                    }
                }
                switch (ifRequest.examples.formatStyle){
                    case 1:{

                        try {
                            Document document = DocumentHelper.parseText(inputBodyStr);
                            if (null != ifRequest.examples.body && ifRequest.examples.body.size() > 0){
                                for (int i = 0; i < ifRequest.examples.body.size(); i++){
                                    String value = null;
                                    String xpath = ifRequest.examples.body.get(i);

                                    try{
                                        List<Node> list = document.selectNodes(xpath);
                                        if (null != list && list.size() > 0){
                                            Node node = list.get(0);
                                            value = node.getStringValue();
                                            stringBuffer.append(value);
                                        }
                                    }
                                    catch (Exception e){

                                    }
                                }
                            }
                        }
                        catch (Exception e){

                        }
                    }
                    break;
                    case 0:
                    default:{
                        if (null != ifRequest.examples.body && ifRequest.examples.body.size() > 0){
                            for (int i = 0; i < ifRequest.examples.body.size(); i++){
                                try {
                                    String jsonPath = ifRequest.examples.body.get(i);

                                    JSONObject jsonObject = JSONObject.parseObject(inputBodyStr);
                                    Object obj = JSONPath.eval(jsonObject, jsonPath);

                                    if (null != obj) {
                                        if(obj instanceof String) {
                                            stringBuffer.append(obj);
                                        }
                                        else {
                                            stringBuffer.append(obj.toString());
                                        }
                                    }
                                }
                                catch (Exception e){
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                    break;
                }
                String eif = stringBuffer.toString();
                if (eif.length() > 0){
                    if (eif.length() > Math.min(Math.max(32, this.config.maxLen), 128)){
                        eif = md5(eif);
                    }
                    if (null != ifRequest.examples.examplesPath && ifRequest.examples.examplesPath.length() > 0){
                        eif = ifRequest.examples.examplesPath + File.separator + eif;
                    }
                    tmpTxt =  this.getFileText(eif + ".json");
                    if (null != tmpTxt) {
                        switch (ifRequest.examples.exampleType) {
                            case 1:{
                                resStatus =  0 != ifRequest.examples.defStatus ? ifRequest.examples.defStatus : ifRequest.defaultResposne.status;
                                resHeader =  null != ifRequest.examples.defHeader ? ifRequest.examples.defHeader : ifRequest.defaultResposne.header;
                                if (null != tmpTxt) {
                                    resMessage = tmpTxt;
                                }
                            }
                            break;
                            case 0:
                            default:{
                                if (null != tmpTxt) {
                                    Gson tmpGson = new Gson();
                                    HTTPIFResponse tmpResponse = tmpGson.fromJson(tmpTxt, HTTPIFResponse.class);
                                    resStatus =  0 != tmpResponse.status ? tmpResponse.status : ifRequest.defaultResposne.status;
                                    resHeader =  null != tmpResponse.header ? tmpResponse.header : ifRequest.defaultResposne.header;
                                    if (null != tmpTxt) {
                                        resMessage = tmpTxt;
                                    }
                                    String tmpMsg =  this.getMessage(tmpResponse);
                                }
                            }
                            break;
                        }
                    }
                }
                else {

                }
            }
            this.outputResponse(response, resHeader, resMessage, resStatus);
        }
        catch (Exception e){

            StackTraceElement stackTraceElement= e.getStackTrace()[0];// 得到异常棧的首个元素

            String message =  "API Setting Error " + "File="+stackTraceElement.getFileName()
                    + "Line="+stackTraceElement.getLineNumber()
            + "Method="+stackTraceElement.getMethodName();

            this.outputResponse(response, null , message, 500);
            throw e;
        }
        finally {

        }
        return result;
    }

    public ResponseEntity<String> getResponse(HttpServletRequest request, HttpServletResponse response) throws StubException {
        ResponseEntity<String> result = null;

        try {

            if (null == request || null == response) {
                throw new NullPointerException();
            }
            Path rootPath = Paths.get(this.config.rootPath);

            int resStatus = 404;
            String resMessage = "Error";
            Map<String,String> resHeader = null;
            String uri = request.getRequestURI();
            if (null != this.config.site_prefix && uri.startsWith(this.config.site_prefix)){
                uri = uri.replace(this.config.site_prefix,"");
            }
            this.logInfo("IF URL:" + uri);
            HTTPIFRequest ifRequest = this.getStubRequest(uri);

            if (null == ifRequest){
                throw new StubException(404, "API Not Found: " + this.config.rootPath + "\nuri:" + uri);
            }

            byte[] readBytes =  this.readAsBytes(request);
            String inputBodyStr = "";
            if (null != readBytes ){
                inputBodyStr = new String(readBytes, this.config.encoding.length() > 0 ? this.config.encoding : "utf-8");
            }

            StringBuffer stringBuffer = new StringBuffer();

            resStatus = ifRequest.defaultResposne.status;
            resHeader = ifRequest.defaultResposne.header;
            resMessage = ifRequest.defaultResposne.body;

            String tmpTxt = this.getMessage(ifRequest.defaultResposne);
            if (null != tmpTxt) {
                resMessage = tmpTxt;
            }

            String fileTxt = this.getFileText(ifRequest.defaultResposne.defResponseFilePath);

            Gson gson = new Gson();
            HTTPIFResponse tmpIFResponse = gson.fromJson(fileTxt, HTTPIFResponse.class);
            if (null != tmpIFResponse){
                tmpTxt = this.getMessage(ifRequest.defaultResposne);
                if (null != tmpTxt) {
                    resMessage = tmpTxt;
                }
            }

            if (ifRequest.config.useExamples){

                if (null != ifRequest.examples.header && ifRequest.examples.header.size() > 1){
                    for (int i = 0; i < ifRequest.examples.header.size(); i++){
                        String key = ifRequest.examples.header.get(i);
                        String value = request.getHeader(key);
                        if (null != value) {
                            stringBuffer.append(value);
                        }
                    }
                }

                if (null != ifRequest.examples.parameters && ifRequest.examples.parameters.size() > 1){
                    for (int i = 0; i < ifRequest.examples.parameters.size(); i++){
                        String key = ifRequest.examples.parameters.get(i);
                        String value = request.getParameter(key);
                        if (null != value) {
                            stringBuffer.append(value);
                        }
                    }
                }
                switch (ifRequest.examples.formatStyle){
                    case 1:{

                        try {
                            Document document = DocumentHelper.parseText(inputBodyStr);
                            if (null != ifRequest.examples.body && ifRequest.examples.body.size() > 0){
                                for (int i = 0; i < ifRequest.examples.body.size(); i++){
                                    String value = null;
                                    String xpath = ifRequest.examples.body.get(i);

                                    try{
                                        List<Node> list = document.selectNodes(xpath);
                                        if (null != list && list.size() > 0){
                                            Node node = list.get(0);
                                            value = node.getStringValue();
                                            stringBuffer.append(value);
                                        }
                                    }
                                    catch (Exception e){

                                    }
                                }
                            }
                        }
                        catch (Exception e){

                        }
                    }
                    break;
                    case 0:
                    default:{
                        if (null != ifRequest.examples.body && ifRequest.examples.body.size() > 0){
                            for (int i = 0; i < ifRequest.examples.body.size(); i++){
                                try {
                                    String jsonPath = ifRequest.examples.body.get(i);

                                    JSONObject jsonObject = JSONObject.parseObject(inputBodyStr);
                                    Object obj = JSONPath.eval(jsonObject, jsonPath);

                                    if (null != obj) {
                                        if(obj instanceof String) {
                                            stringBuffer.append(obj);
                                        }
                                        else {
                                            stringBuffer.append(obj.toString());
                                        }
                                    }
                                }
                                catch (Exception e){
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                    break;
                }
                String eif = stringBuffer.toString();
                if (eif.length() > 0){
                    if (eif.length() > Math.min(Math.max(32, this.config.maxLen), 128)){
                        eif = md5(eif);
                    }
                    if (null != ifRequest.examples.examplesPath && ifRequest.examples.examplesPath.length() > 0){
                        eif = ifRequest.examples.examplesPath + File.separator + eif;
                    }
                    tmpTxt =  this.getFileText(eif + ".json");
                    if (null != tmpTxt) {
                        switch (ifRequest.examples.exampleType) {
                            case 1:{
                                resStatus =  0 != ifRequest.examples.defStatus ? ifRequest.examples.defStatus : ifRequest.defaultResposne.status;
                                resHeader =  null != ifRequest.examples.defHeader ? ifRequest.examples.defHeader : ifRequest.defaultResposne.header;
                                if (null != tmpTxt) {
                                    resMessage = tmpTxt;
                                }
                            }
                            break;
                            case 0:
                            default:{
                                if (null != tmpTxt) {
                                    Gson tmpGson = new Gson();
                                    HTTPIFResponse tmpResponse = tmpGson.fromJson(tmpTxt, HTTPIFResponse.class);
                                    resStatus =  0 != tmpResponse.status ? tmpResponse.status : ifRequest.defaultResposne.status;
                                    resHeader =  null != tmpResponse.header ? tmpResponse.header : ifRequest.defaultResposne.header;
                                    if (null != tmpTxt) {
                                        resMessage = tmpTxt;
                                    }
                                    String tmpMsg =  this.getMessage(tmpResponse);
                                }
                            }
                            break;
                        }
                    }
                }
                else {

                }
            }
            HttpHeaders httpHeaders = new HttpHeaders();
            if (null != resHeader && resHeader.size() > 0){
                for (String key : resHeader.keySet()) {
                    httpHeaders.add(key,resHeader.get(key));
                }
            }
            result = ResponseEntity.status(resStatus)
                    .headers(httpHeaders)
                    .body(resMessage);
//            this.outputResponse(response, resHeader, resMessage, resStatus);
        }
        catch (StubException e){
            throw e;
        }
        catch (Exception e){
            StackTraceElement stackTraceElement= e.getStackTrace()[0];// 得到异常棧的首个元素
            String message =  "API Setting Error " + "File="+stackTraceElement.getFileName()
                    + "Line="+stackTraceElement.getLineNumber()
                    + "Method="+stackTraceElement.getMethodName();
            throw new StubException(500, message);
        }
        finally {

        }
        return result;
    }
    public String getResultString(HttpServletRequest request, HttpServletResponse response) throws Exception{

        String result = "";

        try {

            if (null == request || null == response) {
                throw new NullPointerException();
            }
            Path rootPath = Paths.get(this.config.rootPath);

            int resStatus = 404;
            String resMessage = "Error";
            Map<String,String> resHeader = null;
            String uri = request.getRequestURI();
            if (null != this.config.site_prefix && uri.startsWith(this.config.site_prefix)){
                uri = uri.replace(this.config.site_prefix,"");
            }
            this.logInfo("IF URL:" + uri);
            HTTPIFRequest ifRequest = this.getStubRequest(uri);

            if (null == ifRequest){
                this.outputResponse(response, null , "API Not Found: " + this.config.rootPath + "\nuri:" + uri, 404);
                return result;
            }

            byte[] readBytes =  this.readAsBytes(request);
            String inputBodyStr = "";
            if (null != readBytes ){
                inputBodyStr = new String(readBytes, this.config.encoding.length() > 0 ? this.config.encoding : "utf-8");
            }

            StringBuffer stringBuffer = new StringBuffer();

            resStatus = ifRequest.defaultResposne.status;
            resHeader = ifRequest.defaultResposne.header;
            resMessage = ifRequest.defaultResposne.body;

            String tmpTxt = this.getMessage(ifRequest.defaultResposne);
            if (null != tmpTxt) {
                resMessage = tmpTxt;
            }

            String fileTxt = this.getFileText(ifRequest.defaultResposne.defResponseFilePath);

            Gson gson = new Gson();
            HTTPIFResponse tmpIFResponse = gson.fromJson(fileTxt, HTTPIFResponse.class);
            if (null != tmpIFResponse){
                tmpTxt = this.getMessage(ifRequest.defaultResposne);
                if (null != tmpTxt) {
                    resMessage = tmpTxt;
                }
            }

            if (ifRequest.config.useExamples){

                if (null != ifRequest.examples.header && ifRequest.examples.header.size() > 1){
                    for (int i = 0; i < ifRequest.examples.header.size(); i++){
                        String key = ifRequest.examples.header.get(i);
                        String value = request.getHeader(key);
                        if (null != value) {
                            stringBuffer.append(value);
                        }
                    }
                }

                if (null != ifRequest.examples.parameters && ifRequest.examples.parameters.size() > 1){
                    for (int i = 0; i < ifRequest.examples.parameters.size(); i++){
                        String key = ifRequest.examples.parameters.get(i);
                        String value = request.getParameter(key);
                        if (null != value) {
                            stringBuffer.append(value);
                        }
                    }
                }
                switch (ifRequest.examples.formatStyle){
                    case 1:{

                        try {
                            Document document = DocumentHelper.parseText(inputBodyStr);
                            if (null != ifRequest.examples.body && ifRequest.examples.body.size() > 0){
                                for (int i = 0; i < ifRequest.examples.body.size(); i++){
                                    String value = null;
                                    String xpath = ifRequest.examples.body.get(i);

                                    try{
                                        List<Node> list = document.selectNodes(xpath);
                                        if (null != list && list.size() > 0){
                                            Node node = list.get(0);
                                            value = node.getStringValue();
                                            stringBuffer.append(value);
                                        }
                                    }
                                    catch (Exception e){

                                    }
                                }
                            }
                        }
                        catch (Exception e){

                        }
                    }
                    break;
                    case 0:
                    default:{
                        if (null != ifRequest.examples.body && ifRequest.examples.body.size() > 0){
                            for (int i = 0; i < ifRequest.examples.body.size(); i++){
                                try {
                                    String jsonPath = ifRequest.examples.body.get(i);

                                    JSONObject jsonObject = JSONObject.parseObject(inputBodyStr);
                                    Object obj = JSONPath.eval(jsonObject, jsonPath);

                                    if (null != obj) {
                                        if(obj instanceof String) {
                                            stringBuffer.append(obj);
                                        }
                                        else {
                                            stringBuffer.append(obj.toString());
                                        }
                                    }
                                }
                                catch (Exception e){
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                    break;
                }
                String eif = stringBuffer.toString();
                if (eif.length() > 0){
                    if (eif.length() > Math.min(Math.max(32, this.config.maxLen), 128)){
                        eif = md5(eif);
                    }
                    if (null != ifRequest.examples.examplesPath && ifRequest.examples.examplesPath.length() > 0){
                        eif = ifRequest.examples.examplesPath + File.separator + eif;
                    }
                    tmpTxt =  this.getFileText(eif + ".json");
                    if (null != tmpTxt) {
                        switch (ifRequest.examples.exampleType) {
                            case 1:{
                                resStatus =  0 != ifRequest.examples.defStatus ? ifRequest.examples.defStatus : ifRequest.defaultResposne.status;
                                resHeader =  null != ifRequest.examples.defHeader ? ifRequest.examples.defHeader : ifRequest.defaultResposne.header;
                                if (null != tmpTxt) {
                                    resMessage = tmpTxt;
                                }
                            }
                            break;
                            case 0:
                            default:{
                                if (null != tmpTxt) {
                                    Gson tmpGson = new Gson();
                                    HTTPIFResponse tmpResponse = tmpGson.fromJson(tmpTxt, HTTPIFResponse.class);
                                    resStatus =  0 != tmpResponse.status ? tmpResponse.status : ifRequest.defaultResposne.status;
                                    resHeader =  null != tmpResponse.header ? tmpResponse.header : ifRequest.defaultResposne.header;
                                    if (null != tmpTxt) {
                                        resMessage = tmpTxt;
                                    }
                                    String tmpMsg =  this.getMessage(tmpResponse);
                                }
                            }
                            break;
                        }
                    }
                }
                else {

                }
            }
            this.outputResponse(response, resHeader, resMessage, resStatus);
        }
        catch (Exception e){

            StackTraceElement stackTraceElement= e.getStackTrace()[0];// 得到异常棧的首个元素

            String message =  "API Setting Error " + "File="+stackTraceElement.getFileName()
                    + "Line="+stackTraceElement.getLineNumber()
                    + "Method="+stackTraceElement.getMethodName();

            this.outputResponse(response, null , message, 500);
            throw e;
        }
        finally {

        }
        return result;
    }
}
