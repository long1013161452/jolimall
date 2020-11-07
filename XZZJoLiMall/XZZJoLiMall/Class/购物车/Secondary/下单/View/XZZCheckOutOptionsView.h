//
//  XZZCheckOutOptionsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZOrderPostageInfor.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^SelectFreight)(XZZOrderPostageInfor * postageInfor);


/**
 *  展示运费信息
 */
@interface XZZCheckOutOptionsView : UIView


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
@property (nonatomic, strong)SelectFreight selectFreight;

- (void)addView;

@end

NS_ASSUME_NONNULL_END
