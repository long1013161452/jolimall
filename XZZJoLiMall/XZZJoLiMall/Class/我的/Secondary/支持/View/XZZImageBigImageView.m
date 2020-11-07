//
//  XZZImageBigImageView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/15.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZImageBigImageView.h"

@interface XZZImageBigImageView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * imageView;

@property (nonatomic,strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic,strong) UITapGestureRecognizer *singleTap;

@end

@implementation XZZImageBigImageView

static XZZImageBigImageView * imageBigImageView = nil;

+ (XZZImageBigImageView *)shareImageBigImageView
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        imageBigImageView = [[XZZImageBigImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        imageBigImageView.alpha = 0;
        [imageBigImageView addView];
        [imageBigImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:imageBigImageView action:@selector(removeView)]];
    });
    return imageBigImageView;
}


- (void)addView{
    
    
//    [self setupView];
//    [self addGestureRecognizer:self.singleTap];
//    [self addGestureRecognizer:self.doubleTap];
//
//    return;
    
    self.scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.minimumZoomScale = .5;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    
    
    self.imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = YES;
    [self.scrollView addSubview:self.imageView];
}

- (void)setupView {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.maximumZoomScale = 2;
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
    
    self.imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = YES;
    [self.scrollView addSubview:self.imageView];
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    _scrollView.frame = self.bounds;
//    _imageView.frame = _scrollView.bounds;
//}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat xcenter = scrollView.center.x, ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width > scrollView.width ? scrollView.contentSize.width / 2.0 : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.height ? scrollView.contentSize.height / 2.0 : ycenter;

    self.imageView.center = CGPointMake(xcenter, ycenter);
    
}

- (void)setImageInfor:(id)imageInfor
{
    _imageInfor = imageInfor;
    if ([imageInfor isKindOfClass:[UIImage class]]) {
        self.imageView.image = imageInfor;
    }else if ([imageInfor isKindOfClass:[FLAnimatedImage class]]){
        self.imageView.animatedImage = imageInfor;
    }else if ([imageInfor isKindOfClass:[NSString class]]){
        [self.imageView addImageFromUrlStr:imageInfor];
    }
}

- (void)setUpGestureRecognizer
{
//    UITapGestureRecognizer *
}


- (void)addSubView
{
    WS(wSelf)

    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window addSubview:wSelf];
        [UIView animateWithDuration:.3 animations:^{
            wSelf.alpha = 1;
        }];
    });
    
    
}

/**
 * 移除视图
 */
- (void)removeView
{
    WS(wSelf)
    [UIView animateWithDuration:.3 animations:^{
        wSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [wSelf removeFromSuperview];
    }];
}

#pragma mark - getter

- (UITapGestureRecognizer *)doubleTap {
    if (!_doubleTap) {
        _doubleTap  =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestrueHandle:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}

- (UITapGestureRecognizer *)singleTap {
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestrueHandle:)];
        _singleTap.numberOfTapsRequired = 1;
        _singleTap.numberOfTouchesRequired = 1;
        [_singleTap requireGestureRecognizerToFail:self.doubleTap];
    }
    return _singleTap;
}

#pragma mark - gesture handler

- (void)doubleTapGestrueHandle:(UITapGestureRecognizer *)sender {
    CGPoint p = [sender locationInView:self];
    if (self.scrollView.zoomScale <=1.0) {
        CGFloat scaleX = p.x + self.scrollView.contentOffset.x;
        CGFloat scaley = p.y + self.scrollView.contentOffset.y;
        [self.scrollView zoomToRect:CGRectMake(scaleX, scaley, 10, 10) animated:YES];
    }
    else {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
}

- (void)singleTapGestrueHandle:(UITapGestureRecognizer *)sender {
//    if (self.tapActionBlock) {
//        self.tapActionBlock(sender);
//    }
    
}

@end
