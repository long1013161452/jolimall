//
//  XZZRegisteredView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MYSINGUP)(void);

typedef void(^ViewRegistrationTerms)(void);

/**
 *  注册
 */
@interface XZZRegisteredView : UIView

/**
 * 邮箱输入框
 */
@property (nonatomic, strong)UITextField * emailTextField;

/**
 * 密码输入框
 */
@property (nonatomic, strong)UITextField * passwordTextField;

/**
 * 重复密码输入框
 */
@property (nonatomic, strong)UITextField * twoPasswordTextField;

/**
 * 协议选择状态
 */
@property (nonatomic, assign)BOOL selectionState;

/**
 * 注册回调
 */
@property (nonatomic, strong)GeneralBlock singUp;

/**
 * 查看协议
 */
@property (nonatomic, strong)GeneralBlock viewRegistrationTerms;

@end

NS_ASSUME_NONNULL_END
