//
//  FileUtils.h
//  SSDatabaseDemo
//
//  Created by su on 16/7/1.
//  Copyright © 2016年 SS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileUtils : NSObject

/**
 *  获取磁盘总空间大小
 *
 *  @return 单位为 MB
 */
+ (CGFloat) sizeOfDisk;

/**
 *  获取磁空余空间大小
 *
 *  @return 单位为 MB
 */
+ (CGFloat) freeSizeOfDisk;

/**
 *  获取指定路径下的文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 单位为 byte
 */
+ (long long) fileSizeAtPath:(NSString *)filePath;



@end
