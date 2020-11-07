//
//  XZZGoodsDetailsImageView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/25.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsDetailsImageView.h"



@interface XZZGoodsDetailsImageView ()

@property(nonatomic,copy)imageClick imgClick;//图片点击block

/**
 * 图片信息
 */
@property (nonatomic, strong)NSArray * imageArray;

/**
 * 调整高度
 */
@property (nonatomic, assign)BOOL adjustHeight;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * boothFigureImageView;

@end

@implementation XZZGoodsDetailsImageView

+ (id)allocInitWithFrame:(CGRect)frame imageUrl:(NSArray *)imageUrlArray imageClick:(imageClick)imgClick
{
    XZZGoodsDetailsImageView * view = [self allocInitWithFrame:frame];
    [view addView];
    [view recreateImageviewAccordingToImageUrl:imageUrlArray];
    view.imgClick = imgClick;
    return view;
}

- (void)addView{
    WS(wSelf)
    self.scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.scrollView.clipsToBounds = NO;//展示滚动视图之外的试图信息    不会把范围外的视图隐藏掉
    //        scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;//
    self.scrollView.delegate = self;
    self.scrollView.decelerationRate = .9;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf);
    }];
    
    self.countLabel = [UILabel allocInitWithFrame:CGRectMake(30, self.height - 20 - 36, 50, 24)];
    self.countLabel.textColor = kColor(0xffffff);
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.font = textFont(12);
    self.countLabel.backgroundColor = kColorWithRGB(0, 0, 0, .3);
    self.countLabel.layer.cornerRadius = 12;
    self.countLabel.layer.masksToBounds = YES;
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(wSelf).offset(-14);
        make.height.equalTo(@24);
        make.width.equalTo(@44);
    }];
    
    CGFloat width = self.width - right_View_Exposing_Width;

    self.boothFigureImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, width, self.height) imageName:@"booth_figure_longitudinal"];
    [self addSubview:self.boothFigureImageView];
    [self.boothFigureImageView addBreathingLampView:NO];
    [self.boothFigureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(wSelf);
        make.width.equalTo(@(width));
    }];
    
    
}

/**
 * 重新创建imageview视图  根据 图片URL
 */
- (void)recreateImageviewAccordingToImageUrl:(NSArray *)imageUrlArray
{
    if (imageUrlArray.count == 0) {
        self.countLabel.hidden = YES;
        return;
    }
    [self.boothFigureImageView removeFromSuperview];
    self.countLabel.hidden = NO;
    
    self.imageURLArray = imageUrlArray;
    [self createImageView:imageUrlArray.count];
    WS(wSelf)
    self.adjustHeight = NO;
    for (int i = 0; i < imageUrlArray.count + 2; i++) {
        FLAnimatedImageView * imageView = self.imageArray[i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        if (i == 1) {
            if ([imageUrlArray[imageView.tag] containsString:@"*"]) {
                CGFloat imageWidth = 0;
                CGFloat imageHeight = 0;
                NSString * imageUrl = imageUrlArray[imageView.tag];
                
                NSArray * array = [imageUrl componentsSeparatedByString:@"_"];
                NSString * str = [array lastObject];
                if ([str containsString:@"*"]) {
                    array = [str componentsSeparatedByString:@"."];
                    str = [array firstObject];
                    array = [str componentsSeparatedByString:@"*"];
                    if (array.count > 0) {
                        imageWidth = [[array firstObject] floatValue];
                        imageHeight = [[array lastObject] floatValue];
                            wSelf.height = (ScreenWidth - right_View_Exposing_Width - Image_interval) * (imageHeight / imageWidth);
                            !wSelf.refresh?:wSelf.refresh();
                        wSelf.adjustHeight = YES;
                    }
                }
                [imageView addImageFromUrlStr:imageUrlArray[imageView.tag]];
            }else{
                [imageView addImageFromUrlStr:imageUrlArray[imageView.tag] httpBlock:^(id data, BOOL successful, NSError *error) {
                    if (!wSelf.adjustHeight) {
                        UIImage * image = nil;
                        if (successful) {
                            image = data;
                        }else{
                            for (FLAnimatedImageView * imageViewTwo in wSelf.imageArray) {
                                if (![imageViewTwo.image isEqual:imageName(@"booth_figure")]) {
                                    image = imageViewTwo.image;
                                    break;
                                }
                            }
                        }
                        if (image) {
                            wSelf.height = (ScreenWidth - right_View_Exposing_Width - Image_interval) * (image.size.height / image.size.width);
                            !wSelf.refresh?:wSelf.refresh();
                        }
                        wSelf.adjustHeight = YES;
                    }
                }];
            }
        }else{
            [imageView addImageFromUrlStr:imageUrlArray[imageView.tag]];
        }
    }
}


#pragma mark ----*  创建滚动视图上的试图信息   图片
/**
 *  创建滚动视图上的试图信息   图片
 */
- (void)createImageView:(NSInteger)imageCount
{
    NSMutableArray * array = [NSMutableArray array];
    [self.scrollView removeAllSubviews];
    CGFloat right = 0;
    UIView * leftView = nil;
    CGFloat width = self.width - right_View_Exposing_Width;
    WS(wSelf)
    for (int i = 0; i < imageCount + 2; i++) {
        FLAnimatedImageView * imageView = nil;
        if (i < self.imageArray.count) {
            imageView = self.imageArray[i];
        }else{
            imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(right, 0, width - Image_interval, _scrollView.height)];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView:)]];
        }
        if (i == 0) {
            imageView.tag = imageCount - 1;
        }else if (i == imageCount + 1){
            imageView.tag = 0;
        }else{
            imageView.tag = i - 1;
        }
        [array addObject:imageView];
        [self.scrollView addSubview:imageView];
        weakView(weak_leftVIew, leftView)
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(wSelf);
            make.width.equalTo(@(width - Image_interval));
            if (weak_leftVIew) {
                make.left.equalTo(weak_leftVIew.mas_right).offset(Image_interval);
            }else{
                make.left.equalTo(@0);
            }
        }];
        right = imageView.right + Image_interval;
        leftView = imageView;
    }
    self.imageArray = array;
    self.scrollView.contentSize = CGSizeMake(right - Image_interval - right_View_Exposing_Width, 0);
    [self.scrollView setContentOffset:CGPointMake(self.width - right_View_Exposing_Width, 0) animated:NO];
    self.countLabel.text = [NSString stringWithFormat:@"1/%ld", (long)imageCount];
}


