//
//  XZZCheckOutPromoCodeView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  输入优惠码
 */
@interface XZZCheckOutPromoCodeView : UIView


/**
 * 是否展示s提示优惠券信息  YES为展示  NO为隐藏
 */
@property (nonatomic, assign)BOOL hiddenCouponTip;

/**
 * 输入优惠券信息
 */
@property (nonatomic, strong)UITextField * textField;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock calculatePrice;


@end

NS_ASSUME_NONNULL_END
