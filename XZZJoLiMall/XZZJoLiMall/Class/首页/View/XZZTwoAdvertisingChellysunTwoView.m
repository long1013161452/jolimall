//
//  XZZTwoAdvertisingChellysunTwoView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZTwoAdvertisingChellysunTwoView.h"

#define Aspect_ratio (653.0 / 525.0)

@implementation XZZTwoAdvertisingChellysunTwoView

- (void)addView{
    
    CGFloat width = (ScreenWidth - home_Template_interval * 3) / 2.0;
    CGFloat hight = width * (Aspect_ratio);
    
    CGFloat right = 0;
    CGFloat top = 0;
    
    
    for (int i = 0; i < self.homeTemplateArray.count; i++) {
        FLAnimatedImageView * oneImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(right + home_Template_interval, top, width, hight)];
        oneImageView.tag = i;
        [oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
        oneImageView.userInteractionEnabled = YES;
        [oneImageView addImageFromUrlStr:self.homeTemplateArray[i].picture];
        [self addSubview:oneImageView];
        if (oneImageView.right > ScreenWidth) {
            oneImageView.top = oneImageView.bottom + home_Template_interval;
            oneImageView.left = home_Template_interval;
        }
        right = oneImageView.right;
        top = oneImageView.top;
        self.height = oneImageView.bottom + home_Template_interval;
    }
    return;
    
    
    
    
    if (self.homeTemplateArray.count > 0) {
        FLAnimatedImageView * oneImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(right + home_Template_interval, 0, width, hight)];
        oneImageView.tag = 0;
        [oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
        oneImageView.userInteractionEnabled = YES;
        [oneImageView addImageFromUrlStr:self.homeTemplateArray[0].picture];
        [self addSubview:oneImageView];
        right = oneImageView.right;
        self.height = oneImageView.bottom + home_Template_interval;

    }
    
    if (self.homeTemplateArray.count > 1) {
        FLAnimatedImageView * twoImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(right + home_Template_interval, 0, width, hight)];
        twoImageView.tag = 1;
        [twoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
        twoImageView.userInteractionEnabled = YES;
        [twoImageView addImageFromUrlStr:self.homeTemplateArray[1].name];
        [self addSubview:twoImageView];
    }
}

- (void)clickOnImageViewTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[tap.view.tag]];
    }
}

@end
