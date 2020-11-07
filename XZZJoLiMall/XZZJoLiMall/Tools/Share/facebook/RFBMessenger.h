//
//  RFBMessenger.h
//  MaiDianCeShi
//
//  Created by 龙少 on 2018/10/31.
//  Copyright © 2018年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RShare.h"


@interface RFBMessenger : RShare

+ (instancetype)shared;

/***  判断是否安装 */
- (BOOL)whetherInstall;

- (void)connect:(RConfiguration)c;


- (void)shareTitle:(NSString *)title url:(NSString *)url elementTitle:(NSString *)elementTitle subtitle:(NSString *)subtitle imageUrl:(NSString *)imageUrl completion:(RShareCompletion)share;

@end


