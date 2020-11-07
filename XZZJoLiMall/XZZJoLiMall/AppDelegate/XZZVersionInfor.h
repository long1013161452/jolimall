//
//  XZZVersionInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/4.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZVersionInfor : NSObject

/**
 *  string 更新内容
 */
@property (nonatomic, strong)NSString * content ;

/**
 * integer($int32)2: ios端 1：安卓端
 */
@property (nonatomic, strong)NSString * deviceType;

/**
 *  integer($int32) 1强制更新, 0非强制更新
 */
@property (nonatomic, assign)BOOL isForce ;

/**
 *  string app更新地址
 */
@property (nonatomic, strong)NSString * url ;

/**
 * string app版本号
 */
@property (nonatomic, strong)NSString * version  ;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * title;

@end

NS_ASSUME_NONNULL_END
