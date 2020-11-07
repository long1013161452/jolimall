//
//  XZZHomeRecommendedCategoryView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZHomeRecommendedCategoryView.h"


@interface XZZHomeRecommendedCategoryView ()


/**
 * 选中的按钮
 */
@property (nonatomic, strong)UIButton * selectedButton;

/**
 * 下面划线
 */
@property (nonatomic, strong)UIView * dividerView;

/**
 * 点击位置信息   记录点击按钮的tag
 */
@property (nonatomic, assign)NSInteger selectedIndex;

/**
 * 滚动
 */
@property (nonatomic, strong) UIScrollView * scrollView;

@end


@implementation XZZHomeRecommendedCategoryView


+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZHomeRecommendedCategoryView * view = [super allocInitWithFrame:frame];
    view.selectedIndex = -1;
    return view;
}


- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self removeAllSubviews];
    
    self.height = 40;
    
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, 0, self.width, self.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat width = self.width / 4.5;
    if (self.homeTemplateArray.count <= 4) {
        width = self.width / self.homeTemplateArray.count;
    }
    CGFloat height = self.height;
    /***  分割线  小的 */
    self.dividerView = [UIView allocInitWithFrame:CGRectMake(0, height - 2, width - 10, 2)];
    self.dividerView.backgroundColor = button_back_color;//kColor(0xff563f);
    [scrollView addSubview:self.dividerView];
    
    for (int i = 0; i < self.homeTemplateArray.count; i++) {/***  按钮信息 */
        
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(width * i, 0, width, height)];
        [button setTitleColor:kColorWithRGB(0, 0, 0, 1) forState:(UIControlStateNormal)];
        [button setTitleColor:button_back_color forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(clickOnButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setTitle:self.homeTemplateArray[i].name forState:(UIControlStateNormal)];
        button.tag = i;
        if (ScreenWidth == 320) {
            button.titleLabel.font = textFont(12);
        }else{
            button.titleLabel.font = textFont(14);
        }
        [scrollView addSubview:button];
        
        if (self.selectedIndex < 0 || self.selectedIndex >= self.homeTemplateArray.count) {
            if (open_number_times > 1) {
                if (i == 1) {
                    [self clickOnButton:button];
                }
            }else{
                if (i == 0) {
                    [self clickOnButton:button];
                }
            }
        }else{
            if (i == self.selectedIndex) {
                [self clickOnButton:button];
            }
        }
        scrollView.contentSize = CGSizeMake(button.right, 0);
    }
}


- (void)clickOnButton:(UIButton *)button
{
    if (![self.selectedButton isEqual:button]) {
        if (button.right - self.width > self.scrollView.contentOffset.x) {
            [self.scrollView setContentOffset:CGPointMake(button.right - self.width, 0) animated:YES];
        }
        if (button.left < self.scrollView.contentOffset.x) {
            [self.scrollView setContentOffset:CGPointMake(button.left, 0) animated:YES];
        }
        
        self.selectedButton = button;
        
        if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:selectedIndex:)]) {
            [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[button.tag] selectedIndex:button.tag];
        }
    }
}

#pragma mark ----*  选中按钮
/**
 *  选中按钮
 */
- (void)setSelectedButton:(UIButton *)selectedButton
{
    self.selectedButton.selected = NO;
    selectedButton.selected = YES;
    _selectedButton = selectedButton;
    self.dividerView.centerX = selectedButton.centerX;
    self.selectedIndex = selectedButton.tag;
}

@end
