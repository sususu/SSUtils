//
//  StringUtils.h
//  SSDatabaseDemo
//
//  Created by su on 16/7/1.
//  Copyright © 2016年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

/**
 *  获取字符串（或汉字）首字母
 *
 *  @param string 字符串
 *
 *  @return 首字母
 */
+ (NSString *) firstCharacterOfString:(NSString *)string;

+ (BOOL) isEmail:(NSString *)email;

@end
