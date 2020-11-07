//
//  XZZCheckOutContactInforView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCheckOutTitleView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  联系方式
 */
@interface XZZCheckOutContactInforView : UIView


/**
 * 是否是邮箱
 */
@property (nonatomic, assign)BOOL isEmail;

/**
 * 联系方式
 */
@property (nonatomic, strong)UITextField * textField;


@end

NS_ASSUME_NONNULL_END
