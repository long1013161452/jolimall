//
//  XZZSizeTypeImageView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSizeTypeImageView.h"

@interface XZZSizeTypeImageView ()<UIScrollViewDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

/**
 * <#expression#>
 */
@property (nonatomic, strong) UIScrollView * scrollView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * imageView;//660yf

@end

@implementation XZZSizeTypeImageView


- (void)addView{
    WS(wSelf)
    [self removeAllSubviews];
    /***  背景透明视图 */
    self.transparentLayerView = [UIView allocInitWithFrame:self.bounds];
    self.transparentLayerView.backgroundColor = kColorWithRGB(0, 0, 0, .35);
    [self.transparentLayerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:self.transparentLayerView];
    
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(11, self.height, ScreenWidth - 11 * 2, ScreenHeight * (1.0 / 3.0))];
    backView.backgroundColor = [UIColor whiteColor];
    [backView cutRounded:5];
    [self addSubview:backView];
    self.backView = backView;
    
    CGFloat imageHeight = [self adjustImageHeight];
    if (imageHeight > ScreenHeight / 3.0) {
        CGFloat backViewHeight = imageHeight + 44 + 11;
        backView.height = backViewHeight > (ScreenHeight * 2.0 / 3.0) ? (ScreenHeight * 2.0 / 3.0) : backViewHeight;
    }
    
    UILabel * label = [UILabel allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    label.text = @"Size guide";
    label.font = textFont(14);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kColor(0x121314);
    [self.backView addSubview:label];
    
    weakView(weak_label, label)
    /***  关闭按钮 */
    UIButton * shutDownButton = [UIButton allocInit];
    [shutDownButton setImage:imageName(@"goods_details_Shut_down") forState:(UIControlStateNormal)];
    [shutDownButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:shutDownButton];
    [shutDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.backView);
        make.centerY.equalTo(weak_label);
        make.width.height.equalTo(@30);
    }];
    /***  展示尺寸颜色数量 */
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, label.bottom, self.backView.width, self.backView.height - label.bottom)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.maximumZoomScale = 5.f;
    scrollView.minimumZoomScale = 1.f;
    scrollView.delegate = self;
    [self.backView addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat imageHeightMin = ScreenHeight / 3.0 - label.height - 11;
    CGFloat imageHeightMax = ScreenHeight * 2.0 / 3.0 - label.height - 11;
    
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(11, 0, backView.width - 11 * 2, scrollView.height - 11)];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    weakView(wv, imageView)
    [imageView addImageFromUrlStr:self.imageUrl httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            UIImage * image = data;
            wv.height = (wv.width) * (image.size.height / image.size.width);
            wSelf.scrollView.contentSize = CGSizeMake(0, wv.height + 10);
            
            if (wv.height < imageHeightMin) {
                wSelf.backView.height = ScreenHeight / 3.0;
                wSelf.scrollView.height = wSelf.backView.height - label.bottom;
                wv.centerY = scrollView.height / 2.0;
            }else if (wv.height < imageHeightMax){
                wSelf.scrollView.height = wv.height + 11;
                wSelf.backView.height = wSelf.scrollView.height + label.height;
            }
            wSelf.backView.centerY = ScreenHeight / 2.0;
            
        }
    }];
    
    
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView  //委托方法,必须设置  delegate
{
    return self.imageView;//要放大的视图
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self addView];
}

#pragma mark ----修改高度   根据图片链接
- (CGFloat)adjustImageHeight
{
    CGFloat imageWidth = 0;
    CGFloat imageHeight = 0;
    CGFloat imageViewWidth = ScreenWidth - 11.0 * 4;
    NSString * imageUrl = self.imageUrl;
    
    NSArray * array = [imageUrl componentsSeparatedByString:@"_"];
    NSString * str = [array lastObject];
    if ([str containsString:@"*"]) {
        array = [str componentsSeparatedByString:@"."];
        str = [array firstObject];
        array = [str componentsSeparatedByString:@"*"];
        if (array.count > 0) {
            imageWidth = [[array firstObject] floatValue];
            imageHeight = [[array lastObject] floatValue];
            return imageViewWidth / imageWidth * imageHeight;
        }
    }
    return 0;
}


/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView
{
    WS(wSelf)
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        [((AppDelegate *)[UIApplication sharedApplication].delegate).window addSubview:wSelf];
        [wSelf bringSubviewToFront:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
//        wSelf.backView.bottom = 0;
//        [UIView animateWithDuration:.5 animations:^{
            wSelf.backView.centerY = ScreenHeight / 2.0;
//        }];
//    });
    
    
}

/**
 * 移除视图
 */
- (void)removeView
{
    WS(wSelf)
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:.3 animations:^{
//            wSelf.backView.top = ScreenHeight;
//        } completion:^(BOOL finished) {
//            wSelf.backView.bottom = 0;
            [wSelf removeFromSuperview];
//        }];
//    });
    
    
}


@end
