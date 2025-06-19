package com.toad.tool.StubIFServer.controller;

import com.toad.tool.StubIFServer.StubException;
import com.toad.tool.StubIFServer.service.HttpStubIFService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@RestController
@RequestMapping("/")
public class HttpStubIFController extends StubController {

    @Autowired
    HttpStubIFService loginService ;

    @RequestMapping(value = "/api/**", produces = "application/json; charset=utf-8")
    public ResponseEntity<String> stubAPI(HttpServletRequest request, HttpServletResponse response){
        ResponseEntity<String> responseEntity = null;
        try {
            responseEntity = loginService.getResponse(request, response);
        }
        catch (StubException e){
            responseEntity = ResponseEntity.status(e.httpStatus)
                    .body(e.getMessage());
        }
        catch (Exception e){
            responseEntity = ResponseEntity.status(500)
                    .body("Exception:\n"+ e);

        }
        return responseEntity;
    }

    @RequestMapping(value = "**", produces = "application/json; charset=utf-8")
    public void stubIF(HttpServletRequest request, HttpServletResponse response) {
        try {
            if (loginService.execute(request, response)){

            }
            else {

            }
        }
        catch (Exception e){

        }
        finally {

        }
    }


}
