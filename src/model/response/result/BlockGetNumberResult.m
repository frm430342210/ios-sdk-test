//
//  BlockGetNumberResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetNumberResult.h"
#import "YYModelClass.h"

@implementation BlockGetNumberResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"header" : BlockNumber.class};
}
@end
