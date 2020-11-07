//
//  XZZGetCouponsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCouponsListTableViewCell.h"


NS_ASSUME_NONNULL_BEGIN

/**
 *  领取优惠券
 */
@interface XZZGetCouponsView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * dataArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GetCouponBlock getCouponBlock;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;

@end

NS_ASSUME_NONNULL_END
