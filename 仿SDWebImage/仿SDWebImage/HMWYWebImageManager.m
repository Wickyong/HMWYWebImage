//
//  HMWYWebImageManager.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "HMWYWebImageManager.h"

@interface HMWYWebImageManager ()

@property(nonatomic,strong)NSOperationQueue *queue;

@property(nonatomic,strong) NSMutableDictionary *opCache;

@end

@implementation HMWYWebImageManager

+(instancetype)sharedManager
{
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.queue = [NSOperationQueue new];

        self.opCache = [NSMutableDictionary new];

    }
    return self;
}

- (void)downOperationWithURLString:(NSString *)URLString completion:(void (^)(UIImage *))completionBlock
{
    
    if ([self.opCache objectForKey:URLString] != nil) {
        return;
    }

    DownOperation *op = [DownOperation downOperationWithURLString:URLString finishes:^(UIImage *image) {

        //单例把拿到的image回传给VC
        if (completionBlock != nil) {
            completionBlock(image);
        }

        //图片下载结束后,移除对应的操作
        [self.opCache removeObjectForKey:URLString];
    }];

    [self.opCache setObject:op forKey:URLString ];

    [self.queue addOperation:op];
}

@end
