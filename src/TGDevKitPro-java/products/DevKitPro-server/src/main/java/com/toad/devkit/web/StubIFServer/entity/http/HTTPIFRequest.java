package com.toad.tool.StubIFServer.entity.http;

import com.toad.tool.StubIFServer.config.HTTPIFConfig;

public class HTTPIFRequest extends HTTPIF {

    public String filePath;

    public String IF_Name;

    public String IF_description;

    public HTTPIFRequestConfig config;

    public HTTPIFResponse defaultResposne;

    public HTTPIFExamples examples;


    public HTTPIFRequest(String uri) throws Exception{

    }

    public static HTTPIFRequest create(String uri) throws Exception{
        return new HTTPIFRequest(uri);
    }

}
