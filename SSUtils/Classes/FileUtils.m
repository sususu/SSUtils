//
//  FileUtils.m
//  SSDatabaseDemo
//
//  Created by su on 16/7/1.
//  Copyright © 2016年 SS. All rights reserved.
//

#import "FileUtils.h"
#import "Logger.h"

@implementation FileUtils

+ (CGFloat) sizeOfDisk
{
    CGFloat size = 0.0f;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error)
    {
        SSLogInfo(@"error:%@", error.localizedDescription);
    }
    else
    {
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue] / 1024 / 1024;
    }
    return size;
}

+ (CGFloat) freeSizeOfDisk
{
    CGFloat size = 0.0f;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error)
    {
        SSLogInfo(@"error: %@", error.localizedDescription);
    }
    else
    {
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue] / 1024 / 1024;
    }
    return size;
}

+ (long long) fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        return 0;
    }
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}


@end
