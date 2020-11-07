//
//  XZZOrderDetailsStateView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  订单状态g和时间信息
 */
@interface XZZOrderDetailsStateView : UIView

/**
 * 订单状态
 */
@property (nonatomic, assign)int orderState;

/**
 * 订单创建时间
 */
@property (nonatomic, strong)NSString * creationTime;
/**
 * 物流单号
 */
@property (nonatomic, strong)NSString * transportCode;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
