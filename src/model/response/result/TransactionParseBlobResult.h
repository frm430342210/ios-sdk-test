//
//  TransactionParseBlobResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationFormat.h"

@interface TransactionParseBlobResult : NSObject
@property (nonatomic, copy) NSString *sourceAddress;
@property (nonatomic, assign) int64_t feeLimit;
@property (nonatomic, assign) int64_t gasPrice;
@property (nonatomic, assign) int64_t nonce;
@property (nonatomic, strong) NSArray *operations;
@end
