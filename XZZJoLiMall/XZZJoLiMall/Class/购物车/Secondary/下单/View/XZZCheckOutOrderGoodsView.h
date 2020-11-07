//
//  XZZCheckOutOrderGoodsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZOrderSku.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  展示订单商品
 */
@interface XZZCheckOutOrderGoodsView : UIView


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
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
