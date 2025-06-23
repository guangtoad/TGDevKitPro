package com.toad.devkit.pro.mockapi.ApiService.entity.API;

public class APIConfigEntity {
    /**
     * 开启格式校验
     */
    public boolean schemasVerificationEnabled = false;
    public APISchemasSetting schemasSetting = null;

    public String encoding = "utf-8";
    boolean verificationSchemas;
    String schemas;
    String schemasType;
    /**
     * 等待时间
     */
    public long waitingTime;
    public boolean eq;
    /**
     * 开启动态读取
     */
    public boolean dynamicResponseEnabled;
    public APIDynamicResponseSetting dynamicResponseSetting;
    /**
     * 开启加密
     */
    public boolean encryptionEnabled = false;
    /**
     * 加密设置
     */
    public APICipher encryptionSetting = null;
    /**
     * 开启解密
     */
    public boolean decryptionEnabled = false;
    /**
     * 解码设置
     */
    public APIDecryptionCipher decryptionSetting = null;
}
