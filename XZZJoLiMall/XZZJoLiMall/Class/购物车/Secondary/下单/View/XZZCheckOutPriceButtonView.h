//
//  XZZCheckOutPriceButtonView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZOrderPriceInfor.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  展示价格按钮视图
 */
@interface XZZCheckOutPriceButtonView : UIView


/**
 * 订单价格信息
 */
@property (nonatomic, strong)XZZOrderPriceInfor * priceInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock block;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * buttonStr;

@end

NS_ASSUME_NONNULL_END
