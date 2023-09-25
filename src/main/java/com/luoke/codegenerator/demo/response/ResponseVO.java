package com.luoke.codegenerator.demo.response;

import lombok.Data;

/**
 * 封装通用返回对象
 *
 * @author luoke
 * @date 2023-02-25 23:13
 */
@Data
public class ResponseVO<T> {
    /**
     * 响应吗
     */
    private int code;

    /**
     * 返回数据
     */
    private T data;

    /**
     * 响应消息
     */
    private String message;

    public ResponseVO(int code, T data, String message) {
        this.code = code;
        this.data = data;
        this.message = message;
    }

    public static <T> ResponseVO<T> ok(T data) {
        return new ResponseVO<>(ResponseExceptionEnum.SUCCESS.getCode(), data, null);
    }

    public static <T> ResponseVO<T> ok(String message) {
        return new ResponseVO<>(ResponseExceptionEnum.SUCCESS.getCode(), null, message);
    }

    public static <T> ResponseVO<T> fail(String message) {
        return new ResponseVO<>(ResponseExceptionEnum.SERVLET_INTER_ERROR.getCode(), null, message);
    }

    public static <T> ResponseVO<T> fail(int code, String message) {
        return new ResponseVO<>(code, null, message);
    }
}
