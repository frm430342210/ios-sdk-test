//
//  TransactionParseBlobRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionParseBlobRequest : NSObject {
@private
    NSString *_blob;
}

- (void) setBlob : (NSString *)blob;
- (NSString *) getBlob;
@end
