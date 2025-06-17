package com.toad.java.TGquote2schedule;

import java.util.ArrayList;
import java.util.List;

public class TaskInfo {
    public String txt;
    public int level;
    public int count;
    public String mark;
    public String counterpart;
    public String beginDateString;
    public String endDateString;
    public List<TaskInfo> subTask;

    public TaskInfo(String txt, int level, String mark, int count, String counterpart, String beginDateString, String endDateString){
        this.txt = txt;
        this.level = level;
        this.count = count;
        this.counterpart = counterpart;
        this.beginDateString = beginDateString;
        this.endDateString = endDateString;
        this.subTask = new ArrayList<>();;
    }

    public TaskInfo(String txt, int level){
        this(txt,level,"",100,"","","");
    }

    public TaskInfo(){
        this("",1,"",100,"","","");
    }

    public void addSubTask(TaskInfo taskinfo){
        if (null != taskinfo){
            subTask.add(taskinfo);
        }
    }
}
