//
//  XZZHomeAdaptiveImageView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/22.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZHomeAdaptiveImageView.h"

@interface XZZHomeAdaptiveImageView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * imageView;

@end

@implementation XZZHomeAdaptiveImageView

- (void)addView
{
    WS(wSelf)
    self.imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView)]];
    [self addSubview:self.imageView];
    self.height = ScreenWidth;
    
    XZZHomeTemplate * homeTemplate = self.homeTemplateArray[0];
    if ([homeTemplate.picture containsString:@"*"]) {
        [self adjustImageHeightTwo];
        [self.imageView addImageFromUrlStr:homeTemplate.picture];
    }else{
        [self.imageView addImageFromUrlStr:homeTemplate.picture httpBlock:^(id data, BOOL successful, NSError *error) {
            if (successful) {
                [wSelf adjustImageHeight];
            }else{
                wSelf.height = 0;
                !wSelf.refresh?:wSelf.refresh();
            }
        }];
    }
}

#pragma mark ----修改高度   根据图片链接
- (void)adjustImageHeightTwo
{
    CGFloat imageWidth = 0;
    CGFloat imageHeight = 0;
    XZZHomeTemplate * homeTemplate = self.homeTemplateArray[0];
    NSString * imageUrl = homeTemplate.picture;
    
    NSArray * array = [imageUrl componentsSeparatedByString:@"_"];
    NSString * str = [array lastObject];
    if ([str containsString:@"*"]) {
        array = [str componentsSeparatedByString:@"."];
        str = [array firstObject];
        array = [str componentsSeparatedByString:@"*"];
        if (array.count > 0) {
            imageWidth = [[array firstObject] floatValue];
            imageHeight = [[array lastObject] floatValue];
            self.imageView.height = ScreenWidth / imageWidth * imageHeight;
            
            UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.imageView.height, ScreenWidth, home_Template_interval)];
            //    dividerView.backgroundColor = BACK_COLOR;
            dividerView.backgroundColor = [UIColor whiteColor];
            [self addSubview:dividerView];
            
            self.height = dividerView.bottom;
            
            !self.refresh?:self.refresh();
        }
    }
}

- (void)adjustImageHeight
{
    UIImage * image = self.imageView.image;
    
    self.imageView.height = ScreenWidth / image.size.width * image.size.height;
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.imageView.height, ScreenWidth, home_Template_interval)];
//    dividerView.backgroundColor = BACK_COLOR;
    dividerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dividerView];
    
    self.height = dividerView.bottom;
    
    !self.refresh?:self.refresh();
    
}

- (void)clickOnImageView
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:self.homeTemplateArray[0]];
    }
}


@end
