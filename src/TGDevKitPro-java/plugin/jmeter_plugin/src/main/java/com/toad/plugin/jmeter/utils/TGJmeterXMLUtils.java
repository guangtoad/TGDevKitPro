package com.toad.jmeter.util;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;

import java.io.*;

public class TGJmeterXMLUtils {

    public static void Dom2Map333(Document document) throws IOException {
        FileWriter fstream = new FileWriter("/Users/toad/Desktop/out/bbc.csv",true);
        BufferedWriter out = new BufferedWriter(fstream);
        out.write("asdasd" + "\n");
        out.close();
        fstream.close();
    }

    public static Map<String, Object> Dom2Map(Document document) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (document == null)
            return map;
        return map;
    }

    public static Map<String, Object> xml2Map(String xmlStr) throws ParserConfigurationException, IOException, SAXException {
        DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
        domFactory.setNamespaceAware(true);
        DocumentBuilder builder = domFactory.newDocumentBuilder();
        StringReader stringReader = new StringReader(xmlStr);
        InputSource is = new InputSource(stringReader);
        Document document = builder.parse(is);
        return Dom2Map(document);
    }

    public String getValueWithXpath(String xmlStr, String xpathStr) {
        try {
            DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
            domFactory.setNamespaceAware(true);
            DocumentBuilder builder = domFactory.newDocumentBuilder();
            StringReader stringReader = new StringReader(xmlStr);
            InputSource is = new InputSource(stringReader);
            Document document = builder.parse(is);
            XPath xpath = XPathFactory.newInstance().newXPath();
            XPathExpression expr = xpath.compile(xpathStr);
            NodeList nodes = (NodeList) expr.evaluate(document, XPathConstants.NODESET);
            for (int i = 0; i < nodes.getLength(); i++) {
                return nodes.item(i).getTextContent();
            }
            return null;
        } catch (XPathExpressionException exc) {

        } catch (ParserConfigurationException exc) {

        } catch (Exception exc) {

        }
        return null;

    }
}
