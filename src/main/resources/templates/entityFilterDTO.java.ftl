package ${package.Parent}.dto;

import com.google.common.base.Converter;
import org.luoke.springboot.template.springboottemplateweb.common.dto.PageDTO;
import ${package.Entity}.${entity};
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
    <#if chainModel>
import lombok.experimental.Accessors;
    </#if>
</#if>

/**
* <p>
* ${table.comment!} 新增 DTO 对象
* </p>
*
* @author ${author}
* @since ${date}
*/
<#if entityLombokModel>
@Getter
@Setter
    <#if chainModel>
@Accessors(chain = true)
    </#if>
</#if>
<#if swagger>
    @ApiModel(value = "${entity}对象", description = "${table.comment!}")
</#if>
public class ${entity}FilterDTO extends PageDTO {
<#assign entityCapitalName="${entity?substring(0,1)?lower_case}${entity?substring(1)}"/>
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>

    <#if field.comment!?length gt 0>
        <#if springdoc>
            @Schema(description = "${field.comment}")
        <#elseif swagger>
            @ApiModelProperty("${field.comment}")
        <#else>
    /**
    * ${field.comment}
    */
        </#if>
    </#if>
    private ${field.propertyType} ${field.propertyName};
</#list>
<#------------  END 字段循环遍历  ---------->

    /**
    * 转换为 {@link ${entity}} 对象
    *
    * @return {@link ${entity}}
    */
    public ${entity} convertTo${entity}() {
        return new ${entity}FilterDTOConverter().doForward(this);
    }

    public static class ${entity}FilterDTOConverter extends Converter<${entity}FilterDTO, ${entity}> {
        @Override
        protected ${entity} doForward(${entity}FilterDTO favoriteFilterDTO) {
        <#if entityLombokModel>
            return ${entity}.builder()
            <#list table.fields as field>
                <#if field.propertyType == "boolean">
                    <#assign getprefix="is"/>
                <#else>
                    <#assign getprefix="get"/>
                </#if>
                .${field.propertyName}(${entity?substring(0,1)?lower_case}${entity?substring(1)}FilterDTO.${getprefix}${field.capitalName}())
            </#list>
            .build();
        <#else>
            ${entity} ${entityCapitalName} = new ${entity}();
            <#list table.fields as field>
                <#if field.propertyType == "boolean">
                    <#assign getprefix="is"/>
                <#else>
                    <#assign getprefix="get"/>
                </#if>
            ${entityCapitalName}.set${field.capitalName}(${entityCapitalName}FilterDTO.${getprefix}${field.capitalName}());
            </#list>
            return ${entityCapitalName};
        </#if>
        }

        @Override
        protected ${entity}FilterDTO doBackward(${entity} favorite) {
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
