<#assign entityCapitalName="${entity?substring(0,1)?lower_case}${entity?substring(1)}"/>
import axios from '@/request'
import type { ${entity}, ${entity}PageRequest, ${entity}PageResponse } from '@/types/${entityCapitalName}'


/**
 * ""分页查询
 * @param requestParam 分页筛选对象
 * @returns Promise
 */
export function ${entityCapitalName}PageList(requestParam: ${entity}PageRequest) {
  return axios.get<${entity}PageResponse>('<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/list', {
    params: requestParam
  })
}

/**
 * 根据ID查询""
 * @param id 主键ID
 * @returns Promise
 */
export function ${entityCapitalName}Detail(id: string) {
  return axios.get<${entity}>(`<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/find/<#noparse>${id}</#noparse>`, {
    loadingConfig: {
      enable: true,
      text: '查询中...'
    }
  })
}

/**
 * 创建""
 * @param ${entityCapitalName}CreateRequest “”创建对象
 * @returns Promise
 */
export function ${entityCapitalName}Create(${entityCapitalName}CreateRequest: ${entity}) {
  return axios.post('<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/create', ${entityCapitalName}CreateRequest, {
    loadingConfig: {
      enable: true,
      text: '创建中...'
    }
  })
}

/**
 * 更新""
 * @param ${entityCapitalName}UpdateRequest “”更新对象
 * @returns Promise
 */
export function ${entityCapitalName}Update(${entityCapitalName}UpdateRequest: ${entity}) {
  return axios.post('<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/update', ${entityCapitalName}UpdateRequest, {
    loadingConfig: {
      enable: true,
      text: '更新中...'
    }
  })
}

/**
 * 根据主键Id删除""
 * @param id 主键ID
 * @returns Promise
 */
export function ${entityCapitalName}Delete(id: string) {
  return axios.post(`<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/delete/<#noparse>${id}</#noparse>`, null, {
    loadingConfig: {
      enable: true,
      text: '删除中...'
    }
  })
}