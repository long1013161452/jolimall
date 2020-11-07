//
//  XZZSearchGoodsListViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectionSearchContent)(NSString * searchContent);


/**
 *  搜索结果   商品列表
 */
@interface XZZSearchGoodsListViewController : XZZRootViewController

/**
 * 搜索内容
 */
@property (nonatomic, strong)NSString * searchContent;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * <#expression#>
 */
@property (nonatomic, strong)SelectionSearchContent selectionSearchContent;

@end

NS_ASSUME_NONNULL_END
