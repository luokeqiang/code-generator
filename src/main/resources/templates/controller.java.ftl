package ${package.Controller};

import com.baomidou.mybatisplus.core.metadata.IPage;
import org.luoke.springboot.template.springboottemplateweb.common.response.ResponseVO;
import ${package.Parent}.dto.${entity}CreateDTO;
import ${package.Parent}.dto.${entity}UpdateDTO;
import ${package.Parent}.dto.${entity}FilterDTO;
import ${package.Parent}.vo.${entity}DetailVO;
import ${package.Parent}.vo.${entity}ListVO;
import ${package.Service}.${table.serviceName};
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
<#if restControllerStyle>
<#else>
    import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
    import ${superControllerClassPackage};
</#if>

/**
* <p>
* ${table.comment!} 前端控制器
* </p>
*
* @author ${author}
* @since ${date}
*/
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>
<#assign serviceName="${table.serviceName?substring(0,1)?lower_case}${table.serviceName?substring(1)}"/>
<#assign entityName="${entity?substring(0,1)?lower_case}${entity?substring(1)}"/>
    private ${table.serviceName} ${serviceName};

    public ${entity}Controller(${table.serviceName} ${serviceName}) {
        this.${serviceName} = ${serviceName};
    }

    /**
    * 新增${table.comment!}
    * @param ${entityName}CreateDTO ${table.comment!}信息
    * @author ${author} ${date}
    */
    @PostMapping("/create")
    public ResponseVO<?> create(@RequestBody @Validated ${entity}CreateDTO ${entityName}CreateDTO) {
        ${serviceName}.create(${entityName}CreateDTO);
        return ResponseVO.ok("新增成功");
    }

    /**
    * 修改${table.comment!}
    * @param ${entityName}UpdateDTO ${table.comment!}信息
    * @author ${author} ${date}
    */
    @PostMapping("/update")
    public ResponseVO<?> update(@RequestBody @Validated ${entity}UpdateDTO ${entityName}UpdateDTO) {
        ${serviceName}.update(${entityName}UpdateDTO);
        return ResponseVO.ok("修改成功");
    }

    /**
    * 查找${table.comment!}详细信息
    * @param id 主键标识
    * @author ${author} ${date}
    */
    @GetMapping("/find/{id}")
    public ResponseVO<${entity}DetailVO> find(@PathVariable String id) {
        return ResponseVO.ok(${serviceName}.detail(id));
    }

    /**
    * 删除${table.comment!}
    * @param id 主键标识
    * @author ${author} ${date}
    */
    @GetMapping("/delete/{id}")
    public ResponseVO<?> delete(@PathVariable String id) {
        final int deleteCount = ${serviceName}.delete(id);
        return ResponseVO.ok("删除成功");
    }

    /**
    * 分页查询${table.comment!}信息
    * @param ${entityName}FilterDTO 筛选条件
    * @author ${author} ${date}
    */
    @GetMapping("/list")
    public ResponseVO<IPage<${entity}ListVO>> list(${entity}FilterDTO ${entityName}FilterDTO) {
        return ResponseVO.ok(${serviceName}.listByPage(${entityName}FilterDTO));
    }
}
        </#if>
