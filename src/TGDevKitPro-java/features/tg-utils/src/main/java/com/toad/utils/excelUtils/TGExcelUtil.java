//package com.toad.utils.excelUtils;
//
//import org.apache.commons.io.FilenameUtils;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.*;
//import org.apache.poi.ss.util.CellAddress;
//import org.apache.poi.ss.util.CellRangeAddress;
//import org.apache.poi.xssf.usermodel.*;
//
//import javax.imageio.ImageIO;
//import java.awt.image.BufferedImage;
//import java.io.*;
//import java.util.List;
//
//public class TGExcelUtil {
//
//    public XSSFWorkbook workbook = new XSSFWorkbook();
//
//    public void setupDefaultSetting(){
//        // 隐藏网格线
//        // workbook.setGisetGridLinesVisible(false);
//    }
//    public void readStyle(Sheet sheet,int var1,int var2){
//        CellAddress cellAddress = new CellAddress(1, 1);
////        sheet.getCellComment()
////        sheet.getHyperlink()
////        sheet.getMergedRegion();
//        Row row = sheet.getRow(var1);
//        Cell cell = row.getCell(var2);
//
//        CellStyle cellStyle = cell.getCellStyle();
//        cellStyle.getFillForegroundColorColor();
//        BorderStyle borderStyle =  cellStyle.getBorderBottom();
////        cellStyle.getFillForegroundColorColor().
////        getHexString
//        short s =  cellStyle.getFillBackgroundColor();
//
//        System.out.println(borderStyle);
//    }
//    public void readEx(String filePath ,String sheetName) throws Exception{
//
//        File file = new File(filePath);
//        if (!file.exists()){
//            throw new Exception("文件不存在!");
//        }
//
////        TGUitlCommand.coutLine("读取exel文件：" + filePath);
//
//        String fileExtension = FilenameUtils.getExtension(filePath);
//        InputStream in = new FileInputStream(file);
//        Workbook workbook = null;
//        // 读取整个Excel
//        if ("xlsx".equals(fileExtension)){
//            workbook = new XSSFWorkbook(in);
//        }
//        else if ("xlsx".equals(fileExtension)){
//            workbook = new HSSFWorkbook(in);
//        }
//
//        Sheet sheet = workbook.getSheet(sheetName);
//        readStyle(sheet, 1, 1);
//        readStyle(sheet, 5, 1);
//    }
//
//    public int stringtoCellNumber(String a){
//        return Stringtoint(a) - 1;
//    }
//
//    public int Stringtoint(String letter){
//        // 检查字符串是否为空
//        if (letter == null || letter.isEmpty()) {
//            return -1;
//        }
//        String upperLetter = letter.toUpperCase(); // 转为大写字符串
//        if (!upperLetter.matches("[A-Z]+")) { // 检查是否符合，不能包含非字母字符
//            return -1;
//        }
//        long num = 0; // 存放结果数值
//        long base = 1;
//        // 从字符串尾部开始向头部转换
//        for (int i = upperLetter.length() - 1; i >= 0; i--) {
//            char ch = upperLetter.charAt(i);
//            num += (ch - 'A' + 1) * base;
//            base *= 26;
//            if (num > Integer.MAX_VALUE) { // 防止内存溢出
//                return -1;
//            }
//        }
//        return (int) num;
//    }
//
//    public TGUtilSheet createSheet(String sheetName){
//        TGUtilSheet tgUtilSheet = new TGUtilSheet(workbook, sheetName);
//        return tgUtilSheet;
//    }
//
//    public void output(String outPath) throws Exception {
//        File outFile = new File(outPath);
//        if (outFile.exists()) {
//            throw new Exception("文件已存在：" + outPath);
//        }
//        FileOutputStream out = new FileOutputStream(outFile);
//        workbook.write(out);
//        out.close();
//    }
//
//    public void asd() throws IOException {
////        XSSFSheet sheet = createSheet("测试用");
////        // 利用HSSFPatriarch将图片写入EXCEL
////        XSSFDrawing patriarch = sheet.createDrawingPatriarch();
////        // 图片一导出到单元格I3-5中 列开始：8 行开始：2 列结束：9 行结束：5
////        XSSFClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, 8, 2, 9, 5);
////        anchor.setAnchorType(ClientAnchor.AnchorType.MOVE_AND_RESIZE);
////        ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
////        BufferedImage bufferImg = ImageIO.read(new File("D:\\ji.png"));
////        // 将图片写入流中
////        ImageIO.write(bufferImg, "png", byteArrayOut);
////        // 插入图片内容
////        Picture picture =  patriarch.createPicture(anchor, workbook.addPicture(byteArrayOut
////                .toByteArray(), XSSFWorkbook.PICTURE_TYPE_JPEG));
////
////        picture.resize(1.05,1.10);
//
//    }
//
//    public XSSFCell appendingCell(XSSFSheet sheet,String value,CellStyle style,int rownum, int columnIndex){
//        CellAddress cellAddress = new CellAddress(rownum,columnIndex);
//        XSSFRow row = sheet.getRow(rownum);
//        XSSFCell cell = null;
//        if (null != row) {
//
//        }
//        else {
//            row = sheet.createRow(rownum);
//        }
//        cell = row.getCell(columnIndex);
//        if (null == cell) {
//            //创建行，指定起始行号，从0开始
//            //创建单元格，指定起始列号，从0开始
//            cell = row.createCell(columnIndex);
//        }
//        cell.setCellValue(value);
//        //为指定单元格设定样式
//        cell.setCellStyle(style);
//        return cell;
//    }
//
//    public XSSFCell appendingCell(XSSFSheet sheet,String value,CellStyle style,int firstRow, int lastRow, int firstCol, int lastCol){
//        CellRangeAddress rangeAddress = new CellRangeAddress(firstRow,lastRow, firstCol, lastCol);
//        return appendingCell(sheet,value,style,rangeAddress);
//    }
//
//    public int importPicture(String imagePath) throws IOException {
//        File imageFile = new File(imagePath);
//        BufferedImage bufferImg = ImageIO.read(imageFile);
//        ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
//        String extension = FilenameUtils.getExtension(imagePath);
//        ImageIO.write(bufferImg, extension, byteArrayOut);
//        return workbook.addPicture(byteArrayOut.toByteArray(), XSSFWorkbook.PICTURE_TYPE_JPEG);
//    }
//
//    public XSSFCell appendingCell(XSSFSheet sheet,String value,CellStyle style,CellRangeAddress rangeAddress){
//        //添加要合并地址到表格
//        sheet.addMergedRegionUnsafe(rangeAddress);
//        int rownum = rangeAddress.getFirstRow();
//        int columnIndex = rangeAddress.getFirstColumn();
//        return appendingCell(sheet, value, style, rownum, columnIndex);
//    }
//
//    public void indImage(XSSFSheet sheet){
////        String imageType = imageUrl.substring(imageUrl.length()-3);
////        File imageFile = new File("./temp." + imageType);
////        FileUtils.copyURLToFile(new URL(imageUrl), imageFile);
////        bufferImg = ImageIO.read(imageFile);
////        ImageIO.write(bufferImg, imageType, byteArrayOut);
////        sheet.createDrawingPatriarch();
////        //画图的顶级管理器，一个sheet只能获取一个（一定要注意这点）
////        XSSFDrawing patriarch = sheet.createDrawingPatriarch();
////        //anchor主要用于设置图片的属性
////        XSSFClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 2, 2, (short) 4, 4);
////        anchor.setAnchorType(ClientAnchor.AnchorType.MOVE_AND_RESIZE);
////        //插入图片
////        patriarch.createPicture(anchor, workbook.addPicture(byteArrayOut.toByteArray(), XSSFWorkbook.PICTURE_TYPE_JPEG));
////
////        FileOutputStream fileOutputStream = new FileOutputStream(fileName);
////        workbook.write(fileOutputStream);
//    }
//
//    public void adf() {
//        XSSFSheet sheet = workbook.createSheet("工作表1");
//        //指定合并开始行、合并结束行 合并开始列、合并结束列
//        CellRangeAddress rangeAddress = new CellRangeAddress(0, 0, 0, 1);
//        //添加要合并地址到表格
//        sheet.addMergedRegion(rangeAddress);
//        //创建行，指定起始行号，从0开始
//        XSSFRow row = sheet.createRow(0);
//        //创建单元格，指定起始列号，从0开始
//        XSSFCell cell = row.createCell(0);
//        //设置单元格内容
//        cell.setCellValue("我是合并后的单元格");
//        //创建样式对象
//        CellStyle style = workbook.createCellStyle();
//        //设置样式对齐方式：水平垂直居中
//        style.setAlignment(HorizontalAlignment.CENTER);
//        style.setVerticalAlignment(VerticalAlignment.CENTER);
//    }
//}
