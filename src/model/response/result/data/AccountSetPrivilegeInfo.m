//
//  AccountSetPrivilegeInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountSetPrivilegeInfo.h"
#import "YYModelClass.h"

@implementation AccountSetPrivilegeInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"masterWeight" : @"master_weight",
             @"txThreshold" : @"tx_threshold",
             @"typeThresholds" : @"type_thresholds"};
}
             
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"signers" : [SignerInfo class],
             @"typeThresholds" : [TypeThreshold class]};
}
@end
