//
//  BlockNumber.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockNumber.h"
#import "YYModel.h"

@implementation BlockNumber
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"blockNumber" : @"seq"};
}
@end
