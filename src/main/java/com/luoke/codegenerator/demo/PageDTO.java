package com.luoke.codegenerator.demo;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

public class PageDTO<T> {
    private int current;

    private int size;

    public IPage<T> getPage() {
        return Page.of(current, size);
    }
}
