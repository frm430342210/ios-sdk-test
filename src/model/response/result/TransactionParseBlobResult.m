//
//  TransactionParseBlobResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionParseBlobResult.h"
#import "YYModel.h"

@implementation TransactionParseBlobResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"sourceAddress" : @"source_address",
             @"feeLimit" : @"fee_limit",
             @"gasPrice" : @"gas_price"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"operations" : [OperationFormat class]};
}
@end
