//
//  XZZWordsSearch.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/25.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  搜索热词信息
 */
@interface XZZWordsSearch : NSObject

/**
 * s热词
 */
@property (nonatomic, strong)NSString * hotWord;

/**
 * 排序
 */
@property (nonatomic, assign)int sort;

@end

NS_ASSUME_NONNULL_END
