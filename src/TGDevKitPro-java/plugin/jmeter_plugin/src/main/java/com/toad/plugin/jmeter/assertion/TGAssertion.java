package com.toad.java.util.jmeter.assertion;
import com.toad.java.util.jmeter.bean.TGBSHBean;
import org.apache.jmeter.samplers.SampleResult;
import org.apache.log4j.Logger;
import bsh.*;

public class TGAssertion {
    public String FailureName;
    public boolean Failure;
    public String FailureMessage;
    Logger log;
    public SampleResult prev;
    boolean IsSuccess;
    public TGBSHBean bsh;
}
