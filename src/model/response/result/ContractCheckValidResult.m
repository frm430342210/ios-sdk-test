//
//  ContractCheckValidResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCheckValidResult.h"
#import "YYModelClass.h"

@implementation ContractCheckValidResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"isValid" : @"is_valid"};
}
@end
