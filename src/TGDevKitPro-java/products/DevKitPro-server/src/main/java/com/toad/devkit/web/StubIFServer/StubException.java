package com.toad.tool.StubIFServer;

import org.springframework.http.HttpHeaders;

public class StubException extends Exception{
    public int httpStatus = 500;
    public HttpHeaders headers = null;
    public StubException(int httpStatus,String message){
        super(message);
        this.httpStatus = httpStatus;

    }
}
