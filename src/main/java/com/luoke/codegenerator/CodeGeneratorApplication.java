package com.luoke.codegenerator;

import org.mybatis.spring.annotation.MapperScan;
import org.mybatis.spring.annotation.MapperScans;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"org.luoke", "com.luoke"})
public class CodeGeneratorApplication {

    public static void main(String[] args) {
        SpringApplication.run(CodeGeneratorApplication.class, args);
    }

}
