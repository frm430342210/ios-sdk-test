//
//  mnemonic.m
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/11.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import "Mnemonic.h"
#import "Tools.h"
#import "Hash.h"
#import "BUChainKey.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonKeyDerivation.h>

@implementation Mnemonic
+ (NSArray *) generateMnemonicCode: (NSData *)random {
    if ([random length] != 16) {
        return nil;
    }

    NSData *hash = [Hash sha256: random];
    NSMutableArray *checkSumBits = [NSMutableArray arrayWithArray:[Tools dataToBitArray:hash]];
    NSMutableArray *seedBits = [NSMutableArray arrayWithArray:[Tools dataToBitArray: random]];
    for(int i = 0 ; i < (int)seedBits.count / 32 ; i++){
        [seedBits addObject:checkSumBits[i]];
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if ([Tools isEmpty: bundle]) {
        return nil;
    }
    NSString *resourcePath = [bundle pathForResource:@"english" ofType:@"txt"];
    if ([Tools isEmpty: resourcePath]) {
        return nil;
    }
    NSString *fileText = [NSString stringWithContentsOfFile:resourcePath encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [fileText componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray *words = [NSMutableArray arrayWithCapacity:(int)seedBits.count / 11];
    for(int i = 0 ; i < (int)seedBits.count / 11 ; i++) {
        NSUInteger wordNumber = strtol([[[seedBits subarrayWithRange:NSMakeRange(i * 11, 11)] componentsJoinedByString:@""] UTF8String], NULL, 2);
        [words addObject:lines[wordNumber]];
    }
    return [words copy];
}

+ (NSArray *) generatePrivateKeys: (NSArray *)mnemonicCodes : (NSArray *)hdPaths {
    if ([Tools isEmpty: mnemonicCodes] || [mnemonicCodes count] % 4 != 0 || [mnemonicCodes count] == 0) {
        return nil;
    }
    
    NSString *mnemonicStr = [mnemonicCodes componentsJoinedByString:@" "];
    NSData *data = [mnemonicStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *dataString = [[NSString alloc] initWithData: data encoding: NSASCIIStringEncoding];
    NSData *normalized = [dataString dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: NO];
    
    NSString* passwordPhrase = @"";
    NSData *saltData =
    [[@"mnemonic" stringByAppendingString: [[NSString alloc] initWithData:[passwordPhrase dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding]] dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: NO];
    
    NSMutableData *hashKeyData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCKeyDerivationPBKDF(kCCPBKDF2, normalized.bytes, normalized.length, saltData.bytes, saltData.length, kCCPRFHmacAlgSHA512, 2048, hashKeyData.mutableBytes, hashKeyData.length);
    
    NSData *seed = [NSData dataWithData:hashKeyData];
    BUChainKey *buChainKey = [[BUChainKey alloc] initWithSeed: seed];
    NSMutableArray *privateKeys = [NSMutableArray new];
    for (NSString *hdPath in hdPaths) {
        BUChainKey *buChainKeyIndex = [buChainKey derivedKeychainWithPath:hdPath];
        NSString *privateKey = [buChainKeyIndex getEncPrivateKey];
        [privateKeys addObject: privateKey];
    }
    
    return [privateKeys copy];
}

@end
