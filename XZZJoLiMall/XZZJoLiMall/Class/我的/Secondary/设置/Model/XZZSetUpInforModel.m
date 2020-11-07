//
//  XZZSetUpInforModel.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/5.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSetUpInforModel.h"

@implementation XZZALLSetUpInfor

static XZZALLSetUpInfor * allSetUpInfor = nil;

+ (XZZALLSetUpInfor *)shareAllSetUpInfor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allSetUpInfor = [self allocInit];
    });
    return allSetUpInfor;
}

@end

@implementation XZZSetUpInforModel

@end
