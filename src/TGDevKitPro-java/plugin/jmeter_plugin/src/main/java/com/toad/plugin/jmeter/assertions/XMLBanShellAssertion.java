package com.toad.java.tgmeter.jmeter.assertions;

import com.alibaba.fastjson2.JSONObject;
import com.toad.java.tgmeter.bean.TGAssertion;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.StringReader;
import java.util.Arrays;
import java.util.List;

public class XMLBanShellAssertion extends TGAssertion {

    public void getString(){

        if (bsh.args.length < 1){

        }
        String json_text = "{\"a\":\"b\"}";
        JSONObject jsonObject = JSONObject.parseObject(json_text);
        jsonObject.get("a");
        log.info("测试脚本开始");
        String responseStr = prev.getResponseDataAsString();
        String responseHeaders = prev.getResponseHeaders();
        log.info("返回结果:" + responseHeaders);
        List<String> xpathList = Arrays.asList(
                "/SPML/AUTHENTICATION_INFO/NAVI_STATUS"
                , "/SPML/AUTHENTICATION_INFO/NAVI_PLAN"
                , "/SESSION/AUTHENTICATION_INFO/DCMMODELYEAR");

        try {
            DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
            domFactory.setNamespaceAware(true);
            DocumentBuilder builder = domFactory.newDocumentBuilder();
            StringReader stringReader = new StringReader(responseStr);
            InputSource is = new InputSource(stringReader);
            Document doc = builder.parse(is);
            XPath xpath = XPathFactory.newInstance().newXPath();

            for (int i = 0;i < bsh.args.length;i++){
                log.info(String.format("args[%d]：%s", i,bsh.args[i]));
            }
            for (String xpathString : xpathList
            ) {
                XPathExpression expr = xpath.compile(xpathString);
                NodeList nodes = (NodeList)expr.evaluate(doc, XPathConstants.NODESET);
                // extract all the keys in loop
                for (int i = 0; i < nodes.getLength(); i++) {
                    String value = nodes.item(i).getTextContent();
                    log.info(value + "\txpath:" +xpathString);
                }
            }
        } catch (Exception ex) {
            IsSuccess = false;
            log.error(ex.getMessage());
            ex.printStackTrace();
        }
        log.info("测试脚本结束");


    }
}

