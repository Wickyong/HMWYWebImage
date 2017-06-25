//
//  UIImageView+WebImage.h
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/25.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMWYWebImageManager.h"

@interface UIImageView (WebImage)

@property (nonatomic, copy) NSString * lastURLString;

- (void)hmwy_setWithURLString : (NSString *)URLString;

@end
