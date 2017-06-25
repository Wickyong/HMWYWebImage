//
//  NSString+Path.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/25.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendCachePath
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;

    NSString *name = [self lastPathComponent];

    //用cachePath和name拼接cache文件夹路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:name];

    return filePath;
}

@end
