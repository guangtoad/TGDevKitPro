# 报价转日程工具

##说明

###  功能

报价导出日程格式的CSV ，需要自己在粘贴到日程里头

### 使用说明

java -jar 

##配置说明

### 文件名称 
TGSetting.yaml
- [x] templatePath: 模版路径 使用FCH给的日志模版 1.1.0版本增加
- [x] quotePath: 报价路径
- [x] sheetName: sheet页
- [x] beginrow: 开始行
- [x] outputPath: 输出路径
- [x] outputType: 输出类型 （csv｜xlsx）  默认使用csv
- [x] titleColumnMin: 页面拼接开始行
- [x] titleColumnMax: 页面拼接结束行
- [x] frontwork: 每个任务开始工作
  - [x] counterpart: 对应人
  - [ ] column: "" 
  - [x] txt: 名称 
  - [ ] required: 必须项目
- [x] assigneds: 判断画全的项目
  - [x] counterpart: 对应人
  - [x] column: 判断的列
  - [x] txt: 名称 
  - [ ] required: 必须项目
- [x] postwork:每个任务验收工作
  - [x] counterpart: 对应人
  - [x] column: 判断的列
  - [x] txt: 名称 
  - [ ] required: 必须项目