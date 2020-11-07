//
//  XZZSubclassCategoryView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  展示二级三级分类
 */
@interface XZZSubclassCategoryView : UIView

/**
 * 分类信息
 */
@property (nonatomic, weak)XZZCategory * category;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end

/**
 *  展示分类信息   头部
 */
@interface XZZSubclassCategoryHeaderView : UIView

/**
 * 分类信息
 */
@property (nonatomic, weak)XZZCategory * category;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end

/**
 *  展示一排分类信息   三个分类
 */
@interface XZZSubclassCategoryCell : UITableViewCell
/**
 * 分类信息
 */
@property (nonatomic, strong)NSArray<XZZCategory *> * categoryArray;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

+ (CGFloat)getHeight;

@end

/**
 *  展示单个分类信息   三级
 */
@interface XZZDisplaySingleCategoryView : UIView

/**
 * 分类信息
 */
@property (nonatomic, weak)XZZCategory * category;

@end




NS_ASSUME_NONNULL_END
