//
//  XZZFillEmailInforView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/15.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  填写邮箱信息
 */
@interface XZZFillEmailInforView : UIView

/**
 * 输入框
 */
@property (nonatomic, strong)UITextField * textField;

- (void)addSubView:(UIView *)view;

- (void)removeView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock determine;

@end

NS_ASSUME_NONNULL_END
