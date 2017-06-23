//
//  ViewController.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "ViewController.h"
#import "DownOperation.h"
#import "AppModel.h"
#import "AFNetworking.h"
#import "YYModel.h"

@interface ViewController ()

@property(nonatomic,strong) NSArray *appList;

@property(nonatomic,strong) NSOperationQueue *queue;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [NSOperationQueue new];

    [self loadData];


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    int random = arc4random_uniform((int32_t)self.appList.count);

    AppModel *model = self.appList[random];

    DownOperation *op = [DownOperation downOperationWithURLString:model.icon finishes:^(UIImage *image) {
        self.imgView.image = image;
    }];

    [self.queue addOperation:op];
}

- (void)loadData
{
    NSString *URLString = @"https://raw.githubusercontent.com/Wickyong/DataFiles/master/apps.json";

    [[AFHTTPSessionManager manager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *dictArr = responseObject;

        self.appList = [NSArray yy_modelArrayWithClass:[AppModel class] json:dictArr];

        NSLog(@"%@",self.appList );


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
