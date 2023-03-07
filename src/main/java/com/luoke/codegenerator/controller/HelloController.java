package com.luoke.codegenerator.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author luoke
 * @date 2023/3/7 12:05
 */
@RestController
public class HelloController {
    @GetMapping("/hello")
    public String hello() {
        return "Hello world";
    }
}
