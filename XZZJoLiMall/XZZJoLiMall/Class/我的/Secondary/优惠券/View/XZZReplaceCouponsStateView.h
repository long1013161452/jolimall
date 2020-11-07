//
//  XZZReplaceCouponsStateView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XZZCouponState) {
    XZZCouponStateUnused = 1,
    XZZCouponStateAlreadyUsed = 2,
    XZZCouponStateExpired = 3,
};

typedef void(^ChooseCouponsState)(XZZCouponState state);

NS_ASSUME_NONNULL_BEGIN

@interface XZZReplaceCouponsStateView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)ChooseCouponsState chooseCouponsState;


@end

NS_ASSUME_NONNULL_END
