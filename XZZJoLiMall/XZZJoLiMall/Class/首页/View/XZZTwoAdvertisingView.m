//
//  XZZTwoAdvertisingView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZTwoAdvertisingView.h"

#define Aspect_ratio (143.0 / 375.0)

@implementation XZZTwoAdvertisingView

- (void)addView{
    
    CGFloat height = ScreenWidth * Aspect_ratio;
    CGFloat top = 0;
    
    NSInteger tag = 0;
    
    for (XZZHomeTemplate * homeTemplate in self.homeTemplateArray) {
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, top, ScreenWidth, height)];
        imageView.tag = tag;
        [imageView addImageFromUrlStr:homeTemplate.picture];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView:)]];
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
