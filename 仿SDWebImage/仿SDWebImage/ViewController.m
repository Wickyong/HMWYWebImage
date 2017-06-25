//
//  ViewController.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "ViewController.h"
//#import "DownOperation.h"
#import "AppModel.h"
#import "AFNetworking.h"
#import "YYModel.h"
//#import "HMWYWebImageManager.h"
#import "UIImageView+WebImage.h"

@interface ViewController ()

//模型数组
@property(nonatomic,strong) NSArray *appList;

@property(nonatomic,strong) NSOperationQueue *queue;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

//操作缓存池
@property(nonatomic,strong)NSMutableDictionary *opCache;

//记录上一次的图片地址
@property(nonatomic,copy)NSString *lastURLString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [NSOperationQueue new];

    self.opCache = [[NSMutableDictionary alloc]init];

    [self loadData];
}

#pragma mark
#pragma mark - 测试downOperation,点击屏幕随机获取图片地址,交给downOperation去下载

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    int random = arc4random_uniform((int32_t)self.appList.count);

    AppModel *model = self.appList[random];

#pragma mark - 分类接管下载
    [self.imgView hmwy_setWithURLString:model.icon];


}

- (void)loadData
{
    NSString *URLString = @"https://raw.githubusercontent.com/Wickyong/DataFiles/master/apps.json";

    [[AFHTTPSessionManager manager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *dictArr = responseObject;

        self.appList = [NSArray yy_modelArrayWithClass:[AppModel class] json:dictArr];

        NSLog(@"%@",self.appList );
        NSLog(@"成功获取数据!");


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
