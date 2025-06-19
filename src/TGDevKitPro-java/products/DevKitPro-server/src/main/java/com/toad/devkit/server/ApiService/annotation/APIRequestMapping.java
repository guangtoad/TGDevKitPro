package com.toad.ApiService.annotation;

import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.lang.annotation.*;
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@RequestMapping
public @interface APIRequestMapping{

    String apicode() default "";
}
