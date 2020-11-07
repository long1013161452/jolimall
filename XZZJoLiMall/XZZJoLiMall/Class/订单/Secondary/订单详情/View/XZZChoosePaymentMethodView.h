//
//  XZZChoosePaymentMethodView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZChoosePaymentMethodView : UIView



/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * paymentTypeArr;

/**
 * 信用卡支付
 */
@property (nonatomic, strong)GeneralBlock cardPay;

/**
 * PayPal支付
 */
@property (nonatomic, strong)GeneralBlock payPalPay;

- (void)addSuperviewView;

- (void)removeView;

@end

NS_ASSUME_NONNULL_END
