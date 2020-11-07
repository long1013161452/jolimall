//
//  XZZHomeShufflingFigureView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZHomeShufflingFigureView.h"

#define Aspect_ratio (210.0 / 375.0)


@interface XZZHomeShufflingFigureView ()<SDCycleScrollViewDelegate>

/**
 * 轮播图
 */
@property (nonatomic, strong)SDCycleScrollView * scrollView;


@end

@implementation XZZHomeShufflingFigureView



- (void)addView {
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * Aspect_ratio) delegate:self placeholderImage:nil];
    _scrollView.titleLabelBackgroundColor = [UIColor whiteColor];
    _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _scrollView.autoScrollTimeInterval = 3;
    _scrollView.currentPageDotColor = current_Page_Dot_Color;
    _scrollView.pageDotColor = page_Dot_Color;
    [self addSubview:self.scrollView];
    NSMutableArray * array = @[].mutableCopy;
    for (XZZHomeTemplate * template in self.homeTemplateArray) {
        if (template.picture) {
            [array addObject:template.picture];
        }
    }
    self.scrollView.localizationImageNamesGroup = array;
    self.height =  self.scrollView.bottom;
}



#pragma mark ----   点击轮播图的时候进行的回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"");
    NSLog(@"%s %d 行", __func__, __LINE__);
    if (self.homeTemplateArray.count) {
        if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
            [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[index]];
        }
    }

    
}



@end
