package com.luoke.codegenerator.core.config;

import lombok.Data;

/**
 * @author luoke
 * @date 2023-03-07 22:49
 */
@Data
public class CodeGeneratorConfig {
    /**
     * 作者
     */
    private String author;
    /**
     * 包
     */
    private String basePackage;
    /**
     * 模块名
     */
    private String module;

    /**
     * 继承实体全类名
     */
    private String superClass;
}
