//
//  AssetInfo.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetKeyInfo.h"

@interface AssetInfo : NSObject
@property (nonatomic, strong) AssetKeyInfo *key;
@property (nonatomic, assign) int64_t amount;
@end
