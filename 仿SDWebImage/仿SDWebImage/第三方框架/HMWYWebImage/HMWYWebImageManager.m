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

@property(nonatomic,strong)NSMutableDictionary *imgMemCache;

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

        self.imgMemCache = [NSMutableDictionary new];

#pragma mark - 注册内存警告通知
        [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

    }
    return self;
}

//清理缓存
- (void)clearMemory
{
    [self.imgMemCache removeAllObjects];
}


/**
 单例下载的主方法

 @param URLString 图片地址
 @param completionBlock 下载完成的回调
 */
- (void)downOperationWithURLString:(NSString *)URLString completion:(void (^)(UIImage *))completionBlock
{
#pragma mark - 下载图片时,判断是否有缓存(即直接包括了内存和沙盒的缓存)
    if ([self checkCache:URLString]) {
        if (completionBlock != nil) {
            completionBlock([self.imgMemCache objectForKey:URLString]);
            return;
        }
    }

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

        //实现图片的内存缓存
        if (image != nil)
        {
            [self.imgMemCache setObject:image forKey:URLString];
        }

        //图片下载结束后,移除对应的操作
        [self.opCache removeObjectForKey:URLString];
    }];

    [self.opCache setObject:op forKey:URLString ];

    [self.queue addOperation:op];
}

//判断是否有缓存的方法
- (BOOL)checkCache:(NSString *)URLString
{
    //判断是否有内存缓存
    if ([self.imgMemCache objectForKey:URLString]) {
        NSLog(@"从内存中加载...");
        return YES;
    }

    //判断是否有沙盒缓存
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[URLString appendCachePath]];
    if (cacheImage != nil) {
        NSLog(@"从沙盒中加载...");
        [self.imgMemCache setObject:cacheImage forKey:URLString];
        return YES;
    }
    return NO;

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
