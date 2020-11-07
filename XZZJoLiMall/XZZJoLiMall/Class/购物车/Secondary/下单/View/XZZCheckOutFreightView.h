//
//  XZZCheckOutFreightView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/1.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZOrderPostageInfor.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  运费   单个
 */
@interface XZZCheckOutFreightView : UIView


/**
 * 选中
 */
@property (nonatomic, assign)BOOL selected;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * freightPriceLabel;

/**
 * 运输时长
 */
@property (nonatomic, strong)UILabel * dateLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZOrderPostageInfor * postageInfor;

- (void)calculateFreight:(CGFloat)price;

@end

NS_ASSUME_NONNULL_END
