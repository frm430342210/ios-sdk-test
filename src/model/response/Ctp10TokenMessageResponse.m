//
//  Ctp10TokenMessageResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenMessageResponse.h"
#import "YYModelClass.h"

@implementation Ctp10TokenMessageResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : Ctp10TokenMessageResult.class};
}
@end
