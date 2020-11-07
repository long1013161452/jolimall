//
//  XZZRequestCalculatePrice.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/1.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XZZSkuNum;

/***  计算价格 */
@interface XZZRequestCalculatePrice : NSObject


/**
 * 优惠码
 */
@property (nonatomic, strong)NSString * couponCode;

/**
 * 购物车sku
 */
@property (nonatomic, strong)NSArray<XZZSkuNum *> * skus;

@end


@interface XZZSkuNum : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * skuId;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsCode;
/**
 * <#expression#>
 */
@property (nonatomic, assign)NSInteger skuNum;

/**
 * <#expression#>
 */
@property (nonatomic, assign)NSInteger isGiftGoods;

@end






NS_ASSUME_NONNULL_END
