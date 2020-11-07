//
//  XZZGoodsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/8.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  展示商品信息    用于列表的
 */
@interface XZZListShowGoodsView : UIView


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
 * cart 小的
 */
@property (nonatomic, assign)BOOL cartSmall;
/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL collectionHidden;

/**
 * 展示商品角标信息
 */
@property (nonatomic, assign)XZZGoodsViewDisplayAngle goodsViewDisplay;


@end

NS_ASSUME_NONNULL_END
