//
//  SDK.m
//  sdk-ios
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "KeyStore.h"
#import "libscrypt.h"
#import "random.h"
#import "PrivateKey.h"
#import "my_crypto.h"
#import "Tools.h"


@implementation KeyStore
/*
{
"version" : 1,
"scrypt_params" : {"n": 16384, "p": 8, "r" : 1,"salt" :"1234"},
"aes128ctr_iv" : "",
"cypher_text": ""
}
*/

+ (KeyStoreValue *) generateKeyStore : (NSData *) password : (NSString *) newPrivKey : (int32_t) version{
    return [self generateKeyStoreWithParams: password : newPrivKey : 16384 : 8 : 1 : version];
}

+ (KeyStoreValue *) generateKeyStoreWithParams : (NSData *) password : (NSString *) newPrivKey : (uint64_t) n : (uint32_t) r : (uint32_t) p : (int32_t) version {
    //Produce 256 bit random.
    std::string salt;
    utils::GetStrongRandBytes(salt);
    
    std::string aes_iv;
    utils::GetStrongRandBytes(aes_iv);
    aes_iv.resize(16);
    
    std::string dk;
    dk.resize(32);
    libscrypt_scrypt((uint8_t *)password.bytes, password.length, (uint8_t *)salt.c_str(), salt.size(), n, r, p, (uint8_t *)dk.c_str(), dk.size());
    NSLog(@"%@", [Tools dataToHexStr: [NSData dataWithBytes:dk.c_str() length:dk.length()]]);
    
    std::string newPrivateKey;
    std::string address;
    if ([Tools isEmpty: newPrivKey]) {
        PrivateKey priv_key;
        if (!priv_key.IsValid()) {
            return nil;
        }
        newPrivateKey = priv_key.GetEncPrivateKey();
        address = priv_key.GetEncAddress();
    }
    else {
        newPrivateKey = std::string([newPrivKey UTF8String]);
        PrivateKey priv_key;
        if (!priv_key.From(newPrivateKey)) {
            return nil;
        }
        address = priv_key.GetEncAddress();
    }
    
    utils::AesCtr aes((uint8_t *)aes_iv.c_str(), dk);
    
    std::string cyper_text;
    aes.Encrypt(newPrivateKey, cyper_text);
    
    KeyStoreValue *keyStoreValue = [KeyStoreValue new];
    keyStoreValue.version = version;
    keyStoreValue.aesctrIv = [Tools dataToHexStr: [NSData dataWithBytes:aes_iv.c_str() length:aes_iv.length()]];
    keyStoreValue.cypherText = [Tools dataToHexStr: [NSData dataWithBytes:cyper_text.c_str() length:cyper_text.length()]];
    keyStoreValue.address = [NSString stringWithCString : address.c_str() encoding : [NSString defaultCStringEncoding]];
    ScryptParams *scryptParams = [ScryptParams new];
    scryptParams.n = n;
    scryptParams.p = p;
    scryptParams.r = r;
    scryptParams.salt = [Tools dataToHexStr: [NSData dataWithBytes:salt.c_str() length:salt.length()]];
    keyStoreValue.scryptParams = scryptParams;
    
    return keyStoreValue;
}

+ (NSString *) decipherKeyStore : (KeyStoreValue *) keyStore : (NSData *) password {

    int32_t version = keyStore.version;
    ScryptParams *scryptParams = keyStore.scryptParams;
    uint64_t n = scryptParams.n;
    uint32_t r = scryptParams.r;
    uint32_t p = scryptParams.p;
    NSData *saltData = [Tools hexStrToData: scryptParams.salt];
    std::string salt((const char *)saltData.bytes, saltData.length);

    std::string aes_iv;
    int32_t nkeylen = 16;
    if (version == 1) {
        NSData *aesIvData = [Tools hexStrToData: keyStore.aes128ctrIv];
        aes_iv = std::string((const char *)aesIvData.bytes, aesIvData.length);//utils::String::HexStringToBin(key_store["aes128ctr_iv"].asString());
        nkeylen = 16;
    }
    else if (version == 2) {
        NSData *aesIvData = [Tools hexStrToData: keyStore.aesctrIv];
        aes_iv = std::string((const char *)aesIvData.bytes, aesIvData.length);
        nkeylen = 32;
    }
    NSData *cypherTextData = [Tools hexStrToData: keyStore.cypherText];
    std::string cypher_text((const char *)cypherTextData.bytes, cypherTextData.length);
    std::string address([keyStore.address UTF8String]);

    if (aes_iv.size() != 16){
        return nil;
    }

    std::string dk;
    dk.resize(32);
    int32_t ret = libscrypt_scrypt((uint8_t *)password.bytes, password.length, (uint8_t *)salt.c_str(), salt.size(), n, r, p, (uint8_t *)dk.c_str(), dk.size());
    if (ret != 0 ){
        return nil;
    }

    dk.resize(nkeylen);
    utils::AesCtr aes((uint8_t *)aes_iv.c_str(), dk);
    std::string priv_key_de;
    aes.Encrypt(cypher_text, priv_key_de);
    
    PrivateKey key(priv_key_de);
    if (!key.IsValid()){
        return nil;
    }

    if (key.GetEncAddress() != address ){
        return nil;
    }

    NSString *priv_key = [NSString stringWithCString : priv_key_de.c_str() encoding : [NSString defaultCStringEncoding]];
    return priv_key;
}
@end
