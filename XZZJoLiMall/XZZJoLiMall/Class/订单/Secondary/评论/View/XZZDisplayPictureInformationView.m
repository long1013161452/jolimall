//
//  XZZDisplayPictureInformationView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/5/6.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZDisplayPictureInformationView.h"


@interface XZZDisplayPictureInformationView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZDisplayPictureView * addImageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * imageViewArray;

@end

@implementation XZZDisplayPictureInformationView

+ (instancetype)allocInit
{
    XZZDisplayPictureInformationView * view = [super allocInit];
    [view addView];
    return view;
}

- (NSMutableArray *)imageViewArray
{
    if (!_imageViewArray) {
        self.imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)addImages:(id)image
{
    XZZDisplayPictureView * view = [self creatingViewInformation:image];
    view.tag = self.imageViewArray.count;
    XZZDisplayPictureView * twoView = [self.imageViewArray lastObject];
    if (self.imageViewArray.count % 3 == 0) {
        view.top = twoView.bottom + 10;
        view.left = 0;
    }else{
        view.top = twoView.top;
        view.left = twoView.right;
    }
    [self.imageViewArray addObject:view];
    [self.imageArray addObject:image];
    [self HandleAddPictureButton];
}

- (void)addImageUrlList:(NSArray *)list isCanDeleteImage:(BOOL)is
{
    for (NSString * str in list) {
        [self addImages:str];
    }
    for (XZZDisplayPictureView * view in self.imageViewArray) {
        view.shutDownButton.hidden = is;
    }
    if (is) {
        self.addImageView.hidden = YES;
    }
}

- (void)RemoveImageViewInformation:(XZZDisplayPictureView *)view
{
    [self.imageArray removeObjectAtIndex:view.tag];
    !self.deletePicture?:self.deletePicture(view.tag);
    UIView * twoView = [self.imageViewArray lastObject];
    [twoView removeFromSuperview];
    [self.imageViewArray removeLastObject];
    for (XZZDisplayPictureView * imageView in self.imageViewArray) {
        if (imageView.tag < self.imageArray.count) {
            [imageView addImages:self.imageArray[imageView.tag]];
        }
    }
    [self HandleAddPictureButton];
}

- (void)deleteLastImage
{
    [self.imageArray removeLastObject];
    UIView * twoView = [self.imageViewArray lastObject];
    [twoView removeFromSuperview];
    [self.imageViewArray removeLastObject];
    for (XZZDisplayPictureView * imageView in self.imageViewArray) {
        if (imageView.tag < self.imageArray.count) {
            [imageView addImages:self.imageArray[imageView.tag]];
        }
    }
    
    [self HandleAddPictureButton];
}

- (void)deleteAllImage
{
    [self.imageArray removeAllObjects];
    [self.imageViewArray removeAllObjects];
    [self removeAllSubviews];
    
    [self addView];
    return;
    [self.imageViewArray removeLastObject];
    for (XZZDisplayPictureView * imageView in self.imageViewArray) {
        [imageView removeFromSuperview];
    }
    [self.imageViewArray removeAllObjects];
    [self HandleAddPictureButton];
}

- (void)HandleAddPictureButton
{
    CGFloat height = 0;
    if (self.imageViewArray.count >= self.imageCount) {
        self.addImageView.hidden = YES;
        UIView * view = [self.imageViewArray lastObject];
        height = view.bottom + 10;
    }else{
        self.addImageView.hidden = NO;
        XZZDisplayPictureView * twoView = [self.imageViewArray lastObject];
        if (self.imageViewArray.count % 3 == 0) {
            self.addImageView.top = twoView.bottom + 10;
            self.addImageView.left = 0;
        }else{
            self.addImageView.top = twoView.top;
            self.addImageView.left = twoView.right;
        }
        
        height = self.addImageView.bottom + 10;
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}


- (XZZDisplayPictureView *)creatingViewInformation:(id)image
{
    WS(wSelf)
    CGFloat width = (ScreenWidth - 19 * 2) / 3.0;
    XZZDisplayPictureView * view = [XZZDisplayPictureView allocInit];
    [view addImages:image];
    [view setClickOnImageInformation:^(XZZDisplayPictureView * _Nonnull view) {

    }];
    [view setTurnOffPictureInformation:^(XZZDisplayPictureView * _Nonnull view) {
        [wSelf RemoveImageViewInformation:view];
    }];
    [self addSubview:view];
    view.frame = CGRectMake(0, 0, width, width);
    
    return view;
}


- (void)addView{

    
    WS(wSelf)
    CGFloat width = (ScreenWidth - 19 * 2) / 3.0;
    XZZDisplayPictureView * view = [XZZDisplayPictureView allocInit];
    [view addImages:nil];
    [view setClickOnImageInformation:^(XZZDisplayPictureView * _Nonnull view) {
        [wSelf SelectPictureInformation];
    }];
    [self addSubview:view];
    view.frame = CGRectMake(0, 0, width, width);
    self.addImageView = view;
    CGFloat height = self.addImageView.bottom + 10;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
}


- (void)SelectPictureInformation
{
    !self.choosePicture?:self.choosePicture();
}



@end


@implementation XZZDisplayPictureView

- (void)addImages:(id)image
{
    if ([image isKindOfClass:[UIImage class]]) {
        self.imageView.image = image;
        self.shutDownButton.hidden = NO;
    }else if ([image isKindOfClass:[NSString class]]){
        [self.imageView addImageFromUrlStr:image];
        self.shutDownButton.hidden = NO;
    }else{
        self.imageView.image = imageName(@"order_Add_comments_booth_figure");
        self.shutDownButton.hidden = YES;
    }
}

+ (instancetype)allocInit
{
    XZZDisplayPictureView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    self.imageView = [UIImageView allocInit];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView)]];
    self.imageView.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(wSelf);
        make.top.equalTo(@10);
        make.right.equalTo(wSelf).offset(-10);
    }];
    
    self.shutDownButton = [UIButton allocInitWithImageName:@"order_Add_comments_Shut_down" selectedImageName:@"order_Add_comments_Shut_down"];
    [self.shutDownButton addTarget:self action:@selector(clickOnShutDownButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.shutDownButton];
    [self.shutDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@24);
        make.centerY.equalTo(wSelf.imageView.mas_top);
        make.centerX.equalTo(wSelf.imageView.mas_right).offset(-8);
    }];
}

- (void)clickOnShutDownButton
{
    !self.turnOffPictureInformation?:self.turnOffPictureInformation(self);
}

- (void)clickOnImageView
{
    !self.clickOnImageInformation?:self.clickOnImageInformation(self);
}



@end
