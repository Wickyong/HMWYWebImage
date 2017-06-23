//
//  DownOperation.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "DownOperation.h"

@interface DownOperation ()

@property (nonatomic, copy) NSString* URLString;

@property (nonatomic, copy) void(^finishedBlock)(UIImage *image);

@end

@implementation DownOperation

+(instancetype)downOperationWithURLString:(NSString *)URLString finishes:(void (^)(UIImage *))finishedBlock
{
    DownOperation *op = [DownOperation new];

    op.URLString = URLString;

    op.finishedBlock = finishedBlock;

    return op;

}
-(void)main
{
    NSLog(@"传入==%@",self.URLString);

    NSURL *url = [NSURL URLWithString:self.URLString];

    NSData *data = [NSData dataWithContentsOfURL:url];

    UIImage *image = [UIImage imageWithData:data];

    [NSThread sleepForTimeInterval:1.0];

    //判断操作执行的过程中拦截到的操作是否被取消了
    if (self.isCancelled == YES) {
        NSLog(@"取消== %@",self.URLString);
        return;
    }

    if (self.finishedBlock != nil) {
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{

            NSLog(@"完成== %@",self.URLString);

            self.finishedBlock(image);
        }];
    }
}

@end
