//
//  XZZRecommendedListShowGoods.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/16.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  推荐商品展示
 */
@interface XZZRecommendedListShowGoods : UIView

/**
 * 商品信息
 */
@property (nonatomic, weak)id  goods;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * 购物车按钮
 */
@property (nonatomic, assign)BOOL cartHidden;
/**
 * 收藏按钮
 */
@property (nonatomic, assign)BOOL collectionHidden;

@end

NS_ASSUME_NONNULL_END
