//
//  XZZTwoAdvertisingChellysunView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZTwoAdvertisingChellysunView.h"

#define Aspect_ratio (92.5 / 359.0)

@implementation XZZTwoAdvertisingChellysunView

- (void)addView{
    CGFloat width = ScreenWidth - home_Template_interval * 2;
    CGFloat height = width * Aspect_ratio;
    CGFloat top = 0;
    
    NSInteger tag = 0;
    
    for (XZZHomeTemplate * homeTemplate in self.homeTemplateArray) {
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(home_Template_interval, top, width, height)];
        imageView.tag = tag;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView:)]];
        [imageView addImageFromUrlStr:homeTemplate.picture];
        [self addSubview:imageView];
        tag++;
        top = imageView.bottom + home_Template_interval;
    }
    self.height = top;
}

- (void)clickOnImageView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[tap.view.tag]];
    }
}

@end
