package com.toad.plugin.jmeter.assertion;
import com.alibaba.fastjson2.JSONB;
import com.alibaba.fastjson2.JSONObject;
import com.fasterxml.jackson.databind.JsonNode;
import netscape.javascript.JSObject;
import org.apache.log4j.Logger;
import java.io.*;
import java.util.Arrays;
import java.util.List;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.xml.sax.SAXException;
import org.w3c.dom.*;
import org.xml.sax.InputSource;


public class XMLBanShellAssertion extends TGAssertion {
    public void getString(){

//        if (bsh.args.length < 1){
//
//        }
//        String json_text = "{\"a\":\"b\"}";
//        JSONObject jsonObject = JSONObject.parseObject(json_text);
//        jsonObject.get("a");
//        log.info("测试脚本开始");
//        String responseStr = prev.getResponseDataAsString();
//        String responseHeaders = prev.getResponseHeaders();
//        log.info("返回结果:" + responseHeaders);
//        List<String> xpathList = Arrays.asList(
//                "/SPML/AUTHENTICATION_INFO/NAVI_STATUS"
//                , "/SPML/AUTHENTICATION_INFO/NAVI_PLAN"
//                , "/SESSION/AUTHENTICATION_INFO/DCMMODELYEAR");
//
//        try {
//            DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
//            domFactory.setNamespaceAware(true);
//            DocumentBuilder builder = domFactory.newDocumentBuilder();
//            StringReader stringReader = new StringReader(responseStr);
//            InputSource is = new InputSource(stringReader);
//            Document doc = builder.parse(is);
//            XPath xpath = XPathFactory.newInstance().newXPath();
//
//            for (int i = 0;i < bsh.args.length;i++){
//                log.info(String.format("args[%d]：%s", i,bsh.args[i]));
//            }
//            for (String xpathString : xpathList
//            ) {
//                XPathExpression expr = xpath.compile(xpathString);
//                NodeList nodes = (NodeList)expr.evaluate(doc, XPathConstants.NODESET);
//                // extract all the keys in loop
//                for (int i = 0; i < nodes.getLength(); i++) {
//                    String value = nodes.item(i).getTextContent();
//                    log.info(value + "\txpath:" +xpathString);
//                }
//            }
//        } catch (Exception ex) {
//            IsSuccess = false;
//            log.error(ex.getMessage());
//            ex.printStackTrace();
//        }
//        log.info("测试脚本结束");
    }
}
