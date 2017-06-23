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


/**
 单例下载的主方法

 @param URLString 图片地址
 @param completionBlock 下载完成的回调
 */
- (void)downOperationWithURLString:(NSString *)URLString completion:(void (^)(UIImage *))completionBlock
{
    //在建立下载操作前,判断要建立的操作是否存在,如果存在,则不再建立重复的下载操作
    if ([self.opCache objectForKey:URLString] != nil) {
        return;
    }

    //获取随机图片的地址,交由downOperation去下载
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

- (void)cancelLastOperation:(NSString *)lastURLString
{
    //取出上一个图片的下载操作
    DownOperation *lastOp = [self.opCache objectForKey:lastURLString];

    //调用cancel方法取消掉
    [lastOp cancel];

    //取消掉的操作从缓存池中移除
    [self.opCache removeObjectForKey:lastURLString];
}

@end
