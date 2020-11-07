//
//  XZZHomeTemplateView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZHomeTemplate.h"

NS_ASSUME_NONNULL_BEGIN

@class XZZHomeTemplateView;

typedef void(^DownloadGoods)(XZZHomeTemplateView * view);

/**
 *  首页模板
 */
@interface XZZHomeTemplateView : UIView

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * 首页模板信息
 */
@property (nonatomic, strong)NSArray<XZZHomeTemplate *> * homeTemplateArray;

/**
 *  创建视图信息
 */
+ (id)allocInitWithFrame:(CGRect)frame homeTemplate:(XZZHomeTemplate *)homeTemplate delegate:(id<XZZMyDelegate>)delegate;

- (void)addView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock refresh;


@end

NS_ASSUME_NONNULL_END
