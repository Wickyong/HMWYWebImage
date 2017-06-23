//
//  AppModel.m
//  仿SDWebImage
//
//  Created by WangYong on 2017/6/23.
//  Copyright © 2017年 WangYong. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@",self.icon,self.name,self.download];
}
@end
