package com.toad.java.util.jmeter.samplers;

import org.apache.jmeter.protocol.java.sampler.AbstractJavaSamplerClient;
import org.apache.jmeter.protocol.java.sampler.JavaSamplerContext;
import org.apache.jmeter.samplers.SampleResult;

public class TGAJavaSamplerClient extends AbstractJavaSamplerClient {
    @Override
    public SampleResult runTest(JavaSamplerContext javaSamplerContext) {
        SampleResult result= new SampleResult();
        result.sampleStart();
        try{
//发出请求
            result.sampleEnd();
//请求成功，设置测试结果为成功
            result.setSuccessful(true);
            result.setResponseData("data...");
            result.setResponseMessage("message..");
            result.setResponseCodeOK();
        }catch(Exception e){
//请求失败，设置测试结果为失败
            result.sampleEnd();
            result.setSuccessful(false);
            result.setResponseCode("500");
        }
        return result;
    }

    @Override
    public void teardownTest(JavaSamplerContext context) {
        super.teardownTest(context);
    }
}
