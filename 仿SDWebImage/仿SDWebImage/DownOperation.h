//
//  DownOperation.h
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownOperation : NSOperation

//@property (nonatomic, copy) NSString* URLString;
//
//@property (nonatomic, copy) void(^finishedBlock)(UIImage *image);

+(instancetype)downOperationWithURLString:(NSString *)URLString finishes:(void(^)(UIImage *image)) finishedBlock;
@end
