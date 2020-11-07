//
//  XZZMainCategoryView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZMainCategoryView : UIView


/**
 * 所有分类信息
 */
@property (nonatomic, strong)NSArray<XZZCategory *> * categoryArray;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end



@interface XZZMainCategoryCell : UITableViewCell

/**
 * 分类信息
 */
@property (nonatomic, strong)XZZCategory * category;

/**
 * 是否是选中的主分类
 */
@property (nonatomic, assign)BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
