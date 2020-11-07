//
//  XZZThirdPartyView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ThirdPartyLogin)(void);

typedef void(^ViewPrivacyPolicy)(void);

/**
 *  第三方登陆
 */
@interface XZZThirdPartyView : UIView

/**
 * 点击第三方登陆
 */
@property (nonatomic, strong)GeneralBlock fbThirdPartyLogin;

@property (nonatomic, strong)GeneralBlock appleThirdPartyLogin;

/**
 * 查看隐私条款
 */
@property (nonatomic, strong)GeneralBlock viewPrivacyPolicy;

@end

NS_ASSUME_NONNULL_END
