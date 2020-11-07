//
//  XZZCheckOutTitleView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  标题
 */
@interface XZZCheckOutTitleView : UIView

/**
 * title
 */
@property (nonatomic, strong)NSString * title;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * titleLabel;

/**
 * 是否隐藏右侧视图
 */
@property (nonatomic, assign)BOOL isRightViewHidden;



@end

NS_ASSUME_NONNULL_END
