//
//  HMWYWebImageManager.h
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownOperation.h"

@interface HMWYWebImageManager : NSObject

+(instancetype)sharedManager;

- (void)downOperationWithURLString:(NSString *)URLString completion:(void(^)(UIImage *image))completionBlock;

- (void)cancelLastOperation:(NSString *)lastURLString;
@end
