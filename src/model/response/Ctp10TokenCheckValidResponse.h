//
//  Ctp10TokenCheckValidResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenCheckValidResult.h"

@interface Ctp10TokenCheckValidResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenCheckValidResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenCheckValidResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenCheckValidResult *)result;
@end
