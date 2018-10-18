//
//  KeyStoreValue.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/18.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScryptParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeyStoreValue : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *aesctrIv;
@property (nonatomic, copy) NSString *aes128ctrIv;
@property (nonatomic, copy) NSString *cypherText;
@property (nonatomic, strong) ScryptParams *scryptParams;
@property (nonatomic, assign) int32_t version;
@end

NS_ASSUME_NONNULL_END
