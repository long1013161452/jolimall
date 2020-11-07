//
//  XZZSinglePictureView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSinglePictureView.h"

#define Aspect_ratio (99.0 / 375.0)

@implementation XZZSinglePictureView



- (void)addView{
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * Aspect_ratio)];
    [imageView addImageFromUrlStr:[self.homeTemplateArray firstObject].picture];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnHomePageTemplateTap:)]];
    [self addSubview:imageView];
    self.height = imageView.bottom + home_Template_interval;
    self.backgroundColor = [UIColor whiteColor];
}


#pragma mark ----*  点击首页模板
/**
 *  点击首页模板
 */
- (void)clickOnHomePageTemplateTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:[self.homeTemplateArray firstObject]];
    }
}

@end

