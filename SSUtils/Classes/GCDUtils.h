//
//  GCDUtils.h
//  SSDatabaseDemo
//
//  Created by su on 16/7/1.
//  Copyright © 2016年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDUtils : NSObject

+ (void) background:(void(^)(void))task callback:(void(^)(void))callback;

@end
