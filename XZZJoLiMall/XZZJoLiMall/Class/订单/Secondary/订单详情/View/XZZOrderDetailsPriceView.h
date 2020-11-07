//
//  XZZOrderDetailsPriceView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  订单详情   支付信息
 */
@interface XZZOrderDetailsPriceView : UIView

/**
 * 订单详情
 */
@property (nonatomic, strong)XZZOrderDetail * orderDetail;

/**
 * 隐藏按钮
 */
@property (nonatomic, assign)BOOL hideButton;

/**
 * 支付
 */
@property (nonatomic, strong)GeneralBlock payNow;

@end

NS_ASSUME_NONNULL_END
