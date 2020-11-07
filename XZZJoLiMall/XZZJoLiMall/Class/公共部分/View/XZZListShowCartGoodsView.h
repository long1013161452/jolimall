//
//  XZZListShowCartGoodsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/9.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  展示商品信息   用于购物车推荐列表的
 */
@interface XZZListShowCartGoodsView : UIView

/**
 * 商品信息
 */
@property (nonatomic, weak)id  goods;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL cartHidden;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL collectionHidden;
@end

NS_ASSUME_NONNULL_END
