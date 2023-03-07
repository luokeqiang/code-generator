package ${package.ServiceImpl};

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.luoke.springboot.template.springboottemplateweb.common.exception.BusinessException;
import org.luoke.springboot.template.springboottemplateweb.common.response.ResponseExceptionEnum;
import org.springframework.transaction.annotation.Transactional;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${package.Entity}.${entity};
import ${package.Parent}.dto.${entity}CreateDTO;
import ${package.Parent}.dto.${entity}UpdateDTO;
import ${package.Parent}.dto.${entity}FilterDTO;
import ${package.Parent}.vo.${entity}DetailVO;
import ${package.Parent}.vo.${entity}ListVO;
import ${package.Mapper}.${table.mapperName};
<#if table.serviceInterface>
import ${package.Service}.${table.serviceName};
</#if>
import ${superServiceImplClassPackage};
import org.springframework.stereotype.Service;

/**
* <p>
* ${table.comment!} 服务实现类
* </p>
*
* @author ${author}
* @since ${date}
*/
@Service
@Slf4j
<#if kotlin>
open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>()<#if table.serviceInterface>, ${table.serviceName}</#if> {

}
<#else>
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}><#if table.serviceInterface> implements ${table.serviceName}</#if> {
<#assign entityName="${entity?substring(0,1)?lower_case}${entity?substring(1)}"/>
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ${entity} create(${entity}CreateDTO ${entityName}CreateDTO) {
        final ${entity} ${entityName} = ${entityName}CreateDTO.convertTo${entity}();
        final int insertCount = getBaseMapper().insert(${entityName});
        if (insertCount == 0) {
            log.error("新增${table.comment!}失败");
        }
        return ${entityName};
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(${entity}UpdateDTO ${entityName}UpdateDTO) {
        log.info("修改${table.comment!}，id = {}", ${entityName}UpdateDTO.getId());
        final ${entity} ${entityName} = find(${entityName}UpdateDTO.getId());
        ${entityName}.setTitle(${entityName}UpdateDTO.getTitle());
        ${entityName}.setUrl(${entityName}UpdateDTO.getUrl());
        return getBaseMapper().updateById(${entityName});
    }

    @Override
    public ${entity} find(String id) {
        if (StringUtils.isBlank(id)) {
            throw new IllegalArgumentException("主键 ID 不能为空");
        }
        final ${entity} ${entityName} = getBaseMapper().selectById(id);
        if (${entityName} == null) {
            log.error("通过 id 查询${table.comment!}错误，原因: 相关数据不存在， id = {}", id);
            throw new BusinessException(ResponseExceptionEnum.RESULT_NOT_EXISTS);
        }
        return ${entityName};
    }

    @Override
    public ${entity}DetailVO detail(String id) {
        return ${entity}DetailVO.convertFor(find(id));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int delete(String id) {
        log.info("删除${table.comment!}，id = {}", id);
        // 校验数据是否存在
        detail(id);
        return getBaseMapper().deleteById(id);
    }

    @Override
    public IPage<${entity}ListVO> listByPage(${entity}FilterDTO ${entityName}FilterDTOPage) {
        final Page<${entity}> page = Page.of(${entityName}FilterDTOPage.getCurrent(), ${entityName}FilterDTOPage.getSize());
        final LambdaQueryWrapper<${entity}> wrapper = new LambdaQueryWrapper<${entity}>()
    <#list table.fields as field>
            .eq(StringUtils.isNotBlank(${entityName}FilterDTOPage.get${field.capitalName}()), ${entity}::get${field.capitalName}, ${entityName}FilterDTOPage.get${field.capitalName}())
    </#list>
            ;
        return getBaseMapper().selectPage(page, wrapper).convert(${entity}ListVO::convertFor);
    }
}
    </#if>
