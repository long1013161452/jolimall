//
//  XZZGoodsIntroductionView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XZZGoodsIntroductionSingleView, XZZGoodsIntroductionView;

typedef void(^goodsIntroductionView)(XZZGoodsIntroductionSingleView * view);


/**
 *  商品介绍
 */
@interface XZZGoodsIntroductionView : UIView

/**
 * 展示内容
 */
@property (nonatomic, strong)NSArray * titleArray;

/**
 * 展示内容
 */
@property (nonatomic, strong)NSArray * contentArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsIntroductionSingleView * inforView;


/**
 * <#expression#>
 */
@property (nonatomic, strong)goodsIntroductionView goodsIntroductionView;

@end

/**
 *  商品介绍  单个
 */
@interface XZZGoodsIntroductionSingleView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * dividerView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * contentLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * imageView;


/***  创建视图信息 */
- (void)addViewTitle:(NSString *)title content:(NSString *)content;

/***  展示内容展开或隐藏 */
- (void)showContentExpandedOrHidden:(BOOL)hidden;


@end



NS_ASSUME_NONNULL_END
