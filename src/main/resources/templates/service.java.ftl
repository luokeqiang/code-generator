package ${package.Service};

import ${package.Entity}.${entity};
import ${package.Parent}.dto.${entity}CreateDTO;
import ${package.Parent}.dto.${entity}UpdateDTO;
import ${package.Parent}.dto.${entity}FilterDTO;
import ${package.Parent}.vo.${entity}DetailVO;
import ${package.Parent}.vo.${entity}ListVO;
import ${superServiceClassPackage};
import com.baomidou.mybatisplus.core.metadata.IPage;
/**
* <p>
* ${table.comment!} 服务类
* </p>
*
* @author ${author}
* @since ${date}
*/
<#if kotlin>
interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {
<#assign entityName="${entity?substring(0,1)?lower_case}${entity?substring(1)}"/>
    /**
    * 新增${table.comment!}
    *
    * @param ${entityName}CreateDTO ${table.comment!}信息
    * @return 新增成功后的 {@link ${entity}} 对象
    * @author ${author} ${date}
    */
    ${entity} create(${entity}CreateDTO ${entityName}CreateDTO);

    /**
    * 修改${table.comment!}
    *
    * @param ${entityName}UpdateDTO ${table.comment!}信息
    * @return 修改成功的数据条数
    * @author ${author} ${date}
    */
    int update(${entity}UpdateDTO ${entityName}UpdateDTO);

    /**
    * 通过主键标识查询${table.comment!}
    *
    * @param id 主键标识
    * @return {@link ${entity}} 查询成功的${table.comment!}信息
    * @author ${author} ${date}
    */
    ${entity} find(String id);

    /**
    * 通过主键标识查询${table.comment!}
    *
    * @param id 主键标识
    * @return {@link ${entity}DetailVO} 查询成功的${table.comment!}信息
    * @author ${author} ${date}
    */
    ${entity}DetailVO detail(String id);

    /**
    * 通过主键标识删除${table.comment!}
    *
    * @param id 主键标识
    * @return {@link Boolean} true: 删除成功，false： 删除失败
    * @author ${author} ${date}
    */
    int delete(String id);

    /**
    * 分页查询${table.comment!}
    * @param ${entityName}FilterDTOPage 筛选条件
    * @return {@link ${entity}ListVO} 列表
    * @author ${author} ${date}
    */
    IPage<${entity}ListVO> listByPage(${entity}FilterDTO ${entityName}FilterDTOPage);
}
    </#if>
