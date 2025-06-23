package com.toad.devkit.pro.mockapi.ApiService.entity.API;

/**
 * API 暗号化配置
 */
public class APICipher {

    /**
     * 加密模式
     */
    public String mode = "Base64";
    /**
     * 字符集 默认使用 UTF-8
     */
    public String charsetName = "UTF-8";
    /**
     * AES 密钥
     */
    public String aesKey;
    /**
     * AES 偏移量
     */
    public String aesIV;
    /**
     * RSA 密钥
     */
    public String rsaKey;
    /**
     * 编码格式 默认 1
     */
    public int codecType = 1;

}
