//
//  DownOperation.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "DownOperation.h"

@implementation DownOperation

-(void)main
{
    NSLog(@"传入的==%@",self.URLString);

    NSURL *url = [NSURL URLWithString:self.URLString];

    NSData *data = [NSData dataWithContentsOfURL:url];

    UIImage *image = [UIImage imageWithData:data];

    if (self.finishedBlock != nil) {
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.finishedBlock(image);
        }];
    }
}

@end
