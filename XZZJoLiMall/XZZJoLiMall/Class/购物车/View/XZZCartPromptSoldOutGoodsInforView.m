//
//  XZZCartPromptSoldOutGoodsInforView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/7.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCartPromptSoldOutGoodsInforView.h"




@interface XZZCartPromptSoldOutGoodsInforView ()
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

@end


@implementation XZZCartPromptSoldOutGoodsInforView

- (void)setSoldOutSkuArray:(NSArray *)soldOutSkuArray
{
    _soldOutSkuArray = soldOutSkuArray;
    [self addView];
}

- (void)addView
{
    WS(wSelf)
    
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = kColorWithRGB(0, 0, 0, .3);
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];

    [self addSubview:view];
    
    
    self.backView = [UIView allocInitWithFrame:CGRectMake(20, 20, ScreenWidth - 20 * 2, ScreenHeight / 3.0)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.backView cutRounded:5];
    [self addSubview:self.backView];
    
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 10, self.backView.width, 40) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    titleLabel.font = textFont_bold(14);
    titleLabel.text = @"Currently Unavailable";
    [self.backView addSubview:titleLabel];
    
    UILabel * introduceLabel = [UILabel labelWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom, titleLabel.width, 30) backColor:nil textColor:kColor(0x919191) textFont:12 textAlignment:(NSTextAlignmentCenter) tag:1];
    introduceLabel.text = @"Items are not available,pls delete and continue:";
    introduceLabel.numberOfLines = 2;
    [self.backView addSubview:introduceLabel];
    
    weakView(weak_titleLabel, titleLabel)
    /***  关闭按钮 */
    UIButton * shutDownButton = [UIButton allocInit];
    [shutDownButton setImage:imageName(@"home_Shun_down") forState:(UIControlStateNormal)];
    [shutDownButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:shutDownButton];
    [shutDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.backView).offset(-3);
        make.centerY.equalTo(weak_titleLabel);
        make.width.height.equalTo(@30);
    }];
    
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, introduceLabel.bottom, self.backView.width, self.backView.height - introduceLabel.bottom)];
    [self.backView addSubview:scrollView];
    
    CGFloat buttonHeight = 0;
    if (self.showButton) {
        buttonHeight = 60;
        scrollView.height -= buttonHeight;
        
        UIButton * button = [UIButton allocInitWithTitle:@"Delete and Continue" color:button_back_color selectedTitle:@"Delete and Continue" selectedColor:button_back_color font:15];
        [button addTarget:self action:@selector(clickOutDeleteSku) forControlEvents:(UIControlEventTouchUpInside)];
        [self.backView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(wSelf.backView);
            make.height.equalTo(@(buttonHeight));
        }];
    }
    
    CGFloat top = 0;
    for (XZZSku * sku in self.soldOutSkuArray) {
        UIView * skuView = [self createSkuViewFrame:CGRectMake(0, top, scrollView.width, 100) subView:scrollView sku:sku];
        top = skuView.bottom;
    }
    
    scrollView.contentSize = CGSizeMake(0, top);
    if (top > (ScreenHeight / 3.0 * 2.0 - buttonHeight - scrollView.top)) {
        self.backView.height = ScreenHeight / 3.0 * 2.0;
        scrollView.height = self.backView.height - introduceLabel.bottom - buttonHeight;
    }else if(top > (ScreenHeight / 3.0 - scrollView.top - buttonHeight)){
        scrollView.height = top;
        self.backView.height = scrollView.height + introduceLabel.bottom + buttonHeight;
    }
        
    
}

- (void)clickOutDeleteSku
{
    !self.removeSoldOutSku?:self.removeSoldOutSku(self.soldOutSkuArray);
    [self removeFromSuperview];
}

- (UIView *)createSkuViewFrame:(CGRect)frame subView:(UIView *)subView sku:(XZZSku *)sku
{
    UIView * view = [UIView allocInitWithFrame:frame];
    [subView addSubview:view];
    
    weakView(weak_view, view)
    FLAnimatedImageView * goodsImageView = [FLAnimatedImageView allocInit];
    goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    goodsImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    goodsImageView.layer.masksToBounds = YES;
    [goodsImageView cutRounded:5];
    [view addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@10);
        make.width.equalTo(@60);
        make.height.equalTo(@80);
    }];
    

    weakView(weak_goodsImageView, goodsImageView)
    UILabel * nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_goodsImageView);
        make.right.equalTo(weak_view).offset(-16);
        make.left.equalTo(weak_goodsImageView.mas_right).offset(10);
    }];
    

    weakView(weak_nameLabel, nameLabel)
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    priceLabel.font = textFont_bold(14);
    [view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_nameLabel);
        make.top.equalTo(weak_nameLabel.mas_bottom).offset(6);
    }];
    
    weakView(weak_priceLabel, priceLabel)
    UILabel * originalPriceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:original_price_color textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    originalPriceLabel.font = original_price_font;
    [view addSubview:originalPriceLabel];
    [originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weak_priceLabel).offset(-3);
        make.left.equalTo(weak_priceLabel.mas_right).offset(10);
    }];
    
    weakView(weak_originalPriceLabel, originalPriceLabel)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = originalPriceLabel.textColor;
    [originalPriceLabel addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(weak_originalPriceLabel);
        make.height.equalTo(@.5);
    }];
    
    UILabel * colorLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    colorLabel.text = @"Color: ";
    [view addSubview:colorLabel];
    [colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_nameLabel);
        make.top.equalTo(weak_priceLabel.mas_bottom).offset(10);
    }];

    weakView(weak_colorLabel, colorLabel)
    UILabel * colorLabelTwo = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [view addSubview:colorLabelTwo];
    [colorLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_colorLabel.mas_right);
        make.top.equalTo(weak_colorLabel);
    }];
    
    weakView(weak_colorLabelTwo, colorLabelTwo)
    UILabel * sizeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    sizeLabel.text = @"Size: ";
    [view addSubview:sizeLabel];
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_colorLabelTwo.mas_right).offset(10);
        make.top.equalTo(weak_colorLabel);
    }];
    
    weakView(weak_sizeLabel, sizeLabel)
    UILabel * sizeLabelTwo = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [view addSubview:sizeLabelTwo];
    [sizeLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_sizeLabel.mas_right);
        make.top.equalTo(weak_colorLabel);
    }];
    
    
    
    [goodsImageView addImageFromUrlStr:sku.mainPicture];
    nameLabel.text = sku.goodsTitle;
    priceLabel.text = [NSString stringWithFormat:@"$%.2f", sku.skuPrice];
    if (sku.skuNominalPrice > 0) {
        originalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", sku.skuNominalPrice];
    }else{
        originalPriceLabel.text = @"";
    }
    
    colorLabelTwo.text = sku.colorName;;
    sizeLabelTwo.text = sku.shortSizeCode.length ? sku.shortSizeCode : sku.sizeCode;
    
    
    return view;
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
    
    !self.block?:self.block();
    
//        }];
//    });
    
    
}

@end




