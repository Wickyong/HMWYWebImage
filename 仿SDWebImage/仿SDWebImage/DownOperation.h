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


/**
 创建操作和下载图片的主方法

 @param URLString 图片地址
 @param finishedBlock 下载完成的回调
 @return 自定义的下载操作
 */
+(instancetype)downOperationWithURLString:(NSString *)URLString finishes:(void(^)(UIImage *image)) finishedBlock;
@end
