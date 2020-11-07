//
//  XZZRequestSearch.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/12.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZRequestSearch : NSObject

/**
 * 搜索内容
 */
@property (nonatomic, strong)NSString * query;

/**
 * 排序
 */
@property (nonatomic, assign)int orderBy;

/**
 * 页码
 */
@property (nonatomic, assign)int pageNum;

/**
 * 一页多少数据
 */
@property (nonatomic, assign)int pageSize;

@end

NS_ASSUME_NONNULL_END
