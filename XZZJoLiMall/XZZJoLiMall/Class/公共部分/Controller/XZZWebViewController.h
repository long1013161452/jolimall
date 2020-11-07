//
//  XZZWebViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/18.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  web控制器
 */
@interface XZZWebViewController : XZZMainViewController


/**
 * 网页
 */
@property (nonatomic, strong)NSString * urlStr;

/**
 * 可以是url也可以是字符串
 */
@property (nonatomic, strong)id webUrl;


@end

NS_ASSUME_NONNULL_END
