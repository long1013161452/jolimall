//
//  XZZCouponsGoodsListHeaderView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/13.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SelectCouponGoodsTypeBlock)(NSInteger type);

@interface XZZCouponsGoodsListHeaderView : UIView

/**
 * 优惠券信息
 */
@property (nonatomic, strong)XZZCouponsInfor * couponsInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)SelectCouponGoodsTypeBlock selectCouponGoodsType;


/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock refreshUI;

/**
 * <#expression#>
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
