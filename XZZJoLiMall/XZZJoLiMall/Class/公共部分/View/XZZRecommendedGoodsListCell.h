//
//  XZZRecommendedGoodsListCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/16.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  推荐商品列表cell
 */
@interface XZZRecommendedGoodsListCell : UITableViewCell


/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;


/**
 *  一排有几个商品
 */
@property (nonatomic, assign)int count;

/**
 * 购物车按钮
 */
@property (nonatomic, assign)BOOL cartHidden;
/**
 * 收藏按钮
 */
@property (nonatomic, assign)BOOL collectionHidden;

/**
 * 商品信息   数组
 */
@property (nonatomic, strong)NSArray * goodsArray;

+ (CGFloat)calculateCellHeight:(int)count;

@end

NS_ASSUME_NONNULL_END
