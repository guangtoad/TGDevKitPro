package com.toad.devkit.pro.server.mockapi.controller;

import com.toad.devkit.springframework.controller.BaseController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author toad
 * @time 2024-01-26
 * @description TODO
 */

@RequestMapping("/mockapi")
public class MockApiController extends BaseController {

    @RequestMapping("/*")
    public String anyMockReqeust() {
        return "";
    }
}
