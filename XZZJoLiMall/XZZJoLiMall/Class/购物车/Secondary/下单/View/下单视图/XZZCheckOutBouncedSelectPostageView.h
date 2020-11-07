//
//  XZZCheckOutBouncedSelectPostageView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZOrderPostageInfor.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  选择邮费信息 弹框
 */
@interface XZZCheckOutBouncedSelectPostageView : UIView

/**
 * 商品价格
 */
@property (nonatomic, assign)CGFloat goodsPrices;

/**
 * 配送方式
 */
@property (nonatomic, strong)XZZOrderPostageInfor * postageInfor;
/**
 * <#expression#>
 */
@property (nonatomic, weak)UIViewController * VC;
/**
 * <#expression#>
 */
@property (nonatomic, strong)void(^selectFreight)(XZZOrderPostageInfor * postageInfor);

- (void)addView;
/**
 * 加载到父视图
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;

@end

NS_ASSUME_NONNULL_END
