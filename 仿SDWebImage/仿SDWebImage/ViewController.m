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
#import "HMWYWebImageManager.h"

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

    //在建立下载操作前,判断连续传入的图片地址是否一样,若不一样,则取消掉前一个下载操作
    if (![model.icon isEqualToString:_lastURLString] && _lastURLString != nil) {

//        //取出上一个图片的下载操作,调用cancel方法取消掉
//        DownOperation *lastOp = [self.opCache objectForKey:_lastURLString];
//
//        [lastOp cancel];
//
//        [self.opCache removeObjectForKey:_lastURLString];

        //单例接管取消操作,代替以上注释代码
        [[HMWYWebImageManager sharedManager] cancelLastOperation:_lastURLString];
    }

    //记录上次图片地址
    _lastURLString = model.icon;

//    DownOperation *op = [DownOperation downOperationWithURLString:model.icon finishes:^(UIImage *image) {
//        self.imgView.image = image;
//
//        [self.opCache removeObjectForKey:model.icon];
//    }];
//
//    [self.opCache setObject:op forKey:model.icon ];
//
//    [self.queue addOperation:op];
//
    //单例接管下载操作 ,代替以上注释代码
    [[HMWYWebImageManager sharedManager] downOperationWithURLString:model.icon completion:^(UIImage *image) {

        self.imgView.image = image;
    }];
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
