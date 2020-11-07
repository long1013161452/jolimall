//
//  XZZClassificationChellysunView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZClassificationChellysunView.h"

@implementation XZZClassificationChellysunView

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat width = ScreenWidth / 4.0;
    CGFloat height = width / 2 + 40;
    CGFloat bottom = 0;
    for (int i = 0; i < self.homeTemplateArray.count; i++) {
        CGRect frame;
        if (i < 4) {
            frame = CGRectMake(width * i, 0, width, height);
        }else{
            frame = CGRectMake(width * (i - 4), height, width, height);
        }
        UIView * view = [self createSingleCategoryFrame:frame tag:i categoryInfor:self.homeTemplateArray[i]];
        [self addSubview:view];
        bottom = view.bottom;
    }
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, bottom, ScreenWidth, home_Template_interval)];
//    dividerView.backgroundColor = BACK_COLOR;
    
    [self addSubview:dividerView];
    self.height = dividerView.bottom;
}

- (UIView *)createSingleCategoryFrame:(CGRect)frame tag:(NSInteger)tag categoryInfor:(id)categoryInfor
{
    UIView * view = [UIView allocInitWithFrame:frame];
    view.tag = tag;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
    
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(view.width / 4, 20, view.width / 2, view.width / 2)];
    [view addSubview:imageView];
    
    UILabel * label = [UILabel allocInitWithFrame:CGRectMake(0, imageView.bottom + 0, view.width, 20)];
    label.font = textFont(13);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kColor(0x2f2f2f);
    [view addSubview:label];
    
    XZZHomeTemplate * homeTemplate = categoryInfor;
    
    [imageView addImageFromUrlStr:homeTemplate.picture];
    label.text = homeTemplate.name;
    
    return view;
}

- (void)clickOnImageViewTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[tap.view.tag]];
    }
}

@end
