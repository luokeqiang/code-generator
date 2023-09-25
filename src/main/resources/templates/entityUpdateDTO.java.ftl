package ${package.Parent}.dto;

<#list table.importPackages as pkg>
import ${pkg};
</#list>
<#if springdoc>
import io.swagger.v3.oas.annotations.media.Schema;
<#elseif swagger>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
<#if entityLombokModel>
import ${package.Entity}.${entity};
import lombok.Getter;
import lombok.Setter;
    <#if chainModel>
import lombok.experimental.Accessors;
    </#if>
</#if>

/**
* <p>
* ${table.comment!} 修改 DTO 对象
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
public class ${entity}UpdateDTO {
<#assign entityCapitalName="${entity?substring(0,1)?lower_case}${entity?substring(1)}"/>
    /**
     * 主键标识
     */
    private String id;
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
    <#if field.propertyType=='String'>
    @NotBlank(message = "${field.comment}不能为空")
    <#else>
    @NotNull(message = "${field.comment}不能为空")
    </#if>
    private ${field.propertyType} ${field.propertyName};
</#list>
<#------------  END 字段循环遍历  ---------->
<#if !entityLombokModel>
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
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
    /**
     * 转换为 {@link ${entity}} 对象
     *
     * @return {@link ${entity}}
     */
    public ${entity} convertTo${entity}() {
        return new ${entity}UpdateDTOConverter().doForward(this);
    }

    public static class ${entity}UpdateDTOConverter extends Converter<${entity}UpdateDTO, ${entity}> {
        @Override
        protected ${entity} doForward(${entity}UpdateDTO ${entityCapitalName}UpdateDTO) {
        <#if entityLombokModel>
            return ${entity}.builder()
            <#list table.fields as field>
                <#if field.propertyType == "boolean">
                    <#assign getprefix="is"/>
                <#else>
                    <#assign getprefix="get"/>
                </#if>
                    .${field.propertyName}(${entityCapitalName}UpdateDTO.${getprefix}${field.capitalName}())
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
            ${entityCapitalName}.set${field.capitalName}(${entityCapitalName}UpdateDTO.${getprefix}${field.capitalName}());
            </#list>
            return ${entityCapitalName};
        </#if>
        }

        @Override
        protected ${entity}UpdateDTO doBackward(${entity} ${entityCapitalName}) {
            throw new UnsupportedOperationException();
        }
    }
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
