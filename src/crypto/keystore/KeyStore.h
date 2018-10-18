//
//  KeyStore.h
//  sdk-ios
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStoreValue.h"

@interface KeyStore : NSObject

//If new_private_key is empty, create a new private key.
+ (KeyStoreValue *) generateKeyStore : (NSData *) password : (NSString *) new_priv_key : (int32_t) version;

+ (KeyStoreValue *) generateKeyStoreWithParams : (NSData *) password : (NSString *) new_priv_key : (uint64_t) n : (uint32_t) r : (uint32_t) p : (int32_t) version;

+ (NSString *) decipherKeyStore : (KeyStoreValue *) key_store : (NSData *) password;

@end

