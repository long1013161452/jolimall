//
//  XZZLogInView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  登陆
 */
@interface XZZLogInView : UIView

/**
 * 邮箱输入框
 */
@property (nonatomic, strong)UITextField * emailTextField;

/**
 * 密码输入框
 */
@property (nonatomic, strong)UITextField * passwordTextField;

/**
 * 点击进行登陆
 */
@property (nonatomic, strong)GeneralBlock logIn;

/**
 * 点击修改密码
 */
@property (nonatomic, strong)GeneralBlock changePassword;

@end

NS_ASSUME_NONNULL_END
