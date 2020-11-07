//
//  XZZCouponsOrderListTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/21.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCouponsInfor.h"

//#import "XZZCouponsInforView.h"


NS_ASSUME_NONNULL_BEGIN

/***  优惠券可用的cell */
@interface XZZCouponsOrderListTableViewCell : UITableViewCell

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCouponsInfor * couponsInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)void (^getCouponBlock)(XZZCouponsInfor * couponsInfor);

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL couponAvailable;

/**
 *  是否来源自商品详情
 */
@property (nonatomic, assign)BOOL isGoodsDetauls;

- (void)setButtonTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
