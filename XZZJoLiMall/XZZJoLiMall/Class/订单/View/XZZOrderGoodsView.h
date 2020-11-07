//
//  XZZOrderGoodsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  展示订单商品信息
 */
@interface XZZOrderGoodsView : UIView

/**
 * 商品信息
 */
@property (nonatomic, strong)XZZCartInfor * cartInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZOrderSku * orderSku;


/**
 * 隐藏评论按钮   yes隐藏  no为展示   默认按钮隐藏
 */
@property (nonatomic, assign)BOOL hideCommentButton;

/**
 * 是否是赠送商品   默认是不是推荐商品
 */
@property (nonatomic, assign)BOOL isFreeGoods;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
