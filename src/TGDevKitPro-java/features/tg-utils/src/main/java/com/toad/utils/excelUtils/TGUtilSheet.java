//package com.toad.java.utils.excelUtils;
//
//import org.apache.commons.io.FilenameUtils;
//import org.apache.poi.ss.usermodel.CellStyle;
//import org.apache.poi.ss.usermodel.ClientAnchor;
//import org.apache.poi.ss.util.CellAddress;
//import org.apache.poi.ss.util.CellRangeAddress;
//import org.apache.poi.xssf.usermodel.*;
//import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTMergeCell;
//import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTMergeCells;
//
//import javax.imageio.ImageIO;
//import java.awt.image.BufferedImage;
//import java.io.ByteArrayOutputStream;
//import java.io.File;
//import java.io.IOException;
//
//public class TGUtilSheet  {
//
//    XSSFSheet sheet = null;
//    TGUtilSheet(XSSFWorkbook workwook ,String sheetName){
//        sheet = workwook.createSheet(sheetName);
//        sheet.setDefaultRowHeight((short) (15*20));
//        sheet.setDefaultColumnWidth((int)2);
//        sheet.setDisplayGridlines(false);
//    }
//    XSSFDrawing sheetDrawing;
//    public XSSFDrawing getSheetDrawing() {
//        if (null == sheetDrawing){
//            sheetDrawing = sheet.createDrawingPatriarch();
//        }
//        return sheetDrawing;
//    }
//
//    public XSSFCell appendingCell(String value,CellStyle style,int rownum, int columnIndex){
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
//    public XSSFCell appendingCell(String value,CellStyle style,int firstRow, int lastRow, int firstCol, int lastCol){
//        CellRangeAddress rangeAddress = new CellRangeAddress(firstRow,lastRow, firstCol, lastCol);
//        return appendingCell(sheet,value,style,rangeAddress);
//    }
//
//    public XSSFCell appendingCell(XSSFSheet sheet,String value,CellStyle style,CellRangeAddress rangeAddress){
////        for (int row = rangeAddress.getFirstRow();row < rangeAddress.getLastRow();row++) {
////            for (int column = rangeAddress.getFirstColumn();column < rangeAddress.getLastColumn();column++){
////                appendingCell(value, style, row, column);
////            }
////        }
//        // 添加要合并地址到表格
//        sheet.addMergedRegionUnsafe(rangeAddress);
////        sheet.getCellRange(rangeAddress);
////        for (int rownum = rangeAddress.getFirstRow();rownum < rangeAddress.getLastRow();rownum ++){
////            for (int columnIndex = rangeAddress.getFirstColumn();columnIndex < rangeAddress.getLastColumn();columnIndex ++) {
////                appendingCell(value, style,rownum, columnIndex);
////            }
////        }
//
//        int rownum = rangeAddress.getFirstRow();
//        int columnIndex = rangeAddress.getFirstColumn();
//        return appendingCell(value, style,rownum, columnIndex);
//    }
//
//    public void apImage(XSSFWorkbook workbook,String path) throws IOException {
//        // 先把读进来的图片放到一个ByteArrayOutputStream中，以便产生ByteArray
//        ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
//        BufferedImage bufferImg = ImageIO.read(new File(path));
//        // 将图片写入流中
//        ImageIO.write(bufferImg, FilenameUtils.getExtension(path), byteArrayOut);
//        int pictureIndex =  workbook.addPicture(byteArrayOut
//                .toByteArray(), XSSFWorkbook.PICTURE_TYPE_JPEG);
//        appendingImage(pictureIndex,0, 0, 0, 0, 8, 2, 9, 5);
//        // 利用HSSFPatriarch将图片写入EXCEL
////        // XSSFDrawing patriarch = sheet.createDrawingPatriarch();
////        XSSFDrawing patriarch = getSheetDrawing();
////        // 图片一导出到单元格I3-5中 列开始：8 行开始：2 列结束：9 行结束：5
////        XSSFClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, 8, 2, 9, 5);
////        anchor.setAnchorType(ClientAnchor.AnchorType.MOVE_AND_RESIZE);
////        // 插入图片内容
////        Picture picture =  patriarch.createPicture(anchor, pictureIndex);
//
//    }
//
//    public void appendingImage(int pictureID,int dx1, int dy1, int dx2, int dy2, int col1, int row1, int col2, int row2){
//        //anchor主要用于设置图片的属性
//        XSSFClientAnchor anchor = new XSSFClientAnchor( dx1,  dy1,  dx2,  dy2,  col1,  row1,  col2,  row2);
//        anchor.setAnchorType(ClientAnchor.AnchorType.MOVE_AND_RESIZE);
//        //插入图片
//        getSheetDrawing().createPicture(anchor, pictureID);
//    }
//
//}
