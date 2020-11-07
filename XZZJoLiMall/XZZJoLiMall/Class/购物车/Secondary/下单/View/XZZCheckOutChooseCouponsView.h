//
//  XZZCheckOutChooseCouponsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/5.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZCheckOutChooseCouponsView : UIView

/**
 * 展示优惠券code
 */
@property (nonatomic, strong)UILabel * couponCodeLabel;

/**
 * 优惠券code
 */
@property (nonatomic, strong)NSString * couponCode;

/**
 * 选择优惠券
 */
@property (nonatomic, strong)GeneralBlock chooseCouponBlock;

@end

NS_ASSUME_NONNULL_END
