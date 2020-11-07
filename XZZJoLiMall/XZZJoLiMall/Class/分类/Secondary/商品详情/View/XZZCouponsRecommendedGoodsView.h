//
//  XZZCouponsRecommendedGoodsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/12.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 优惠券 推荐商品*/
@interface XZZCouponsRecommendedGoodsView : UIView


/**
 * 推荐商品
 */
@property (nonatomic, strong)NSArray * goodsList;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock checkCoupons;

/**
 * <#expression#>
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * prompt;


@end

NS_ASSUME_NONNULL_END
