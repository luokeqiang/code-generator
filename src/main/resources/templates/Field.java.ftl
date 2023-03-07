import com.fasterxml.jackson.annotation.JsonProperty;
import javax.validation.constraints.NotNull;

public class ${tableName} {
<#list fieldInfos as field>
    <#if field.comment!?length gt 0>
    /**
    * ${field.fullComment}
    */
    </#if>
<#-- 普通字段 -->
    @JsonProperty("${field.origName}")
    <#if field.required>
    @NotBlank(message = "${field.comment}不能为空")
    </#if>
    private ${field.propertyType} ${field.propertyName};

</#list>

}