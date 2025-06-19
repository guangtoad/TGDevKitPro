package com.toad.devkit.common.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

public class SecretUtil {
    //这里需要设置你的32位字节密钥
    public static final String ENCRYPT_OR_DECRYPT_KEY = "bce8b17919472bf266e92ed650c06479";
    // 256位密钥 = 32 bytes Key:
    //CBC模式是安全性较高的AES加密模式，采用一个随机数作为向量IV参数，这样对于同一份明文，
    // 每次生成的密文都不同，向量的位数相对保密
    public static final byte[] BYTES_KEY = ENCRYPT_OR_DECRYPT_KEY.getBytes(StandardCharsets.UTF_8);
    public static final String INSTANCE = "AES/CBC/PKCS5Padding";
    public static final String AES = "AES";

    public static void main(String[] args) throws Exception {
        String testEncryptStr = "test123";
        String testResult1 = encrypt(testEncryptStr);
        System.out.println("第一次加密后的结果：" + testResult1);
        String testResult2 = encrypt(testEncryptStr);
        System.out.println("第一次加密后的结果：" + testResult2);
        System.out.println("解密第一次加密后的字符串：" + decrypt(testResult1));
        System.out.println("解密第二次加密后的字符串：" + decrypt(testResult2));

//        Uri uri = Uri.parse("https://graph.facebook.com/me/home?limit=25&since=1374196005");
//        String protocol = uri.getScheme();
//        String server = uri.getAuthority();
//        String path = uri.getPath();
//        Set<String> args = uri.getQueryParameterNames();
//        String limit = uri.getQueryParameter("limit");
//        URL a = new URL("asd");
//        URLDecoder.decode("http", '');
    }

    /**
     * 加密，采用CBC的方式，引入16 Bytes向量作为加密参数之一，加密后将向量拼接密文发送给调用方。
     *
     * @param encryptStr 加密字段
     * @return   返回加密后的结果字符串
     * @throws Exception
     */

    public static String encrypt(String encryptStr) throws Exception {
        Cipher cipher = Cipher.getInstance(INSTANCE);
        SecretKeySpec keySpec = new SecretKeySpec(BYTES_KEY, AES);
        // 生成一个16 bytes的初始化向量用于加密解密，向量会随密文一并返回给调用方，
        // 调用方只需按位分离向量和密文
        SecureRandom sr = SecureRandom.getInstanceStrong();
        byte[] iv = sr.generateSeed(16);
        IvParameterSpec ivps = new IvParameterSpec(iv);
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivps);
        byte[] data = cipher.doFinal(encryptStr.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(join(iv, data));
        // 拼接IV和密文，并返回给调用方
//        return DatatypeConverter.printBase64Binary(join(iv, data));
    }

    /**
     * 解密，CBC模式解密，需要按约定将传递过来的字符串拆分成向量部分和密文部分，
     * 再通过向量和密钥来解密密文
     *
     * @param decryptStr 传递过来的向量和密文
     * @return 返回解密后的内容
     * @throws Exception
     */
    public static String decrypt(String decryptStr) throws Exception {
        byte[] iv = new byte[16];

//        byte[] input = DatatypeConverter.parseBase64Binary(decryptStr);
        byte[] input = Base64.getDecoder().decode(decryptStr);
        byte[] data = new byte[input.length - 16];
        // 分离IV和密文
        System.arraycopy(input, 0, iv, 0, 16);
        System.arraycopy(input, 16, data, 0, data.length);
        // 解密
        Cipher cipher = Cipher.getInstance(INSTANCE);
        SecretKeySpec keySpec = new SecretKeySpec(BYTES_KEY, AES);
        IvParameterSpec ivps = new IvParameterSpec(iv);
        cipher.init(Cipher.DECRYPT_MODE, keySpec, ivps);
        return new String(cipher.doFinal(data), StandardCharsets.UTF_8);
    }

    public static byte[] join(byte[] bs1, byte[] bs2) {
        byte[] r = new byte[bs1.length + bs2.length];
        System.arraycopy(bs1, 0, r, 0, bs1.length);
        System.arraycopy(bs2, 0, r, bs1.length, bs2.length);
        return r;
    }
}
