package com.luoke.codegenerator.core;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.ConstVal;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.builder.CustomFile;
import com.baomidou.mybatisplus.generator.config.po.LikeTable;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.fill.Column;
import com.baomidou.mybatisplus.generator.fill.Property;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.luoke.codegenerator.core.config.CodeGeneratorConfig;
import com.luoke.codegenerator.core.config.DataBaseConfig;
import com.luoke.codegenerator.core.entity.BaseEntity;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.Collections;
import java.util.Optional;
import java.util.Properties;
import java.util.stream.Collectors;

/**
 * @author luoke
 * @date 2023-02-25 18:07
 */
public class CodeGenerator {
    public static final String MODULE_DIR;
    public static final String SOURCE_DIR;
    public static final String RESOURCES_DIR;

    private static final Properties DB_PROPERTIES = new Properties();
    private static final Properties CONFIG_PROPERTIES = new Properties();

    private static CodeGeneratorConfig codeGeneratorConfig;
    private static DataBaseConfig dataBaseConfig;

    static {
        final String[] pathSplits = Optional.ofNullable(CodeGenerator.class.getClassLoader().getResource(""))
                .map(URL::getPath)
                .map(path -> path.split("/"))
                .orElseThrow(() -> new RuntimeException("项目路径获取错误"));
        final String path = Arrays.stream(pathSplits)
                .limit(pathSplits.length - 2)
                .collect(Collectors.joining(System.getProperty("file.separator")));
        MODULE_DIR = path;
        SOURCE_DIR = path + "/src/main/java";
        RESOURCES_DIR = path + "/src/main/resources";

        loadDataBaseConfig();
    }

    public static void main(String[] args) {
        doCodeGenerate();
    }

    private static void loadDataBaseConfig() {
        try {
            DB_PROPERTIES.load(new ClassPathResource("generator/db.properties").getInputStream());
            CONFIG_PROPERTIES.load(new ClassPathResource("generator/config.properties").getInputStream());
            final ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            codeGeneratorConfig = objectMapper.convertValue(CONFIG_PROPERTIES, CodeGeneratorConfig.class);
            dataBaseConfig = objectMapper.convertValue(DB_PROPERTIES, DataBaseConfig.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void doCodeGenerate() {
        FastAutoGenerator.create(dataBaseConfig.getUrl(), dataBaseConfig.getUsername(), dataBaseConfig.getPassword())
                .globalConfig(builder -> builder
                        .author(codeGeneratorConfig.getAuthor()) // 设置作者
                        .outputDir(SOURCE_DIR) // 指定输出目录
                )
                .packageConfig(builder -> {
                    final String moduleName = codeGeneratorConfig.getModule();
                    final String mapperPath = RESOURCES_DIR + "/mapper/"+moduleName;
                    builder.parent(codeGeneratorConfig.getBasePackage()) // 设置父包名
                            .moduleName(moduleName) // 设置父包模块名
                            .pathInfo(Collections.singletonMap(OutputFile.xml, mapperPath)); // 设置mapperXml生成路径
                })
                .strategyConfig(builder -> {
                    builder.addInclude("favorite") // 设置需要生成的表名
//                    builder // 设置需要生成的表名
//                            .likeTable(new LikeTable("GAEA"))
                            .entityBuilder()
                            .enableLombok()
                            .enableFileOverride()
                            .superClass(BaseEntity.class)
                            .addSuperEntityColumns("id", "created_by", "created_time", "updated_by", "updated_time", "deleted")
                            .addTableFills(new Column("create_time", FieldFill.INSERT))
                            .addTableFills(new Property("updateTime", FieldFill.INSERT_UPDATE))
                            .controllerBuilder()
                            .enableFileOverride()
                            .enableRestStyle()
                            .serviceBuilder()
                            .enableFileOverride()
                            .convertServiceFileName((entityName -> entityName + ConstVal.SERVICE))
                            .mapperBuilder()
                            .enableFileOverride();
                })
                .injectionConfig(builder -> {
                    final CustomFile createDto = new CustomFile.Builder()
                            .enableFileOverride()
                            .packageName("dto")
                            .fileName("CreateDTO.java")
                            .templatePath("/templates/entityCreateDTO.java.ftl")
                            .build();
                    final CustomFile updateDto = new CustomFile.Builder()
                            .enableFileOverride()
                            .packageName("dto")
                            .fileName("UpdateDTO.java")
                            .templatePath("/templates/entityUpdateDTO.java.ftl")
                            .build();
                    final CustomFile filterDTO = new CustomFile.Builder()
                            .enableFileOverride()
                            .packageName("dto")
                            .fileName("FilterDTO.java")
                            .templatePath("/templates/entityFilterDTO.java.ftl")
                            .build();
                    final CustomFile detailVO = new CustomFile.Builder()
                            .enableFileOverride()
                            .packageName("vo")
                            .fileName("DetailVO.java")
                            .templatePath("/templates/entityDetailVO.java.ftl")
                            .build();
                    final CustomFile listVO = new CustomFile.Builder()
                            .enableFileOverride()
                            .packageName("vo")
                            .fileName("ListVO.java")
                            .templatePath("/templates/entityListVO.java.ftl")
                            .build();
                    builder.customFile(Arrays.asList(createDto, updateDto, detailVO, listVO, filterDTO));
                })
                .templateEngine(new FreemarkerTemplateEngine()) // 使用Freemarker引擎模板，默认的是Velocity引擎模板
                .execute();
    }

    private static String getDbConfig(String key) {
        return DB_PROPERTIES.getProperty(key);
    }

    private static String getInConfig(String key) {
        return CONFIG_PROPERTIES.getProperty(key);
    }

}
