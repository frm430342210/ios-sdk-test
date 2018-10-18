//
//  BlockRewardJsonResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockRewardJsonResponse.h"
#import "YYModel.h"

@implementation BlockRewardJsonResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockRewardJsonResult.class};
}
@end
