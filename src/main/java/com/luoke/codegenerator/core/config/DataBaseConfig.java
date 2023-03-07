package com.luoke.codegenerator.core.config;

import lombok.Data;

/**
 * 数据库配置
 * @author luoke
 * @date 2023-03-07 22:49
 */
@Data
public class DataBaseConfig {
    /**
     * 作者
     */
    private String url;
    /**
     * 包
     */
    private String username;
    /**
     * 模块名
     */
    private String password;
}
