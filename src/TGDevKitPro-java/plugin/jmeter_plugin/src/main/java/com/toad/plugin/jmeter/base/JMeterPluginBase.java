package com.toad.plugin.jmeter.base;
import org.apache.jmeter.protocol.http.sampler.HTTPSampler;
import org.apache.log.Logger;
import org.apache.jmeter.samplers.SampleResult;
public class JMeterPluginBase {
    public HTTPSampler sampler; // 添加 sampler 成员变量
    public Logger log;
    public SampleResult prev = new SampleResult();


}
