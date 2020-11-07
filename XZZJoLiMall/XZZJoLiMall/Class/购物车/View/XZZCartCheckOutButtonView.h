//
//  XZZCartCheckOutButtonView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/5.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  购物车按钮
 */
@interface XZZCartCheckOutButtonView : UIView



/**
 * 选中所有的按钮
 */
@property (nonatomic, strong)UIButton * selectAllButton;

/**
 * 总价
 */
@property (nonatomic, strong)UILabel * priceLabel;


/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock selectAll;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock checkOnt;

@end

NS_ASSUME_NONNULL_END
