package ${package.Parent}.vo;

import com.google.common.base.Converter;
import ${package.Entity}.${entity};

import java.util.List;
<#list table.importPackages as pkg>
    import ${pkg};
</#list>
<#if springdoc>
    import io.swagger.v3.oas.annotations.media.Schema;
<#elseif swagger>
    import io.swagger.annotations.ApiModel;
    import io.swagger.annotations.ApiModelProperty;
</#if>
<#if entityLombokModel>
import lombok.Getter;
import lombok.Setter;
import lombok.Builder;
    <#if chainModel>
import lombok.experimental.Accessors;
    </#if>
</#if>

/**
* <p>
* ${table.comment!} VO 对象
* </p>
*
* @author ${author}
* @since ${date}
*/
<#if entityLombokModel>
@Getter
@Setter
@Builder
    <#if chainModel>
@Accessors(chain = true)
    </#if>
</#if>
<#if swagger>
@ApiModel(value = "${entity}对象", description = "${table.comment!}")
</#if>
public class ${entity}DetailVO {
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>

    <#if field.comment!?length gt 0>
        <#if swagger>
            @ApiModelProperty("${field.comment}")
        <#else>
    /**
    * ${field.comment}
    */
        </#if>
    </#if>
<#-- 普通字段 -->
    private ${field.propertyType} ${field.propertyName};
</#list>
<#assign entityCapitalName="${entity?substring(0,1)?lower_case}${entity?substring(1)}"/>
<#------------  END 字段循环遍历  ---------->

    /**
    * 将 {@link ${entity}} 实体 转换为 {@link ${entity}DetailVO} 对象
    * @param ${entityCapitalName} {@link ${entity}} 实体对象
    * @return {@link ${entity}DetailVO}
    */
    public static ${entity}DetailVO convertFor(${entity} ${entityCapitalName}) {
        return new ${entity}DetailVOConverter().convert(${entityCapitalName});
    }

    public static class ${entity}DetailVOConverter extends Converter<${entity}, ${entity}DetailVO> {
        @Override
        protected ${entity}DetailVO doForward(${entity} ${entityCapitalName}) {
        <#if entityLombokModel>
            return ${entity}DetailVO.builder()
            <#list table.fields as field>
                <#if field.propertyType == "boolean">
                    <#assign getprefix="is"/>
                <#else>
                    <#assign getprefix="get"/>
                </#if>
                .${field.propertyName}(${entityCapitalName}.${getprefix}${field.capitalName}())
            </#list>
            .build();
        <#else>
            ${entity}DetailVO ${entityCapitalName}DetailVO = new ${entity}DetailVO();
            <#list table.fields as field>
                <#if field.propertyType == "boolean">
                    <#assign getprefix="is"/>
                <#else>
                    <#assign getprefix="get"/>
                </#if>
            ${entityCapitalName}DetailVO.set${field.capitalName}(${entityCapitalName}.${getprefix}${field.capitalName}());
            </#list>
            return ${entityCapitalName}DetailVO;
        </#if>
        }

        @Override
        protected ${entity} doBackward(${entity}DetailVO ${entityCapitalName}DetailVO) {
            throw new UnsupportedOperationException();
        }
    }
<#if !entityLombokModel>
    <#list table.fields as field>
        <#if field.propertyType == "boolean">
            <#assign getprefix="is"/>
        <#else>
            <#assign getprefix="get"/>
        </#if>

    public ${field.propertyType} ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
    }

        <#if chainModel>
    public ${entity} set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
        <#else>
    public void set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
        </#if>
        this.${field.propertyName} = ${field.propertyName};
        <#if chainModel>
        return this;
        </#if>
    }
    </#list>
</#if>
<#if entityColumnConstant>
    <#list table.fields as field>

        public static final String ${field.name?upper_case} = "${field.name}";
    </#list>
</#if>
<#if activeRecord>

    @Override
    public Serializable pkVal() {
    <#if keyPropertyName??>
        return this.${keyPropertyName};
    <#else>
        return null;
    </#if>
    }
</#if>
<#if !entityLombokModel>

    @Override
    public String toString() {
        return "${entity}{" +
        <#list table.fields as field>
            <#if field_index==0>
                "${field.propertyName} = " + ${field.propertyName} +
            <#else>
                ", ${field.propertyName} = " + ${field.propertyName} +
            </#if>
        </#list>
                "}";
    }
</#if>
}
