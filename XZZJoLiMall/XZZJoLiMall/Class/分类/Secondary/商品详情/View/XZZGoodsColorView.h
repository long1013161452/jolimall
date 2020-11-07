//
//  XZZGoodsColorView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ChooseColor)(XZZColor * color);

@interface XZZGoodsColorView : UIView

/**
 * 商品详情
 */
@property (nonatomic, strong)XZZGoodsDetails * goods;

/**
 * <#expression#>
 */
@property (nonatomic, strong)ChooseColor chooseColor;

/**
 * 刷新
 */
@property (nonatomic, strong)GeneralBlock refresh;

/**
 * size guide
 */
@property (nonatomic, strong)GeneralBlock sizeGuide;
/**
 *  选中颜色
 */
- (void)selectedColorInfor:(XZZColor *)color;

@end

NS_ASSUME_NONNULL_END
