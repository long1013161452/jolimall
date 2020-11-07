//
//  XZZCheckOutGoodsAndPriceInforView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZOrderPriceInfor.h"


NS_ASSUME_NONNULL_BEGIN

/**
 *  展示商品与价格信息
 */
@interface XZZCheckOutGoodsAndPriceInforView : UIView

/**
 * 商品信息
 */
@property (nonatomic, strong)NSArray * cartInforArray;

/**
 * 费用信息
 */
@property (nonatomic, strong)XZZOrderPriceInfor * priceInfor;

/**
 * 是否展示邮费
 */
@property (nonatomic, assign)BOOL isShowShipping;
/**
 * 是否隐藏优惠券
 */
@property (nonatomic, assign)BOOL isHiddenCoupon;
/**
 * 选择优惠券信息
 */
@property (nonatomic, strong)GeneralBlock chooseCouponsInfor;

/**
 * 刷新
 */
@property (nonatomic, strong)GeneralBlock reloadView;

- (void)shutDownProductInformation;

@end

NS_ASSUME_NONNULL_END
