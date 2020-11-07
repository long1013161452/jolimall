//
//  XZZActivitiesGoodsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZHomeTemplateView.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZZActivitiesGoodsView : XZZHomeTemplateView

/**
 * 商品信息
 */
@property (nonatomic, strong)NSArray * goodsArray;

@end

/***  广告的商品展示 */
@interface XZZAdvertisingGoodsView : UIView

/**
 * 商品信息
 */
@property (nonatomic, strong)id goods;


@end

NS_ASSUME_NONNULL_END
