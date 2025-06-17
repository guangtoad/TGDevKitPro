package com.toad.java.TGquote2schedule;

import com.toad.java.TGquote2schedule.uitl.command.TGUitlCommand;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TGquote2schedule {
    public Config config = null;
    XSSFWorkbook workbook = null;
    public TGquote2schedule(Config config){
        this.config = config;
    }

    public int stringtoCellNumber(String a){
        return Stringtoint(a) - 1;
    }
    public int Stringtoint(String a){
        int result = 0;
        if (null == a);
        for (int i = 0 ; i < a.chars().count();i++ ){
            char c = a.charAt(0);
            result += c  - 'A'+ 1;
        }
        return result;
    }
    public  TaskInfo BuildSubTaskInfo(Assigned assigned,int level , String mark,int count) {
        TaskInfo subTask = new TaskInfo(
                assigned.txt,
                level,
                mark,
                count,
                assigned.counterpart,
                assigned.beginDateString,
                assigned.endDateString);
        return subTask;
    }

    public String createCsvString(List<TaskInfo> tasks){
        StringBuilder stringBuilder = new StringBuilder();
        if (null != tasks) {
            for (int i = 0; i < tasks.size();i++){
                TaskInfo taskInfo =  tasks.get(i);
                stringBuilder.append(String.format(",%s,,,,,,,,%s,,,,,,,,",taskInfo.txt,taskInfo.counterpart) + "\n");
                if (null != taskInfo.subTask && taskInfo.subTask.size() > 0) {
                    for (int index = 0; index < taskInfo.subTask.size();index++){
                        TaskInfo subTask = taskInfo.subTask.get(index);
                        stringBuilder.append(String.format(",,%s,,,,,,100,,%s,%s,%s,,,,,,",subTask.txt,subTask.counterpart,subTask.beginDateString,subTask.endDateString) + "\n");
                    }
                }
            }
        }
        String result = stringBuilder.toString();
        return result;
    }

    public XSSFCellStyle createHeadTitle(XSSFWorkbook workbook){
        XSSFFont xssfFont = workbook.createFont();
        xssfFont.setBold(true);
        xssfFont.setFontName("楷体");
        xssfFont.setFontHeight(11);
        XSSFCellStyle headStyle = workbook.createCellStyle();
        headStyle.setFont(xssfFont);
        return headStyle;
    }
    public XSSFCellStyle createStyle(int level){
        return null;
//        BorderStyle.DASHED
//        if (null == this.workbook) {
//            return null;
//        }
//        //设置样式
//        XSSFFont xssfFont = this.workbook.createFont();
//        if (level > 1) {
//            xssfFont.setFontHeight(11);
//        }
//        else {
//            xssfFont.setBold(true);
//            xssfFont.setFontHeight(14);
//        }
//        XSSFCellStyle cellStyle = this.workbook.createCellStyle();
//        cellStyle.setFont(xssfFont);
//        cellStyle.setWrapText(true); // 设置自动换行
//        cellStyle.setHidden(true); // 高度自动
//        BorderStyle borderStyle = BorderStyle.DASHED;
//        cellStyle.setBorderLeft(borderStyle);
//        cellStyle.setBorderRight(borderStyle);
//        cellStyle.setBorderTop(borderStyle);
//        cellStyle.setBorderBottom(borderStyle);
//        return cellStyle;
    }
    public XSSFCellStyle createHeadStyle(){
        if (null == this.workbook) {
            return null;
        }
        //设置样式
        XSSFFont xssfFont = this.workbook.createFont();
        xssfFont.setBold(true);
        xssfFont.setFontHeight(14);
        XSSFCellStyle cellStyle = this.workbook.createCellStyle();
        cellStyle.setFont(xssfFont);
        BorderStyle borderStyle = BorderStyle.DASHED;
        cellStyle.setBorderLeft(borderStyle);
        cellStyle.setBorderRight(borderStyle);
        cellStyle.setBorderTop(borderStyle);
        cellStyle.setBorderBottom(borderStyle);
        return cellStyle;
    }

    public static void setCellValue(XSSFCell cell,String value){
        cell.setCellValue(value);
    }

    public void appendCellValue(XSSFRow row, String clumn, String value,XSSFCellStyle style){
        int clumnindex = stringtoCellNumber(clumn);
        XSSFCell cell = row.createCell(clumnindex);
        setCellValue(cell, value);
        if (null != style){
            cell.setCellStyle(style);
        }
    }

    public void appendCellValue(XSSFRow row, String clumn, String value){
//        XSSFCellStyle cellStyle = createHeadStyle();
        appendCellValue(row,clumn,value,null);
    }

    public void appendCells(XSSFRow row,TaskInfo taskInfo){
        if (null != taskInfo) {
            XSSFCellStyle style = createStyle(taskInfo.level);
            int max = stringtoCellNumber("j");
            switch (taskInfo.level){
                case 2:{
                    appendCellValue(row,"D",taskInfo.txt,style);
                }
                break;
                default:{
                    appendCellValue(row,"C",taskInfo.txt,style);
                }
                break;
            }
            appendCellValue(row,"J",taskInfo.count>0 ? taskInfo.count + "" : "",style);
            appendCellValue(row,"L",taskInfo.counterpart,style);
            appendCellValue(row,"N",taskInfo.beginDateString,style);
            appendCellValue(row,"O",taskInfo.endDateString,style);
        }
    }

    public XSSFRow appendRow(XSSFSheet sheet,TaskInfo taskInfo,int rownum){
        XSSFRow row = sheet.createRow(rownum);
        XSSFFont xssfFont = this.workbook.createFont();
        xssfFont.setFontHeight(10);
//        CellStyle style = workbook.createCellStyle();
//        style.setFont(xssfFont);
//        BorderStyle borderStyle = BorderStyle.DASHED;
//        style.setBorderLeft(borderStyle);
//        style.setBorderRight(borderStyle);
//        style.setBorderTop(borderStyle);
//        style.setBorderBottom(borderStyle);
//        row.setRowStyle(style);
        appendCells(row, taskInfo);
        return row;

    }

    public HSSFWorkbook createWorBook(List<TaskInfo> tasks ,String templatePath) throws Exception{
        File temmlateFile = new File(templatePath);
        if (!temmlateFile.exists()){
            throw new Exception("templatePath 不存在：" + templatePath);
        }
        InputStream inputStream = new FileInputStream(temmlateFile);
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
        String sheetName = "SCHEDULE";
        HSSFSheet sheet = workbook.getSheet(sheetName);
        if (null == sheet)
            throw new Exception("Sheet 不能存在:" + sheetName);
        int tRow = 16;
        HSSFRow row =  sheet.getRow(tRow);
        if (null == row)
            throw new Exception("Row 不能存在:" + tRow);
        List<CellStyle> styles = new ArrayList<CellStyle>();
        int maxCellNumber = stringtoCellNumber("O") + 1;
        for (int cellnum = 0 ;cellnum < maxCellNumber;cellnum++){
            HSSFCell cell = row.getCell(cellnum);
            CellStyle style =  cell.getCellStyle();
            styles.add(style);
        }
        int rowNumber = tRow + 1;
        for (int i = 0; i < tasks.size(); i++){
            TaskInfo taskInfo = tasks.get(i);
            HSSFRow newRow =  sheet.createRow(rowNumber++);
            for (int cellnum = 0; cellnum < maxCellNumber;cellnum++) {
                HSSFCell cell =  newRow.createCell(cellnum);
                cell.setCellStyle(styles.get(cellnum));
                switch (cellnum) {
                    case 0: {
//                        cell.setCellValue("=ROW()-"+ tRow);
                    }
                    break;
                    case 2: {
                        if (taskInfo.level == 1) {
                            cell.setCellValue(taskInfo.txt);
                        }
                    }
                    break;
                    case 3: {
                        if (taskInfo.level == 2) {
                            cell.setCellValue(taskInfo.txt);
                        }
                    }
                    break;
                    default:
                        break;
                }
            }
            for (int subIndex = 0; subIndex < taskInfo.subTask.size(); subIndex++){
                TaskInfo subTaskInfo = taskInfo.subTask.get(subIndex);
                HSSFRow subRow =  sheet.createRow(rowNumber++);
                for (int cellnum = 0; cellnum < maxCellNumber;cellnum++) {
                    HSSFCell cell =  subRow.createCell(cellnum);
                    cell.setCellStyle(styles.get(cellnum));
                    switch (cellnum) {
                        case 2: {
                            if (subTaskInfo.level == 1) {
                                cell.setCellValue(subTaskInfo.txt);
                            }
                        }
                        break;
                        case 3: {
                            if (subTaskInfo.level == 2) {
                                cell.setCellValue(subTaskInfo.txt);
                            }
                        }
                        break;
                        case 6:{
                            cell.setCellValue(taskInfo.mark);
                        }
                        break;
                        case 9:{
                            cell.setCellValue(subTaskInfo.count);
                        }
                        break;
                        case 11:{
                            cell.setCellValue(subTaskInfo.counterpart);
                        }
                        break;
                        case 13:{
                            try {
                                Date beginDate = new SimpleDateFormat("yyyy/MM/dd").parse(subTaskInfo.beginDateString);
                                cell.setCellValue(beginDate);
                            }
                            catch (Exception e){
                                cell.setCellValue(subTaskInfo.beginDateString);
                            }
                        }
                        break;
                        case 14:{
                            try {
                                Date endDate = new SimpleDateFormat("yyyy/MM/dd").parse(subTaskInfo.endDateString);
                                cell.setCellValue(endDate);
                            }
                            catch (Exception e){
                                cell.setCellValue(subTaskInfo.endDateString);

                            }
                        }
                        break;
                        default:
                            break;
                    }
                }
            }
        }
        return workbook;
    }

    public XSSFWorkbook createWorBook(List<TaskInfo> tasks){
        workbook = null;
        if (null != tasks && tasks.size() > 0){
            workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("日程");
            int rowNumber = 0;
            for (int i = 0; i < tasks.size(); i++){
                TaskInfo taskInfo = tasks.get(i);
                appendRow(sheet,taskInfo,rowNumber++);
                if (null != taskInfo.subTask && taskInfo.subTask.size() > 0){
                    for (int index = 0; index < taskInfo.subTask.size(); index++){
                        TaskInfo subTask = taskInfo.subTask.get(index);
                        appendRow(sheet,subTask,rowNumber++);
                    }
                }
            }
        }
        else {

        }
        return workbook;
    }

    public List<TaskInfo>  getTaskList() throws Exception{
        String filePath = config.quotePath;

        File file = new File(filePath);
        if (!file.exists()){
            throw new Exception("文件不存在!");
        }

        TGUitlCommand.coutLine("读取exel文件：" + filePath);

        String fileExtension = FilenameUtils.getExtension(filePath);
        InputStream in = new FileInputStream(file);
        Workbook workbook = null;
        // 读取整个Excel
        if ("xlsx".equals(fileExtension)){
            workbook = new XSSFWorkbook(in);
        }
        else if ("xlsx".equals(fileExtension)){
            workbook = new HSSFWorkbook(in);
        }
        String sheetName = config.sheetName;
        Sheet sheet = workbook.getSheet(sheetName);

        if (null == sheetName) {
            throw new Exception("SHEET页不存在:" + sheetName);
        }

        int titleColumnMin = stringtoCellNumber(config.titleColumnMin);
        int titleColumnMax = stringtoCellNumber(config.titleColumnMax);

        TaskInfo taskInfo = null;
        List<TaskInfo> tasks = new ArrayList<>();
        for (int i = config.beginrow - 1; i < sheet.getPhysicalNumberOfRows() && i < config.endrow; i++) {
            Row row = sheet.getRow(i);
            String taskName = "";
            StringBuilder stringBuilder = new StringBuilder();
            if (titleColumnMin < titleColumnMax) {
                for (int index = titleColumnMin; index < titleColumnMax;index++) {
                    if (index < row.getPhysicalNumberOfCells()) {
                        Cell cell = row.getCell(index);
                        if (null == cell) {
                            continue;
                        }
                        cell.setCellType(CellType.STRING);
                        String cellStr = cell.getStringCellValue().replaceAll("\\s*", "");;
                        if (cellStr.length() > 0) {
                            if (stringBuilder.length() > 0){
                                stringBuilder.append("-" + cell.getStringCellValue());
                            }
                            else {
                                stringBuilder.append(cell.getStringCellValue());
                            }
                        }
                    }
                }
            }

            if (stringBuilder.length() > 0) {
                if (null != taskInfo) {
                    if (config.postwork.size() > 0) {
                        for (int index = 0; index < config.postwork.size(); index++){
                            Assigned assigned = config.postwork.get(index);
                            TaskInfo subTask = BuildSubTaskInfo(assigned,2,"",100);
                            taskInfo.addSubTask(subTask);
                        }
                    }
                }
                else {

                }
                taskInfo = new TaskInfo(
                        stringBuilder.toString(),
                        1,
                        "",
                        0,
                        "",
                        "",
                        "");
                if (config.frontwork.size() > 0) {
                    for (int index = 0; index < config.frontwork.size(); index++){
                        Assigned assigned = config.frontwork.get(index);
                        TaskInfo subTask = BuildSubTaskInfo(assigned,2,"",100);
                        taskInfo.addSubTask(subTask);
                    }
                }
                tasks.add(taskInfo);
            }
            if (null != taskInfo) {
                if (config.assigneds.size() > 0){
                    for (int index = 0 ; index < config.assigneds.size();index++){
                        Assigned assigned = config.assigneds.get(index);
                        int column = stringtoCellNumber(assigned.column);
                        if (column < row.getPhysicalNumberOfCells()) {
                            Cell cell = row.getCell(column);
                            if (null == cell) {
                                continue;
                            }
                            cell.setCellType(CellType.STRING);
                            String cellStr = cell.getStringCellValue().replaceAll("\\s*", "");;
                            if (cellStr.length() > 0) {
                                TaskInfo subTask = BuildSubTaskInfo(assigned,2,"",100);
                                taskInfo.addSubTask(subTask);
                            }
                        }
                    }
                }
            }
        }
        if (config.postwork.size() > 0 && null != taskInfo) {
            for (int index = 0; index < config.postwork.size(); index++){
                Assigned assigned = config.postwork.get(index);
                TaskInfo subTask = BuildSubTaskInfo(assigned,2,"",100);
                taskInfo.addSubTask(subTask);
            }
        }
        if (null != tasks && tasks.size() > 0) {
            if (null != config.otherTask && config.otherTask.size() > 0) {
                for (int i = 0; i < config.otherTask.size(); i++) {
                    TaskInfo otherTaskInfo = config.otherTask.get(i);
                    tasks.add(new TaskInfo(
                            otherTaskInfo.txt,
                            1,
                            otherTaskInfo.mark,
                            0,
                            otherTaskInfo.counterpart,
                            otherTaskInfo.beginDateString,
                            otherTaskInfo.endDateString));
                    if (null != otherTaskInfo.subTask && otherTaskInfo.subTask.size() > 0) {
                        for (int index = 0; index < otherTaskInfo.subTask.size(); index++) {
                            TaskInfo otherSubTaskInfo = otherTaskInfo.subTask.get(index);
                            tasks.add(new TaskInfo(
                                    otherSubTaskInfo.txt,
                                    2,
                                    otherSubTaskInfo.mark,
                                    otherSubTaskInfo.count,
                                    otherSubTaskInfo.counterpart,
                                    otherSubTaskInfo.beginDateString,
                                    otherSubTaskInfo.endDateString));
                        }
                    }
                }
            }
        }
        return tasks;
    }
    public String getOutPuthType(){
        if ("xlsx".equals(config.outputType)){
            return config.outputType;
        }
        return "csv";
    }
    public void outputTasks(List<TaskInfo> tasks) throws Exception {
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String currentSimpleDateFormat = simpleDateFormat.format(date);
        String outPuthType = getOutPuthType();

        String outPath = config.outputPath + File.separator + currentSimpleDateFormat + "." + outPuthType;
        if (null != config.templatePath && config.templatePath.length() > 0) {
            outPath = config.outputPath + File.separator + currentSimpleDateFormat + "." + "xls";
        }

        File outFile = new File(outPath);
        if (outFile.exists()) {
            throw new Exception("文件已存在：" + outPath);
        }
        TGUitlCommand.coutLine("写入文件：" + outPath);

        if (null != config.templatePath && config.templatePath.length() > 0){
            HSSFWorkbook outWorkbook = createWorBook(tasks,config.templatePath);
            if (null == outWorkbook){
                throw new Exception("createWorBook Exception");
            }
            FileOutputStream out = new FileOutputStream(outFile);
            outWorkbook.write(out);
            out.close();
        }
        else if ("csv".equals(outPuthType)) {
            String outString = createCsvString(tasks);
            outFile.createNewFile();
            FileWriter outFileWritter = new FileWriter(outFile.getCanonicalPath(), true);
            outFileWritter.write(outString);
            outFileWritter.close();
        }
        else if ("xlsx".equals(outPuthType)) {
            XSSFWorkbook outWorkbook = createWorBook(tasks);
            if (null == outWorkbook){
                throw new Exception("createWorBook Exception");
            }
            FileOutputStream out = new FileOutputStream(outFile);
            outWorkbook.write(out);
            out.close();
        }
        else {
            throw new Exception("未知类型：" + outPuthType);
        }
    }

    public void run() throws Exception {
        List<TaskInfo> tasks = getTaskList();
        outputTasks(tasks);
    }
}
