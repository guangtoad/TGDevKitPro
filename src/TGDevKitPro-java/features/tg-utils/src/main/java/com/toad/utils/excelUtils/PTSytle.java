package com.toad.utils.excelUtils;

import java.util.List;

public class PTSytle {
    public String systemName = "SystemName";
    public String subsystemName;
    public String moduleName;
    public String functionName;
    public String author;
    public String createTime;
    public String updater;
    public String updateTime;
    public String imagesDirPath;
    public List<revisionHistory> revisionHistoryList;

    public class revisionHistory{
        public String differentiate;
        public String changePlace;
        public String changeContent;
        public String changeReason;
        public String changeDate;
        public String changedBy;
        public String recognizer;
    }
}
