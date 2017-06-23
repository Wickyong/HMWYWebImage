//
//  DownOperation.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "DownOperation.h"

@interface DownOperation ()


/**
 下载图片,需要
 1.图片的地址 
 2.图片下载完成的回调代码块
 */


@property (nonatomic, copy) NSString* URLString;

//接收外界传入的回调的代码块
@property (nonatomic, copy) void(^finishedBlock)(UIImage *image);

@end

@implementation DownOperation

+(instancetype)downOperationWithURLString:(NSString *)URLString finishes:(void (^)(UIImage *))finishedBlock
{
    DownOperation *op = [DownOperation new];

    //记录全局的图片地址
    op.URLString = URLString;

    //记录全局的回调代码块
    op.finishedBlock = finishedBlock;

    return op;

}

#pragma mark - 操作的入口方法,队列调用操作执行时先经过start方法的过滤,会进入该方法,默认是子线程异步执行的(队列调度操作执行后,才开始执行main方法)

-(void)main
{
    NSLog(@"传入==%@",self.URLString);

    NSURL *url = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];

    //模拟网络延迟
    [NSThread sleepForTimeInterval:1.0];

    //判断操作执行的过程中拦截到的操作是否被取消了
    if (self.isCancelled == YES) {
        NSLog(@"取消== %@",self.URLString);
        return;
    }

    //图片下载结束时,需要调用外界传入的回调代码块来把图片回调给外界
    if (self.finishedBlock != nil) {
        //回到主线程回调代码块:外界的代码块会默认在主线程执行(在哪个线程调用代理方法和发送通知,就在哪个线程使用代理方法和通知方法,类似于Block的回调)
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{

            NSLog(@"完成== %@",self.URLString);
            //把拿到的图片回调给单例
            self.finishedBlock(image);
        }];
    }
}

@end
