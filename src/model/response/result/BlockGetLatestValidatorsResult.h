//
//  BlockGetLatestValidatorsResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidatorInfo.h"

@interface BlockGetLatestValidatorsResult : NSObject
@property (nonatomic, strong) NSArray *validators;
@end
