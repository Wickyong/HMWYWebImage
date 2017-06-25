//
//  UIImageView+WebImage.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/25.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import <objc/runtime.h>

@implementation UIImageView (WebImage)

- (void)setLastURLString:(NSString *)lastURLString
{
    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastURLString
{
    return  objc_getAssociatedObject(self, "key");
}

- (void)hmwy_setWithURLString:(NSString *)URLString
{
    //在建立下载操作前,判断连续传入的图片地址是否一样,若不一样,则取消掉前一个下载操作
    if (![URLString isEqualToString:self.lastURLString] && self.lastURLString != nil) {

        //单例接管取消操作
        [[HMWYWebImageManager sharedManager] cancelLastOperation:self.lastURLString];
    }

    //记录上次图片地址
    self.lastURLString = URLString;

    //单例接管下载操作
    [[HMWYWebImageManager sharedManager] downOperationWithURLString:URLString completion:^(UIImage *image) {

        self.image = image;
    }];
}
@end
