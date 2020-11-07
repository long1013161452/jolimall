//
//  XZZThreeAdvertisingView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZThreeAdvertisingView.h"

#define Aspect_ratio (1038.0 / 666.0)

@implementation XZZThreeAdvertisingView

- (void)addView
{
    /***  第一个活动视图信息 */
    CGFloat width = ScreenWidth * .592;//.592是第一个活动在整个屏幕上的占比
    CGFloat hight = width * (Aspect_ratio);
    CGFloat twoWidth = ScreenWidth - home_Template_interval * 3 - width;//后面两个并排的宽度
    CGFloat twoHight = (hight - home_Template_interval) / 2.0;//后面两个并排的高度
    CGFloat right = 0;
    CGFloat top = 0;
    if (self.homeTemplateArray.count > 0) {
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(right + home_Template_interval, top, width, hight)];
        imageView.tag = 0;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
        imageView.userInteractionEnabled = YES;
        [imageView addImageFromUrlStr:self.homeTemplateArray[0].picture];
        [self addSubview:imageView];
        right = imageView.right;
        self.height = imageView.bottom + home_Template_interval;
    }
    
    if (self.homeTemplateArray.count > 1) {
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(right + home_Template_interval, top, twoWidth, twoHight)];
        imageView.tag = 1;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
        imageView.userInteractionEnabled = YES;
        [imageView addImageFromUrlStr:self.homeTemplateArray[1].picture];
        [self addSubview:imageView];
        top = imageView.bottom + home_Template_interval;
    }
    
    if (self.homeTemplateArray.count > 2) {
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(right + home_Template_interval, top, twoWidth, twoHight)];
        imageView.tag = 2;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
        imageView.userInteractionEnabled = YES;
        [imageView addImageFromUrlStr:self.homeTemplateArray[2].picture];
        [self addSubview:imageView];
        top = imageView.bottom + home_Template_interval;
    }
    
    
}

- (void)clickOnImageViewTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[tap.view.tag]];
    }
}

@end
