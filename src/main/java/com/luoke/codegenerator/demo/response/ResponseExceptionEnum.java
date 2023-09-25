package com.luoke.codegenerator.demo.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author luoke
 * @date 2023-02-25 23:17
 */
@AllArgsConstructor
@Getter
public enum ResponseExceptionEnum {
    SUCCESS(200, "操作成功"),
    BAD_REQUEST(400, "参数异常"),
    UN_AUTHENTICATION(401, "未授权"),
    SERVLET_INTER_ERROR(500, "系统错误"),
    RESULT_NOT_EXISTS(1001, "数据不存在");

    /**
     * 状态吗
     */
    private final int code;

    /**
     * 异常信息
     */
    private final String message;
}
