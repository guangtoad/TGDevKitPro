package com.toad.plugin.jmeter.response;

import com.toad.plugin.jmeter.base.JMeterBeanShellBase;
import java.io.*;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;
import org.xml.sax.InputSource;
import java.util.Base64;

public class RES extends JMeterBeanShellBase {
    void fun1() {
        // 获取返回的body内容
        String responseBody = prev.getResponseDataAsString();

        // 将获取到的body进行base64解码
        byte[] decodedBytes = Base64.getDecoder().decode(responseBody);
        String decodedBody = new String(decodedBytes);

        // 使用xml解析器解析返回的body
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            InputSource is = new InputSource(new StringReader(decodedBody));
            Document doc = builder.parse(is);

            // 示例：获取根元素
            Element root = doc.getDocumentElement();
            // todo 解析成map
            log.info("Root element: " + root.getNodeName());
        } catch (Exception e) {
            log.error("XML解析失败: " + e.getMessage());
        }
    }
}
