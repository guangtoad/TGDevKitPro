package com.toad.tool.StubIFServer.entity.http;

import java.util.Map;

public class HTTPIFResponse extends HTTPIF {

    public String defResponseFilePath;

    public int status;

    public Map<String,String> header;

    public String body;
    public String bodyPath;
    public int waitingTime;

}
