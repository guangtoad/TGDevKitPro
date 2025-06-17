package com.toad.java.tgmeter.bean;

import org.apache.jmeter.samplers.SampleResult;
import org.apache.log4j.Logger;

public class TGAssertion {
    public String FailureName;
    public boolean Failure;
    public String FailureMessage;
    public Logger log;
    public SampleResult prev;
    public boolean IsSuccess;
    public TGBSHBean bsh;
}
