package com.toad.devkit.common.util;

//import com.toad.ApiService.config.APIConstant;
//import org.apache.commons.codec.binary.Base64;
//import org.apache.commons.codec.binary.Hex;
//import org.apache.commons.codec.digest.DigestUtils;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateCrtKey;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

/**
 * 加密工具类
 */
public class TGEncryptionUtil {
//    /**
//     * Base46
//     */
//    public static final int BASE64_MODE  = 1;
//    /**
//     * 16进制
//     */
//    public static final int HEX_MODE  = 2;
//    /**
//     * Hex 字符串标识
//     */
//    public static final String hexPrefix = "hex:";
//    /**
//     * Base64字符串标识
//     */
//    public static final String Base64Prefix = "base64:";
//    /**
//     * Byte字节转Hex
//     * @param b 字节
//     * @return Hex
//     */
//    public static String byteToHex(byte b) {
//        String hexString = Integer.toHexString(b & 0xFF);
//        //由于十六进制是由0~9、A~F来表示1~16，所以如果Byte转换成Hex后如果是<16,就会是一个字符（比如A=10），通常是使用两个字符来表示16进制位的,
//        //假如一个字符的话，遇到字符串11，这到底是1个字节，还是1和1两个字节，容易混淆，如果是补0，那么1和1补充后就是0101，11就表示纯粹的11
//        if (hexString.length() < 2) {
//            hexString = new StringBuilder(String.valueOf(0)).append(hexString).toString();
//        }
//        return hexString.toUpperCase();
//    }
//    /**
//     * byte[] to HexString
//     * @param input 输入内容
//     * @return 16进制格式化字符串
//     */
//    public static String byteArrayToHex(byte[] input){
//        String result = null;
//        StringBuffer sb = new StringBuffer();
//        if (input != null && input.length > 0)
//        {
//            for (int i = 0; i < input.length; i++) {
//                String hex = byteToHex(input[i]);
//                sb.append(hex);
//            }
//        }
//        result = sb.toString();
//        return result;
//    }
//    /**
//     * byte[] to String
//     * @param bytes 数据内容
//     * @param codecType 模式 HEX_MODE/BASE64_MODE（默认使用）
//     * @param charsetName 字符集
//     * @return
//     */
//    public static String byteArrayToString(byte[] bytes,int codecType,String charsetName){
//        String result = null;
//        switch (codecType) {
//            case HEX_MODE:
//                result = byteArrayToHex(bytes);
//                break;
//            case BASE64_MODE:
//            default:
//                result = Base64.encodeBase64String(bytes);
//                break;
//        }
//        return result;
//    }
//    /**
//     * Sting to byte[]
//     * @param context 数据内容
//     * @param codecType 模式 HEX_MODE/BASE64_MODE（默认使用）
//     * @param charsetName 字符集
//     * @return
//     */
//    public static byte[] stringToByteArray(String context,int codecType,String charsetName) throws Exception{
//        byte[]  result = null;
//        switch (codecType) {
//            case HEX_MODE:
//                result = hexToByteArray(context);
//                break;
//            case BASE64_MODE:
//            default:
//                result = Base64.decodeBase64(context.getBytes(charsetName));
//                break;
//        }
//        return result;
//    }
//    /**
//     * 字符串转 byte[]
//     * @param context 内容
//     * @param charsetName
//     * @return
//     * @throws Exception
//     */
//    public static byte[] stringToByteArray(String context,String charsetName) throws Exception{
//        byte[]  result = null;
//        if (null == context) {
//            return result;
//        }
//        if (context.startsWith(hexPrefix)){
//            return stringToByteArray(context.substring(hexPrefix.length()),HEX_MODE,charsetName);
//        }
//        else if (context.startsWith(Base64Prefix)) {
//            return stringToByteArray(context.substring(Base64Prefix.length()),HEX_MODE,charsetName);
//        }
//        else {
//            return stringToByteArray(context.substring(Base64Prefix.length()),BASE64_MODE,charsetName);
//        }
//    }
//    /**
//     * shar256 加密
//     * @param input 输入内容
//     * @return 加密后数据
//     * @throws Exception
//     */
//    public static byte[] sha256(byte[] input) throws Exception{
//        byte[] result = null;
//        MessageDigest messageDigest;
//        messageDigest = MessageDigest.getInstance("SHA-256");
//        messageDigest.update(input);
//        result = messageDigest.digest();
//        return result;
//    }
//    /**
//     * sha256加密
//     * @param context 等待加密内容
//     * @param charsetName 字符集
//     * @param codecType 输出格式 BASE64_MODE/HEX_MODE
//     * @return
//     * @throws Exception
//     */
//    public static String sha256(String context,String charsetName,int codecType) throws Exception{
//        String result = "";
//        byte[] encodedBytes = sha256(context.getBytes(charsetName));
//        result = byteArrayToString(encodedBytes,codecType,charsetName);
//        return result;
//    }
//    /**
//     * md5 加密
//     * @param context
//     * @return
//     */
//    public static String md5(String context){
//        String md5str = DigestUtils.md5Hex(context);
//        return md5str;
//    }
//    /**
//     * Hex字符串转byte
//     * @param inHex 待转换的Hex字符串
//     * @return  转换后的byte
//     */
//    public static byte hexToByte(String inHex){
//        return (byte)Integer.parseInt(inHex,16);
//    }
//    /**
//     * hex字符串转byte数组
//     * @param inHex 待转换的Hex字符串
//     * @return  转换后的byte数组结果
//     */
//    public static byte[] hexToByteArray(String inHex){
//        int hexlen = inHex.length();
//        byte[] result;
//        if (hexlen % 2 == 1){
//            //奇数
//            hexlen++;
//            result = new byte[(hexlen/2)];
//            inHex="0"+inHex;
//        }else {
//            //偶数
//            result = new byte[(hexlen/2)];
//        }
//        int j=0;
//        for (int i = 0; i < hexlen; i+=2){
//            result[j]=hexToByte(inHex.substring(i,i+2));
//            j++;
//        }
//        return result;
//    }
//    /**
//     * 默认按照字符集转换，如是使用 HEX：开头使用Hex转换
//     * @param string 字符串
//     * @param charsetName 字符集名称
//     * @return 转转后数据
//     * @throws Exception
//     */
//    public static byte[] stringToBytes(String string,String charsetName) throws Exception{
//        byte[] result = null;
//        if (null == string) {
//        }
//        else if (string.length() < 1) {
//        }
//        else if (string.startsWith(APIConstant.APIHexCodecPrefix)){
//            if (string.length() > APIConstant.APIHexCodecPrefix.length()){
//                result = hexToByteArray(string.substring(hexPrefix.length(), Math.max(string.length() - hexPrefix.length(),0)));
//            }
//            else {
//                result = null;
//            }
//        }
//        else {
//            result = string.getBytes(charsetName);
//        }
//        return result;
//    }
//    /**
//     * AES 加解密
//     * @param transformation 暗号化
//     * @param opMode 加密（ENCRYPT_MODE）/解密（DECRYPT_MODE）
//     * @param input 输入内容
//     * @param key 密钥
//     * @param iv 偏移向量
//     * @return 暗号化后的内容
//     * @throws Exception
//     */
//    public static byte[] AESCipher(String transformation,int opMode ,byte[] input ,byte[] key ,byte[] iv) throws Exception{
//        Cipher cipher = Cipher.getInstance(transformation);
//        if (null == transformation || !transformation.startsWith("AES")) {
//            throw new Exception("不支持的加密格式" + transformation);
//        }
//        if (null == cipher) {
//            throw new Exception("创建加密失败");
//        }
//        SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
//        if (transformation.contains("CBC")) {
//            if (null == iv) {
//                throw new Exception("IV 没设置");
//            }
//            IvParameterSpec ivSpec = new IvParameterSpec(iv);
//            cipher.init(opMode, keySpec, ivSpec);
//        }else if(transformation.contains("GCM")){
//            if (null == iv) {
//                throw new Exception("IV 没设置");
//            }
//            GCMParameterSpec ivSpec = new GCMParameterSpec(128, iv);
//            cipher.init(opMode, keySpec, ivSpec);
//        }else {
//            cipher.init(opMode, keySpec);
//        }
//        byte[] result = cipher.doFinal(input);
//        return result;
//    }
//    /**
//     * AES 加解密
//     * @param transformation 暗号化
//     * @param opMode 加密（ENCRYPT_MODE）/解密（DECRYPT_MODE）
//     * @param context 内容
//     * @param keyStr 密钥串,默认
//     * @param ivStr 偏移量串
//     * @param charsetName 字符集
//     * @param codecType 输出模式
//     * @return 暗号化后的内容
//     * @throws Exception
//     */
//    public static String AESCipher(String transformation,int opMode ,String context ,String keyStr ,String ivStr,String charsetName,int codecType) throws Exception {
//        String result = null;
//        byte[] keyBytes = stringToBytes(keyStr,charsetName);
//        byte[] ivBytes = stringToBytes(ivStr,charsetName);
//        byte[] inputBytes = null;
//        switch (opMode){
//            case Cipher.ENCRYPT_MODE:
//                inputBytes = context.getBytes(charsetName);
//                break;
//            case Cipher.DECRYPT_MODE:
//                inputBytes = stringToByteArray(context, codecType, charsetName);
//                break;
//        }
//        byte[] encodedBytes = AESCipher(transformation,opMode,inputBytes,keyBytes,ivBytes);
//        switch (opMode){
//            case Cipher.ENCRYPT_MODE:
//                result = byteArrayToString(encodedBytes,codecType,charsetName);
//                break;
//            case Cipher.DECRYPT_MODE:
//                result = new String(encodedBytes,charsetName);
//                break;
//        }
//        return result;
//    }
//    /**
//     * AES 加密
//     * @param context 内容
//     * @param key 密钥
//     * @param iv 偏移量
//     * @param charsetName 字符集
//     * @param codecType 格式化类型
//     * @return
//     * @throws Exception
//     */
//    public static String AESEncrypt(String context,byte[] key,byte[] iv,String charsetName,int codecType) throws Exception{
//        String result = null;
//        SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
//        IvParameterSpec ivSpec = new IvParameterSpec(iv);
//        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
//        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
//        byte[] encodedBytes = cipher.doFinal(context.getBytes("UTF-8"));
//        result = byteArrayToString(encodedBytes,codecType,charsetName);
//        return result;
//    }
//    /**
//     * AES 加密
//     * @param context 内容
//     * @param key 密钥
//     * @param iv 偏移量
//     * @return 返回AES加密后Base64格式化字符串
//     * @throws Exception
//     */
//    public static String AESEncrypt(String context,byte[] key,byte[] iv) throws Exception{
//        return AESEncrypt(context, key, iv, "UTF-8",TGEncryptionUtil.BASE64_MODE);
//    }
//    /**
//     * AES 解密
//     * @param context 内容
//     * @param transformation 格式
//     * @param keyStr 密钥
//     * @param ivStr 偏移量
//     * @param charsetName 字符集
//     * @param codecType 格式
//     * @return 解密后字符串
//     * @throws Exception 异常
//     */
//    public static String AESDecrypt(String context,String transformation,String keyStr,String ivStr,String charsetName,int codecType) throws Exception{
//        if (null == transformation) {
//
//        }
//        return AESCipher(transformation,Cipher.DECRYPT_MODE,context, keyStr,ivStr,charsetName,codecType);
//    }
//    /**
//     * AES 解密
//     * @param context 内容 支持Base64编码 , Hex格式
//     * @param transformation 格式
//     * @param keyStr 密钥
//     * @param ivStr 偏移量
//     * @param charsetName 字符集
//     * @return 机密后字符串
//     * @throws Exception
//     */
//    public static String AESDecrypt(String context,String transformation,String keyStr,String ivStr,String charsetName) throws Exception{
//        return AESDecrypt( context, transformation, keyStr, ivStr, charsetName,HEX_MODE);
//    }
//    /**
//     * @param context
//     * @param transformation
//     * @param keyStr
//     * @param ivStr
//     * @return
//     * @throws Exception
//     */
//    public static String AESDecrypt(String context,String transformation,String keyStr,String ivStr) throws Exception {
//        return AESDecrypt( context, transformation, keyStr, ivStr, "UTF-8");
//    }
//    /**
//     * AES 解密
//     * @param context 内容
//     * @param key 密钥
//     * @param iv 偏移量
//     * @return 解密后字符串
//     * @throws Exception
//     */
//    public static String AESDecrypt(String context,byte[] key,byte[] iv) throws Exception{
//        return null;
//    }
//    /**
//     * RSA 暗号化
//     * @param transformation
//     * @param opMode ENCRYPT_MODE/DECRYPT_MODE
//     * @param input 输入
//     * @param key 可以
//     * @return
//     * @throws Exception
//     */
//    public static byte[] RSACipher(String transformation,int opMode ,byte[] input ,byte[] key) throws Exception{
//        byte[] result = null;
//        if (null == key) {
//            throw new Exception("没有Key");
//        }
//        Cipher cipher = Cipher.getInstance(transformation);
//        switch (opMode) {
//            case Cipher.ENCRYPT_MODE:{
//                RSAPublicKey pubKey = (RSAPublicKey) KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(key));
//                cipher.init(Cipher.DECRYPT_MODE, pubKey);
//            }
//            break;
//            case Cipher.DECRYPT_MODE:{
//                RSAPrivateKey priKey = (RSAPrivateKey) KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(key));
//                cipher.init(Cipher.DECRYPT_MODE, priKey);
//            }
//            break;
//            default:
//                throw new Exception("加解密设置异常");
//        }
//        result = cipher.doFinal(input);
//        return result;
//    }
//    /**
//     * RSA 加解密
//     * @param transformation 格式
//     * @param opMode ENCRYPT_MODE/DECRYPT_MODE
//     * @param context 内容
//     * @param keyStr 密钥
//     * @param charsetName 字符集
//     * @param outMode 格式化方式
//     * @return
//     * @throws Exception
//     */
//    public static String RSACipher(String transformation,int opMode ,String context ,String keyStr,String charsetName,int outMode) throws Exception{
//        String result = null;
//        byte[] input = context.getBytes(charsetName);
//        byte[] key = keyStr.getBytes(charsetName);
//        byte[] encodedBytes = RSACipher(transformation, opMode, input, key);
//        result = byteArrayToString(encodedBytes,outMode,charsetName);
//        return result;
//    }
}
