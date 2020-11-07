//
//  XZZFilteringAndSortingView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/14.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SelectionSort)(NSInteger index);

typedef void(^SelectionFilter)(void);



@interface XZZFilteringAndSortingView : UIView

/**
 * 排序方式
 */
@property (nonatomic, strong)NSArray * sortingArray;

/**
 * 选中的排序类型
 */
@property (nonatomic, strong)NSString * selectedSorting;

/**
 * 选择排序
 */
@property (nonatomic, strong)SelectionSort selectionSort;

/**
 * 选择筛选
 */
@property (nonatomic, strong)SelectionFilter selectionFilter;

/**
 * 是否隐藏筛选
 */
@property (nonatomic, assign)BOOL hiddenFilter;

- (void)addView;


- (void)hiddenSortView;

@end




@interface XZZSortingView : UIView


/**
 * 选中
 */
@property (nonatomic, assign)BOOL selected;

/**
 * 排序标题
 */
@property (nonatomic, strong)UILabel * sortingTitleLabel;

/**
 * 选中展示
 */
@property (nonatomic, strong)FLAnimatedImageView * selectedImageView;

+ (id)allocInitWithFrame:(CGRect)frame title:(NSString *)title;


@end







NS_ASSUME_NONNULL_END
