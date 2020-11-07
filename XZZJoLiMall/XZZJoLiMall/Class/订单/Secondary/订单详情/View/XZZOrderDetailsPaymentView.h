//
//  XZZOrderDetailsPaymentView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XZZMethodPaymentType) {
    XZZMethodPaymentTypeNone = 1,//普通
    XZZMethodPaymentTypeCard, //只有信用卡
    XZZMethodPaymentTypePayPal, //只有PayPal
    XZZMethodPaymentTypeNOPay//不再进行支付
};

/**
 *  订单再次支付按钮
 */
@interface XZZOrderDetailsPaymentView : UIView

/**
 * 信用卡支付
 */
@property (nonatomic, strong)GeneralBlock cardPay;

/**
 * PayPal支付
 */
@property (nonatomic, strong)GeneralBlock payPalPay;

/**
 * 按钮类型
 */
@property (nonatomic, assign)XZZMethodPaymentType buttonType;


/**
 * 订单详情
 */
@property (nonatomic, strong)XZZOrderDetail * orderDetail;

/**
 * 隐藏按钮
 */
@property (nonatomic, assign)BOOL hideButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * typeArray;

@end

NS_ASSUME_NONNULL_END
