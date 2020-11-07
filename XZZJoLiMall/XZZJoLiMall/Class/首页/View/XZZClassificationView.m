//
//  XZZClassificationView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZClassificationView.h"


#define Aspect_ratio (91.0 / 186.0)

@implementation XZZClassificationView

- (void)addView
{
    CGFloat interval = 3;
    CGFloat width = (ScreenWidth - interval) / 2.0;
    CGFloat height = width * Aspect_ratio;
    CGFloat top = 0;
    CGFloat left = 0;
    CGFloat bottom = 0;
    NSInteger tag = 0;
    for (XZZHomeTemplate * homeTemplate in self.homeTemplateArray) {
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(left, top, width, height)];
        imageView.tag = tag;
        [imageView addImageFromUrlStr:homeTemplate.picture];
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageViewTap:)]];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        left = imageView.right + interval;
        if (left > ScreenWidth) {
            left = 0;
            top = imageView.bottom + interval;
        }
        tag++;
        bottom = imageView.bottom;
    }
    
    self.height = bottom + home_Template_interval;
    
}

- (void)clickOnImageViewTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[tap.view.tag]];
    }
}

@end
