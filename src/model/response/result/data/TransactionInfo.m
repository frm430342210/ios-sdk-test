//
//  TransactionInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionInfo.h"
#import "YYModel.h"

@implementation TransactionInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"sourceAddress" : @"source_address",
             @"feeLimit" : @"fee_limit",
             @"gasPrice" : @"gas_price"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"operations" : [OperationInfo class]};
}
@end
