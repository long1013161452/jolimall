//
//  XZZOrderDetailsCountdownView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  倒计时  订单
 */
@interface XZZOrderDetailsCountdownView : UIView

/**
 * 订单创建时间
 */
@property (nonatomic, strong)NSString * currentTime;
/**
 * 订单取消时间
 */
@property (nonatomic, strong)NSString * orderCancelTime;

@end

NS_ASSUME_NONNULL_END
