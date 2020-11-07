//
//  XZZCouponsListTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCouponsInfor.h"

//#import "XZZCouponsInforView.h"

typedef void (^GetCouponBlock)(XZZCouponsInfor * couponsInfor);


NS_ASSUME_NONNULL_BEGIN

@interface XZZCouponsListTableViewCell : UITableViewCell


/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCouponsInfor * couponsInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GetCouponBlock getCouponBlock;

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
