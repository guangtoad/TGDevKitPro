package com.toad.devkit.pro.server.interceptor;


import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//
//public class ResponseInterceptor implements HandlerInterceptor {
////
////    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
////        // 在请求处理之前进行调用（Controller 方法调用之前）
////        return true; // 只有返回 true 才会继续向下执行，返回 false 则取消当前请求
////    }
////
////    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
////        // 请求处理之后进行调用，但是在视图被渲染之前（Controller 方法调用之后）
////        // 这里可以对响应进行处理
////        // 示例：修改响应头
////        response.setHeader("Custom-Header", "Custom-Value");
////
////        // 示例：修改响应内容（需要注意处理响应输出流）
////        // 以下代码仅为示例，实际使用时需要更复杂的处理
////        // String newContent = "Modified response content";
////        // response.setContentType("text/plain;charset=UTF-8");
////        // response.getWriter().write(newContent);
////    }
////
////    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
////        // 整个请求处理完毕调用，即在视图渲染完毕时调用
////    }
//}