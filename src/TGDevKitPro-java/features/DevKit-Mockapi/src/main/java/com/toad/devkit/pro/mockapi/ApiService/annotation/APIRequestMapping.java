package com.toad.devkit.pro.mockapi.ApiService.annotation;


import java.lang.annotation.*;
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
//@RequestMapping
public @interface APIRequestMapping{

    String apicode() default "";
}
