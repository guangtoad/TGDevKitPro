package com.toad.plugin.jmeter;

import com.toad.plugin.jmeter.base.JMeterPluginBase;
import org.apache.jmeter.protocol.http.control.HeaderManager;
import org.apache.jmeter.protocol.http.control.Header;
import org.apache.jmeter.protocol.http.util.Base64Encoder;
public class EQ extends JMeterPluginBase {
    void fun1() {
        // 获得请求头信息
        HeaderManager headers = sampler.getHeaderManager();
        // 获取认证信息
        Header header = headers.getFirstHeaderNamed("Authorization");
        if (null != header) {
            log.info("获取 Authorization:" + header.getValue());
            String encodeAuth = Base64Encoder.encode(header.getValue());
            log.info("加密后 Authorization:" + encodeAuth);
            header.setValue(encodeAuth);
        }
        else {
            log.info("没有获取到Authorization");
        }
        // 获取body内容将body进行base加密并设置在请求中
        if (sampler.getPostBodyRaw()) {
            String body = sampler.getArguments().getArgument(0).getValue();
            if (body != null && !body.isEmpty()) {
                String encodedBody = Base64Encoder.encode(body);
                // 将修改后的请求体和签名添加到请求参数中
                sampler.getArguments().removeAllArguments();
                sampler.addNonEncodedArgument("", encodedBody, "");
                sampler.setPostBodyRaw(true);
            }
        }
    }
}
