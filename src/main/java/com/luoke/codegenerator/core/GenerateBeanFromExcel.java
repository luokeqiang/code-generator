//package com.luoke.codegenerator.core;
//
//import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import lombok.Builder;
//import lombok.Data;
//
//import java.io.File;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.LinkedHashMap;
//import java.util.List;
//import java.util.stream.Collectors;
//
///**
// * @author luoke
// * @date 2023/3/7 12:14
// */
//public class GenerateBeanFromExcel {
//
//    private static void generatePropertyFromExcel() {
//        final String[] keys = {"name", "type", "required", null, "comment"};
//        ExcelReader reader = ExcelUtil.getReader(FileUtil.file("F:\\wonders\\company\\project\\ZheJiang\\ZJ_JT\\document\\电子归档新\\api.xlsx"));
//        final List<TableInfo> results = new ArrayList<>();
//        reader.getSheets().forEach(sheet -> {
//            final List<FieldInfo> fileds = new ArrayList<>();
//            final TableInfo tableInfo = new TableInfo();
//            tableInfo.setTableName(sheet.getSheetName());
//            for (int row = 1; row < sheet.getLastRowNum(); row++) {
//                final Row rowData = sheet.getRow(row);
//                final FieldInfo info = FieldInfo.builder()
//                        .origName(String.valueOf(rowData.getCell(0).getStringCellValue()))
//                        .propertyType("JSON".equalsIgnoreCase(rowData.getCell(1).getStringCellValue()) ? "Map<String,Object>"
//                                :firstToUpper(rowData.getCell(1).getStringCellValue()))
//                        .comment(rowData.getCell(4).getStringCellValue())
//                        .required("是".equals(rowData.getCell(2).getStringCellValue()))
//                        .build();
//                String comment =rowData.getCell(4).getStringCellValue();
//                if (StringUtils.isNotBlank(rowData.getCell(3).getStringCellValue())) {
//                    comment += ":" + rowData.getCell(3).getStringCellValue();
//                }
//                info.setFullComment(comment);
//                String collect = Arrays
//                        .stream(info.getOrigName().split("_"))
//                        .filter(StringUtils::isNotBlank)
//                        .map(item -> String.valueOf(item.charAt(0)).toUpperCase() + item.substring(1))
//                        .collect(Collectors.joining(""));
//                System.out.println(info);
//                collect = String.valueOf(collect.charAt(0)).toLowerCase() + collect.substring(1);
//                info.setPropertyName(collect);
//                fileds.add(info);
//            }
//            tableInfo.setFieldInfos(fileds);
//            results.add(tableInfo);
//        });
//        results.forEach(tableInfo -> {
//            final FreemarkerTemplateEngine freemarkerTemplateEngine = new FreemarkerTemplateEngine();
//            freemarkerTemplateEngine.init(null);
//            try {
//                final ObjectMapper objectMapper = new ObjectMapper();
//                final String s = objectMapper.writeValueAsString(tableInfo);
//                freemarkerTemplateEngine.writer(objectMapper.readValue(s, LinkedHashMap.class),"/templates/Field.java.ftl", new File("D:\\luoke\\Documents\\program\\project\\template\\te\\springboot--template\\springboot-template-maven\\spring-template-web\\src\\test\\java\\com\\luoke\\sprintboot\\template\\generator\\"+tableInfo.getTableName()+".java"));
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//            System.out.println("=============="+tableInfo.tableName+"=================");
//            tableInfo.getFieldInfos().forEach(System.out::println);
//        });
//    }
//
//    public static String firstToUpper(String str) {
//        return String.valueOf(str.charAt(0)).toUpperCase() + str.substring(1);
//    }
//
//    @Data
//    private static class TableInfo {
//        private String tableName;
//        private List<FieldInfo> fieldInfos;
//    }
//    @Data
//    @Builder
//    private static class FieldInfo {
//        private String origName;
//        private String propertyName;
//        private String propertyType;
//        private boolean required;
//        private String comment;
//        private String fullComment;
//    }
//}