- (void)clickOnImageView:(UITapGestureRecognizer *)tap
{
    !self.imgClick?:self.imgClick(tap.view.tag, tap.view);
}

/**
 *  移动到atIndex位置
 */
- (void)mobileLocationAtIndex:(NSInteger)atIndex
{
    UIImageView * imageView = self.imageArray[atIndex + 1];
    
    CGFloat right = imageView.right;
    if (right > self.scrollView.contentSize.width && self.scrollView.contentSize.width > imageView.width) {
        right = self.scrollView.contentSize.width - Image_interval;
    }
    [self.scrollView setContentOffset:CGPointMake(right - imageView.width, 0) animated:NO];
}



/**
 *  滚动的时候展示当前页数   图片
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int width = (ScreenWidth - right_View_Exposing_Width);
    
    CGFloat x = scrollView.contentOffset.x;
    NSInteger location = (NSInteger)x / width;
    
    if (scrollView.contentOffset.x < 0) {
        [scrollView setContentOffset:CGPointMake(width * self.imageURLArray.count, 0) animated:NO];
        location = self.imageURLArray.count;
    }else if (scrollView.contentOffset.x > width * (self.imageURLArray.count)){
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        location = 1;
    }
    
    
    location = location == 0 ? self.imageURLArray.count : location;
    location = location > self.imageURLArray.count ? 1 : location;
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%lu", (long)location, (unsigned long)self.imageURLArray.count];
}

- (NSInteger)countPagesForOffset:(CGPoint)offset
{
    CGFloat pageSize = self.width - right_View_Exposing_Width;
    NSInteger page = roundf(offset.x / pageSize);
    page = page == 0 ? self.imageURLArray.count : page;
    page = page > self.imageURLArray.count ? 1 : page;
    return page;
}


- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset
{
    CGFloat pageSize = self.width - right_View_Exposing_Width;
    NSInteger page = roundf(offset.x / pageSize);
    
    if (offset.x > self.scrollView.contentOffset.x) {
        page = ceil(offset.x / pageSize);
    }else if (offset.x < self.scrollView.contentOffset.x){
        page = floor(offset.x / pageSize);
    }
    
    
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];

    targetContentOffset->x = targetOffset.x;
    targetContentOffset->y = targetOffset.y;
}

@end
