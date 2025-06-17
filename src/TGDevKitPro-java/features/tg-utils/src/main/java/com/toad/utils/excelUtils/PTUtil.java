//package com.toad.java.utils.excelUtils;
//
//import org.apache.commons.io.FilenameUtils;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.hssf.util.HSSFColor;
//import org.apache.poi.ss.usermodel.*;
//
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileOutputStream;
//import java.io.InputStream;
//import java.text.SimpleDateFormat;
//import java.util.*;
//
//public class PTUtil extends TGExcelUtil {
//
//    public void setDefualeStyle(){
//
//        workbook.setPrintArea(0, 0, 10, 10, 10);
//    }
//
//    public Font getFont(){
//        Font font = workbook.createFont();
//
////        font.setFontName("宋体");
//        font.setFontHeightInPoints((short) 10);
//        return font;
//    }
//
//    public CellStyle createDefalueStyle(){
//        CellStyle style = workbook.createCellStyle();
//        style.setFont(getFont());
//        style.setVerticalAlignment(VerticalAlignment.CENTER);
//        return style;
//    }
//
//    public BorderStyle defauleBorderStyl(){
//        return BorderStyle.MEDIUM;
//    }
//
//    public CellStyle createLeftStyle(){
//        CellStyle style = createDefalueStyle();
//        style.setBorderLeft(defauleBorderStyl());
//        return style;
//    }
//
//    public CellStyle createRigtStyle(){
//        CellStyle style = createDefalueStyle();
//        style.setBorderRight(defauleBorderStyl());
//        return style;
//    }
//
//    public CellStyle getHeadStyle(){
//        CellStyle style = createDefalueStyle();
//        //设置单元格颜色
//        style.setFillForegroundColor((short) 64);
//        //设置填充样式（实心填充），不设置填充样式不会有颜色
//        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//        style.setBorderBottom(defauleBorderStyl());
//        style.setBorderTop(defauleBorderStyl());
//        style.setBorderLeft(defauleBorderStyl());
//        style.setBorderRight(defauleBorderStyl());
//        return style;
//    }
//
//    public CellStyle getValueStyle(){
//        CellStyle style = createDefalueStyle();
//        HSSFColor.HSSFColorPredefined.LEMON_CHIFFON.getHexString();
//
//        //设置单元格颜色
//        style.setFillForegroundColor(HSSFColor.HSSFColorPredefined.LEMON_CHIFFON.getIndex());
//        style.setFont(getFont());
//        //设置填充样式（实心填充），不设置填充样式不会有颜色
////        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//        return style;
//    }
//    public void createColorTest(){
//        TGUtilSheet sheet =  createSheet( "颜色测试");
//        for (short i = 0; i < 99;i++){
//            CellStyle style = createDefalueStyle();
//            style.setFillForegroundColor(i);
//            //设置填充样式（实心填充），不设置填充样式不会有颜色
//            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//            int rownum =  i / 5;
//            int columnindex = i % 5;
//            sheet.appendingCell("颜色ID：" + i,style,rownum,columnindex);
//        }
//
//    }
//
//
//    public void createHistorySheet(String systemName, String subsystemName , String moduleName, String functionName, String author, String createTime, String updater, String updateTime, String imagesDirPath, List<PTSytle.revisionHistory> revisionHistoryList) throws Exception{
//        TGUtilSheet sheet =  createSheet( "变更履历");
//        CellStyle titleStyle = getHeadStyle();
//        CellStyle valueStyle = getValueStyle();
//
//        sheet.appendingCell("画面流程图",titleStyle,1,2,stringtoCellNumber("B"),stringtoCellNumber("E"));
//        sheet.appendingCell("系统名",titleStyle,1,1,stringtoCellNumber("F"),stringtoCellNumber("I"));
//        sheet.appendingCell(systemName,titleStyle,1,1,stringtoCellNumber("J"),stringtoCellNumber("Q"));
//        sheet.appendingCell("子系统名",titleStyle,2,2,stringtoCellNumber("F"),stringtoCellNumber("I"));
//        sheet.appendingCell("",valueStyle,2,2,stringtoCellNumber("J"),stringtoCellNumber("Q"));
//        sheet.appendingCell("模块名",titleStyle,1,1,stringtoCellNumber("R"),stringtoCellNumber("U"));
//        sheet.appendingCell("",valueStyle,1,1,stringtoCellNumber("V"),stringtoCellNumber("AC"));
//        sheet.appendingCell("功能名",titleStyle,2,2,stringtoCellNumber("R"),stringtoCellNumber("U"));
//        sheet.appendingCell("",valueStyle,2,2,stringtoCellNumber("V"),stringtoCellNumber("AC"));
//        sheet.appendingCell("作成者",titleStyle,1,1,stringtoCellNumber("AD"),stringtoCellNumber("AG"));
//        sheet.appendingCell("作成者",valueStyle,1,1,stringtoCellNumber("AH"),stringtoCellNumber("AL"));
//        sheet.appendingCell("更新者",titleStyle,2,2,stringtoCellNumber("AD"),stringtoCellNumber("AG"));
//        sheet.appendingCell("更新者",valueStyle,2,2,stringtoCellNumber("AH"),stringtoCellNumber("AL"));
//        sheet.appendingCell("作成日",titleStyle,1,1,stringtoCellNumber("AM"),stringtoCellNumber("AP"));
//        sheet.appendingCell("作成日",valueStyle,1,1,stringtoCellNumber("AQ"),stringtoCellNumber("AU"));
//        sheet.appendingCell("最终更新日",titleStyle,2,2,stringtoCellNumber("AM"),stringtoCellNumber("AP"));
//        sheet.appendingCell("最终更新日",valueStyle,2,2,stringtoCellNumber("AQ"),stringtoCellNumber("AU"));
//
//        int row = 4;
//        sheet.appendingCell("NO.",titleStyle,row ,row,stringtoCellNumber("B"),stringtoCellNumber("C"));
//        sheet.appendingCell("区分",titleStyle,row ,row,stringtoCellNumber("D"),stringtoCellNumber("F"));
//        sheet.appendingCell("变更场所",titleStyle,row ,row,stringtoCellNumber("G"),stringtoCellNumber("K"));
//        sheet.appendingCell("变更内容.",titleStyle,row ,row,stringtoCellNumber("L"),stringtoCellNumber("AF"));
//        sheet.appendingCell("变更原因",titleStyle,row ,row,stringtoCellNumber("AG"),stringtoCellNumber("AL"));
//        sheet.appendingCell("变更日",titleStyle,row ,row,stringtoCellNumber("AM"),stringtoCellNumber("AO"));
//        sheet.appendingCell("变更着",titleStyle,row ,row,stringtoCellNumber("AP"),stringtoCellNumber("AR"));
//        sheet.appendingCell("承认者",titleStyle,row ,row,stringtoCellNumber("AS"),stringtoCellNumber("AU"));
//
//        for (int i = 1 ; i < 12 ; i++){
//            sheet.appendingCell("",valueStyle,row +i,row +i,stringtoCellNumber("B"),stringtoCellNumber("C"));
//            sheet.appendingCell("",valueStyle,row + i ,row + i,stringtoCellNumber("D"),stringtoCellNumber("F"));
//            sheet.appendingCell("",valueStyle,row + i ,row + i,stringtoCellNumber("G"),stringtoCellNumber("K"));
//            sheet.appendingCell("",valueStyle,row + i ,row + i,stringtoCellNumber("L"),stringtoCellNumber("AF"));
//            sheet.appendingCell("",valueStyle,row + i ,row + i,stringtoCellNumber("AG"),stringtoCellNumber("AL"));
//            sheet.appendingCell("",valueStyle,row + i ,row + i,stringtoCellNumber("AM"),stringtoCellNumber("AO"));
//            sheet.appendingCell("",valueStyle,row + i ,row + i,stringtoCellNumber("AP"),stringtoCellNumber("AR"));
//            sheet.appendingCell("",valueStyle,row + i ,row + i,stringtoCellNumber("AS"),stringtoCellNumber("AU"));
//        }
//
//    }
//
//    public void createCTSheet(String systemName, String subsystemName , String moduleName, String functionName, String author, String createTime, String updater, String updateTime, String imagesDirPath, List<PTSytle.revisionHistory> revisionHistoryList) throws Exception {
//        TGUtilSheet sheet =  createSheet( "CT检证结果");
//
//        CellStyle style = getHeadStyle();
//        CellStyle valueStyle = getValueStyle();
//        //设置单元格颜色
////        CellRangeAddress randeAddress = new CellRangeAddress(1,2,stringtoCellNumber("B"),stringtoCellNumber("E"));
//        //创建标题
//        sheet.appendingCell("画面流程图",style,1,2,stringtoCellNumber("B"),stringtoCellNumber("E"));
//        sheet.appendingCell("系统名",style,1,1,stringtoCellNumber("F"),stringtoCellNumber("I"));
//        sheet.appendingCell(systemName,valueStyle,1,1,stringtoCellNumber("J"),stringtoCellNumber("Q"));
//        sheet.appendingCell("子系统名",style,2,2,stringtoCellNumber("F"),stringtoCellNumber("I"));
//        sheet.appendingCell("",valueStyle,2,2,stringtoCellNumber("J"),stringtoCellNumber("Q"));
//        sheet.appendingCell("模块名",style,1,1,stringtoCellNumber("R"),stringtoCellNumber("U"));
//        sheet.appendingCell("",valueStyle,1,1,stringtoCellNumber("V"),stringtoCellNumber("AC"));
//        sheet.appendingCell("功能名",style,2,2,stringtoCellNumber("R"),stringtoCellNumber("U"));
//        sheet.appendingCell("",valueStyle,2,2,stringtoCellNumber("V"),stringtoCellNumber("AC"));
//        sheet.appendingCell("作成者",style,1,1,stringtoCellNumber("AD"),stringtoCellNumber("AG"));
//        sheet.appendingCell("作成者",valueStyle,1,1,stringtoCellNumber("AH"),stringtoCellNumber("AL"));
//        sheet.appendingCell("更新者",style,2,2,stringtoCellNumber("AD"),stringtoCellNumber("AG"));
//        sheet.appendingCell("更新者",valueStyle,2,2,stringtoCellNumber("AH"),stringtoCellNumber("AL"));
//        sheet.appendingCell("作成日",style,1,1,stringtoCellNumber("AM"),stringtoCellNumber("AP"));
//        sheet.appendingCell("作成日",valueStyle,1,1,stringtoCellNumber("AQ"),stringtoCellNumber("AU"));
//        sheet.appendingCell("最终更新日",style,2,2,stringtoCellNumber("AM"),stringtoCellNumber("AP"));
//        sheet.appendingCell("最终更新日",valueStyle,2,2,stringtoCellNumber("AQ"),stringtoCellNumber("AU"));
//        imagesDirPath = "/Users/toad/Desktop/images";
//        Map<String,List<String>> caseImagesMap = getCTImageList(imagesDirPath);
//
//        Set<String> keySet = caseImagesMap.keySet();
//        CellStyle rightStyle = createRigtStyle();
//        CellStyle leftStyle = createLeftStyle();
//
//        int row = 4;
//        for (String key : keySet) {
//            sheet.appendingCell("NO.",style,row ,row,stringtoCellNumber("B"),stringtoCellNumber("E"));
//            sheet.appendingCell("项目.",style,row ,row,stringtoCellNumber("F"),stringtoCellNumber("I"));
//            sheet.appendingCell("正常.",style,row ,row,stringtoCellNumber("J"),stringtoCellNumber("K"));
//            sheet.appendingCell("异常.",style,row ,row,stringtoCellNumber("L"),stringtoCellNumber("M"));
//            sheet.appendingCell("异常.",style,row ,row,stringtoCellNumber("N"),stringtoCellNumber("Q"));
//            sheet.appendingCell("",style,row ,row,stringtoCellNumber("R"),stringtoCellNumber("AU"));
//            row++;
//
//            sheet.appendingCell(key,valueStyle,row ,row,stringtoCellNumber("B"),stringtoCellNumber("E"));
//            sheet.appendingCell("项目.",valueStyle,row ,row,stringtoCellNumber("F"),stringtoCellNumber("I"));
//            sheet.appendingCell("正常.",valueStyle,row ,row,stringtoCellNumber("J"),stringtoCellNumber("K"));
//            sheet.appendingCell("异常.",valueStyle,row ,row,stringtoCellNumber("L"),stringtoCellNumber("M"));
//            sheet.appendingCell("测试日期.",style,row ,row,stringtoCellNumber("N"),stringtoCellNumber("Q"));
//            sheet.appendingCell("",valueStyle,row ,row,stringtoCellNumber("R"),stringtoCellNumber("AU"));
//            row++;
//
//            int imageRowNumber = 26;
//            for (int i = row; i < row+imageRowNumber;i++){
//                sheet.appendingCell("",leftStyle,i ,stringtoCellNumber("B"));
//                sheet.appendingCell("",rightStyle,i ,stringtoCellNumber("AU"));
//            }
//
//            int caseRowNumber = 4 + row * 5;
//            List<String> caseImages = caseImagesMap.get(key);
//
//            System.out.println(key);
//            if (caseImages.size() > 0){
//                int pictureIndex = importPicture(caseImages.get(0));
//                sheet.appendingImage(pictureIndex,0, 0, 0, 0, 8, row , 9, row + imageRowNumber);
//            }
//            row += imageRowNumber;
//        }
//    }
//
//    public void createReport(String systemName, String subsystemName , String moduleName, String functionName, String author, String createTime, String updater, String updateTime, String imagesDirPath, List<PTSytle.revisionHistory> revisionHistoryList) throws Exception {
//
//        // 修改履历页
//        createHistorySheet(systemName, subsystemName, moduleName, functionName, author, createTime, updater, updateTime, imagesDirPath, revisionHistoryList);
//        // CT 页
//        createCTSheet(systemName, subsystemName, moduleName, functionName, author, createTime, updater, updateTime, imagesDirPath, revisionHistoryList);
//        createColorTest();
//        // 设置默认样式
//        setDefualeStyle();
//
//        Date date = new Date();
//        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//        String currentSimpleDateFormat = simpleDateFormat.format(date);
//        String outPath = "/Users/toad/Desktop/out" + File.separator + currentSimpleDateFormat + "." + "xlsx";
//        output(outPath);
//    }
//
//    public void exportReport(){
//
//    }
//
//    public Map<String,List<String>>  getCTImageList(String imageDirPath) throws Exception{
//        File imageDir = new File(imageDirPath);
//        if (!imageDir.exists() && !imageDir.isDirectory()){
//            throw new Exception("路径不存在或者不是文件夹");
//        }
//        TreeMap<String,List<String>> fileMap = new TreeMap<String,List<String>>();
//        File[] files =  imageDir.listFiles((pathname)->pathname.getName().endsWith("png"));
//        String splitStr = "-";
//        for (File file: files) {
//            String fileName = FilenameUtils.getBaseName(file.getAbsolutePath());
//            String caseName = fileName;
//            if (fileName.indexOf(splitStr) > 0){
//                String subName =  fileName.substring(0, fileName.indexOf(splitStr));
//                if (subName.length() > 0){
//                    caseName = subName;
//                }
//            }
//            List<String> caseImages =  fileMap.get(caseName);
//            if (null == caseImages){
//                caseImages = new ArrayList<String>();
//                fileMap.put(caseName, caseImages);
//            }
//            caseImages.add(file.getAbsolutePath());
//        }
//
//        return fileMap;
//    }
//
//    //    public int importPicture(String imagePath) throws IOException {
////        File imageFile = new File(imagePath);
////        BufferedImage bufferImg = ImageIO.read(imageFile);
////        ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
////        String extension = FilenameUtils.getExtension(imagePath);
////        ImageIO.write(bufferImg, extension, byteArrayOut);
////        return workbook.addPicture(byteArrayOut.toByteArray(), XSSFWorkbook.PICTURE_TYPE_JPEG);
////    }
//    public void createReport(PTSytle sytle,String templatePath)  throws Exception{
//        File file = new File(templatePath);
//        if (!file.exists()){
//            throw new Exception("文件不存在!");
//        }
//
//        //  TGUitlCommand.coutLine("读取exel文件：" + filePath);
//
//        String fileExtension = FilenameUtils.getExtension(templatePath);
//        InputStream in = new FileInputStream(file);
//        Workbook workbook = null;
//
//        // 读取整个Excel
//        if ("xlsx".equals(fileExtension)){
//            workbook = new XSSFWorkbook(in);
//        }
//        else if ("xlsx".equals(fileExtension)){
//            workbook = new HSSFWorkbook(in);
//        }
//
//        Sheet histeySheet = workbook.getSheet("变更履历");
//        String printAre =  workbook.getPrintArea(0);
//        Row row = histeySheet.getRow(1);
//        Cell cell =  row.getCell(stringtoCellNumber("J"));
//        cell.setCellValue("asdasdsds");
//
//        Date date = new Date();
//        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//        String currentSimpleDateFormat = simpleDateFormat.format(date);
//        String outPath = "/Users/toad/Desktop/out" + File.separator + currentSimpleDateFormat + "." + "xlsx";
//
//        File outFile = new File(outPath);
//        if (outFile.exists()) {
//            throw new Exception("文件已存在：" + outPath);
//        }
//        FileOutputStream out = new FileOutputStream(outFile);
//        workbook.write(out);
//        out.close();
//    }
//
//    public void createReport(PTSytle sytle)  throws Exception {
//        createReport(sytle.systemName
//                , sytle.subsystemName
//                , sytle.moduleName
//                , sytle.functionName
//                , sytle.author
//                , sytle.createTime
//                , sytle.updater
//                , sytle.updateTime
//                , sytle.imagesDirPath
//                ,sytle.revisionHistoryList);
//    }
//}
