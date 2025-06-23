import Foundation
import CommonCrypto
import Security

class CryptoUtil {
    
    // MARK: - Base64
    
    /// Base64编码
    static func base64Encode(_ string: String) -> String? {
        guard let data = string.data(using: .utf8) else { return nil }
        return data.base64EncodedString()
    }
    
    /// Base64解码
    static func base64Decode(_ string: String) -> String? {
        guard let data = Data(base64Encoded: string) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    // MARK: - AES
    
    /// 生成AES密钥
    static func generateAESKey() -> Data? {
        var keyData = Data(count: kCCKeySizeAES128)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, kCCKeySizeAES128, $0.baseAddress!)
        }
        return result == errSecSuccess ? keyData : nil
    }
    
    /// AES加密数据
    static func aesEncryptData(_ data: Data, key: Data) -> Data? {
//        let keyLength = kCCKeySizeAES128
//        let iv = Array<UInt8>(repeating: 0, count: kCCBlockSizeAES128)
//        
//        var cryptData = Data(count: data.count + kCCBlockSizeAES128)
//        var numBytesEncrypted: size_t = 0
//        
//        let cryptStatus = cryptData.withUnsafeMutableBytes { cryptBytes in
//            data.withUnsafeBytes { dataBytes in
//                key.withUnsafeBytes { keyBytes in
//                    CCCrypt(CCOperation(kCCEncrypt),
//                            CCAlgorithm(kCCAlgorithmAES),
//                            CCOptions(kCCOptionPKCS7Padding),
//                            keyBytes.baseAddress, keyLength,
//                            iv,
//                            dataBytes.baseAddress, data.count,
//                            cryptBytes.baseAddress, cryptData.count,
//                            &numBytesEncrypted)
//                }
//            }
//        }
//        
//        if cryptStatus == kCCSuccess {
//            cryptData.count = numBytesEncrypted
//            return cryptData
//        }
        return nil
    }
    
    /// AES解密数据
    static func aesDecryptData(_ data: Data, key: Data) -> Data? {
//        let keyLength = kCCKeySizeAES128
//        let iv = Array<UInt8>(repeating: 0, count: kCCBlockSizeAES128)
//        
//        var decryptData = Data(count: data.count + kCCBlockSizeAES128)
//        var numBytesDecrypted: size_t = 0
//        
//        let cryptStatus = decryptData.withUnsafeMutableBytes { decryptBytes in
//            data.withUnsafeBytes { dataBytes in
//                key.withUnsafeBytes { keyBytes in
//                    CCCrypt(CCOperation(kCCDecrypt),
//                            CCAlgorithm(kCCAlgorithmAES),
//                            CCOptions(kCCOptionPKCS7Padding),
//                            keyBytes.baseAddress, keyLength,
//                            iv,
//                            dataBytes.baseAddress, data.count,
//                            decryptBytes.baseAddress, decryptData.count,
//                            &numBytesDecrypted)
//                }
//            }
//        }
//        
//        if cryptStatus == kCCSuccess {
//            decryptData.count = numBytesDecrypted
//            return decryptData
//        }
        return nil
    }
    
    /// AES加密字符串
    static func aesEncrypt(_ string: String, key: String) -> String? {
        guard let keyData = key.data(using: .utf8) else { return nil }
        guard let data = string.data(using: .utf8) else { return nil }
        guard let encryptedData = aesEncryptData(data, key: keyData) else { return nil }
        return base64Encode(encryptedData.base64EncodedString())
    }
    
    /// AES解密字符串
    static func aesDecrypt(_ string: String, key: String) -> String? {
        guard let keyData = key.data(using: .utf8) else { return nil }
        guard let data = Data(base64Encoded: string) else { return nil }
        guard let decryptedData = aesDecryptData(data, key: keyData) else { return nil }
        return String(data: decryptedData, encoding: .utf8)
    }
    
    // MARK: - RSA
    
    /// RSA加密
    static func rsaEncrypt(_ string: String, publicKey: String) -> String? {
        guard let publicKeyData = Data(base64Encoded: publicKey) else { return nil }
        guard let data = string.data(using: .utf8) else { return nil }
        
        var attributes: CFDictionary {
            return [kSecAttrKeyType: kSecAttrKeyTypeRSA,
                    kSecAttrKeyClass: kSecAttrKeyClassPublic] as CFDictionary
        }
        
        guard let secKey = SecKeyCreateWithData(publicKeyData as CFData, attributes, nil) else { return nil }
        
        var error: Unmanaged<CFError>?
        guard let encryptedData = SecKeyCreateEncryptedData(secKey,
                                                           .rsaEncryptionPKCS1,
                                                           data as CFData,
                                                           &error) as Data? else {
            return nil
        }
        
        return encryptedData.base64EncodedString()
    }
    
    /// RSA解密
    static func rsaDecrypt(_ string: String, privateKey: String) -> String? {
        guard let privateKeyData = Data(base64Encoded: privateKey) else { return nil }
        guard let data = Data(base64Encoded: string) else { return nil }
        
        var attributes: CFDictionary {
            return [kSecAttrKeyType: kSecAttrKeyTypeRSA,
                    kSecAttrKeyClass: kSecAttrKeyClassPrivate] as CFDictionary
        }
        
        guard let secKey = SecKeyCreateWithData(privateKeyData as CFData, attributes, nil) else { return nil }
        
        var error: Unmanaged<CFError>?
        guard let decryptedData = SecKeyCreateDecryptedData(secKey,
                                                           .rsaEncryptionPKCS1,
                                                           data as CFData,
                                                           &error) as Data? else {
            return nil
        }
        
        return String(data: decryptedData, encoding: .utf8)
    }
    
    
    // MARK: - SHA256
    
    /// SHA256哈希
    static func sha256(_ string: String) -> String? {
        guard let data = string.data(using: .utf8) else { return nil }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_SHA256($0.baseAddress, CC_LONG(data.count), &digest)
        }
        
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
