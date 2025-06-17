package com.toad.plugin.jmeter.sampler;

import org.apache.jmeter.config.Arguments;
import org.apache.jmeter.protocol.java.sampler.AbstractJavaSamplerClient;
import org.apache.jmeter.protocol.java.sampler.JavaSamplerContext;
import org.apache.jmeter.samplers.SampleResult;

public class CustomSampler extends AbstractJavaSamplerClient {

    // 设置默认参数
    @Override
    public Arguments getDefaultParameters() {
        Arguments params = new Arguments();
        params.addArgument("url", "http://example.com");
        params.addArgument("timeout", "5000");
        return params;
    }

    // 初始化方法
    @Override
    public void setupTest(JavaSamplerContext context) {
        // 初始化代码
    }

    // 执行测试方法
    @Override
    public SampleResult runTest(JavaSamplerContext context) {
        SampleResult result = new SampleResult();
        result.sampleStart(); // 开始计时

        try {
            String url = context.getParameter("url");
            String timeout = context.getParameter("timeout");

            result.setSamplerData("Request URL: " + url + "\nTimeout: " + timeout);

            // 这里实现你的自定义逻辑
            // 示例：模拟一个HTTP请求
            boolean success = simulateHttpRequest(url, Integer.parseInt(timeout));

            result.setSuccessful(success);
            result.setResponseCode(success ? "200" : "500");
            result.setResponseMessage(success ? "OK" : "Error occurred");

            if (success) {
                result.setResponseData("Custom request successful", "UTF-8");
            } else {
                result.setResponseData("Custom request failed", "UTF-8");
            }
        } catch (Exception e) {
            result.setSuccessful(false);
            result.setResponseCode("500");
            result.setResponseMessage(e.toString());
            result.setResponseData(("Error: " + e.getMessage()).getBytes());
        } finally {
            result.sampleEnd(); // 结束计时
        }

        return result;
    }

    // 清理方法
    @Override
    public void teardownTest(JavaSamplerContext context) {
        // 清理代码
    }

    private boolean simulateHttpRequest(String url, int timeout) {
        // 模拟HTTP请求逻辑
        // 这里只是一个示例，实际应该实现真实的请求逻辑
        try {
            Thread.sleep(100); // 模拟网络延迟
            return true;
        } catch (InterruptedException e) {
            return false;
        }
    }
}