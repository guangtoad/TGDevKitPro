//package com.toad.utils.excelUtils;
//
////import com.toad.TGExcelUtil.TGExcelUtil;
//import org.apache.commons.io.FilenameUtils;
////import org.apache.poi.hssf.usermodel.HSSFWorkbook;
////import org.apache.poi.ss.usermodel.*;
////import org.apache.poi.ss.util.CellAddress;
////import org.apache.poi.ss.util.CellRangeAddress;
////import org.apache.poi.xssf.usermodel.XSSFCell;
////import org.apache.poi.xssf.usermodel.XSSFRow;
////import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileOutputStream;
//import java.io.InputStream;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
//public class CTReportUtil extends TGExcelUtil {
//    protected Workbook workbook;
//
//    public class CTReportSheetUtil {
//        Sheet sheet;
//
//        public class cellAdree {
//            cellAdree(int row,int column){
//                this.row = row;
//                this.column = column;
//            }
//            int row;
//            int column;
//        }
//
//
//        public cellAdree stringtoCellAdder(String string) throws Exception{
//            if (!Pattern.matches("^[A-Z]+[0-9]+$", string)) {
//                return null;
//            }
//            Pattern pattern = Pattern.compile("[A-Z]+");
//            Matcher matcher = pattern.matcher(string);
//            String columnsStr = null;
//            if (matcher.find()) {
//                columnsStr = matcher.group(0);
//            }
//            String rowStr = string.substring(columnsStr.length());
//            int columnNumber = stringtoCellNumber(columnsStr);
//            int rowNumber = Integer.parseInt(rowStr) - 1;
//            if (columnNumber < 0 || rowNumber < 0) {
//                throw new Exception("地址错误:" + string);
//            }
//            return new cellAdree(rowNumber, columnNumber);
//        }
//        CTReportSheetUtil(Workbook workbook, String SheetName) {
//            sheet = workbook.getSheet(SheetName);
//        }
//
//        public Cell getCell(int rowNumber,int columnNumber){
//            Row row = sheet.getRow(rowNumber);
//            if (null == row) {
//                row = sheet.createRow(rowNumber);
//            }
//            Cell cell = row.getCell(columnNumber);
//            if (null == cell) {
//                cell = row.createCell(columnNumber);
//            }
//            return cell;
//        }
//        public Cell getCell(String string) throws Exception{
//            cellAdree ca = stringtoCellAdder(string);
//            return getCell(ca.row,ca.column);
//        }
//        public Cell appendingCell(String value, int rowNumber, int cellNumber, CellStyle style) {
//            Cell cell =  getCell(rowNumber,cellNumber);
//            cell.setCellValue(value);
//            if (null != style) {
//                cell.setCellStyle(style);
//            }
//            return cell;
//        }
//        public Cell appendingCell(String value, String excelAdder, CellStyle style) throws Exception{
//            cellAdree ca =  stringtoCellAdder(excelAdder);
//            return appendingCell(value,ca.row,ca.column,style);
//        }
//    }
//
//    public void createReport(PTSytle sytle, String templatePath) throws Exception {
//        File file = new File(templatePath);
//        if (!file.exists()) {
//            throw new Exception("文件不存在!");
//        }
//
//        //  TGUitlCommand.coutLine("读取exel文件：" + filePath);
//
//        String fileExtension = FilenameUtils.getExtension(templatePath);
//        InputStream in = new FileInputStream(file);
//
//        // 读取整个Excel
//        if ("xlsx".equals(fileExtension)) {
//            workbook = new XSSFWorkbook(in);
//        } else if ("xlsx".equals(fileExtension)) {
//            workbook = new HSSFWorkbook(in);
//        }
//        CTReportSheetUtil revisionHistorySheet = new CTReportSheetUtil(workbook,"变更履历");
//        revisionHistorySheet.appendingCell("asdasd","J2",null);
//        revisionHistorySheet.appendingCell("asdasd","J3",null);
//        revisionHistorySheet.appendingCell("asdasd","V2",null);
//        revisionHistorySheet.appendingCell("asdasd","V3",null);
//        revisionHistorySheet.appendingCell("asdasd","AH2",null);
//        revisionHistorySheet.appendingCell("asdasd","AH3",null);
//        revisionHistorySheet.appendingCell("asdasd","AQ2",null);
//        revisionHistorySheet.appendingCell("asdasd","AQ3",null);
//
//        CTReportSheetUtil ctReportSheet = new CTReportSheetUtil(workbook,"CT检证结果");
//        int titleRowNumber = 4;
//        int valueRowNumber = 5;
//        Row titleRow = ctReportSheet.sheet.getRow(titleRowNumber);
//        Row caseRow = ctReportSheet.sheet.getRow(valueRowNumber);
//        int countRow = 32;
//        for (int i = 0 ;i< 2;i++){
//            for (int c = stringtoCellNumber("B"); c<=stringtoCellNumber("AU"); c++){
//                CellStyle tmpstyle = null;
//                switch (i){
//                    case 0:
//                        tmpstyle = titleRow.getCell(c).getCellStyle();
//                        break;
//                    default:
//                        tmpstyle = caseRow.getCell(c).getCellStyle();
//                        break;
//                }
//                ctReportSheet.appendingCell("", countRow + i, c, tmpstyle);
//            }
//        }
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
//}