//
//  GCDUtils.m
//  SSDatabaseDemo
//
//  Created by su on 16/7/1.
//  Copyright © 2016年 SS. All rights reserved.
//

#import "GCDUtils.h"

@implementation GCDUtils

+ (void) background:(void(^)(void))task callback:(void(^)(void))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (task) {
            task();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback();
            }
        });
    });
}


@end
