//
//  XZZUserHeadView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZUserHeadView : UIView

/**
 * 登陆按钮
 */
@property (nonatomic, strong)UIButton * logInButton;

/**
 * 邮箱label
 */
@property (nonatomic, strong)UILabel * emailLabel;

/**
 * 设置
 */
@property (nonatomic, strong)GeneralBlock setUp;

/**
 * 登陆回调
 */
@property (nonatomic, strong)GeneralBlock logIn;

/**
 * 订单列表
 */
@property (nonatomic, strong)GeneralBlock orderList;

/**
 * 优惠券列表
 */
@property (nonatomic, strong)GeneralBlock couponsList;

/**
 * 地址列表
 */
@property (nonatomic, strong)GeneralBlock addressList;

/**
 * 查看
 */
@property (nonatomic, strong)GeneralBlock support;


@end

NS_ASSUME_NONNULL_END
