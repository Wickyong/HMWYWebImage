//
//  ViewController.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "ViewController.h"
#import "DownOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSOperationQueue *queue = [NSOperationQueue new];

    DownOperation *op = [DownOperation new];

    op.URLString = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";

    [op setFinishedBlock:^(UIImage *image){
        NSLog(@"%@  %@",image,[NSThread currentThread]);
    }];

    [queue addOperation:op];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
