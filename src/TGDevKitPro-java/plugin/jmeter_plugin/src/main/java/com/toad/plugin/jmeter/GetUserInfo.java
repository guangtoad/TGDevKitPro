package com.toad.plugin.jmeter;
import java.io.*;
import java.util.Map;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.xml.sax.SAXException;
import org.w3c.dom.*;
import org.xml.sax.InputSource;

public class GetUserInfo {
    public void testRun(){
////        log.info("测试脚本开始");
////取返回值
//        String responseStr = prev.getResponseDataAsString();
//        String responseHeaders = prev.getResponseHeaders();
////        log.info("返回结果:" + responseHeaders);
////log.info("返回结果:" + responseStr);
//        String xpathExpr = "/SPML/RESULT/CODE";
//
//        try {
//            DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
//            domFactory.setNamespaceAware(true);
//            DocumentBuilder builder = domFactory.newDocumentBuilder();
//            StringReader stringReader = new StringReader(responseStr);
//            InputSource is = new InputSource(stringReader);
//            Document doc = builder.parse(is);
//            XPath xpath = XPathFactory.newInstance().newXPath();
//            XPathExpression expr = xpath.compile(xpathExpr);
//            NodeList nodes = (NodeList)expr.evaluate(doc, XPathConstants.NODESET);
//            // extract all the keys in loop
//            for (int i = 0; i < nodes.getLength(); i++) {
//                String value = nodes.item(i).getTextContent();
//                if (!value.startsWith("0"))
//                {
//                    Failure = true;
//                    FailureMessage = "返回码错误:" + value;
//                    FailureName = value;
//                }
//                else {
//
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
