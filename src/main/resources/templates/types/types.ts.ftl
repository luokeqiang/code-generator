import type { PageRequest, PageResponse } from '@/types/page'

/**
 * "${table.comment!}"对象
 */
export interface ${entity} {
<#list table.fields as field>
  /**
  * ${field.comment}
  */
  <#if field.propertyType=='String'>
  ${field.propertyName}: string
  <#else>
  ${field.propertyName}: number
  </#if>
</#list>
}

/**
 * "${table.comment!}" 信息分页查询对象
 */
export interface ${entity}PageRequest extends ${entity}, PageRequest {}

/**
 * "${table.comment!}" 分页响应对象
 */
export interface ${entity}PageResponse extends PageResponse<${entity}> {}
