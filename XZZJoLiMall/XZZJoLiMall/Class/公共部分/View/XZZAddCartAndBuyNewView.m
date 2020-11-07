//
//  XZZAddCartAndBuyNewView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/9.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddCartAndBuyNewView.h"


@interface XZZAddCartAndBuyNewView ()

/**
 * 背景视图
 */
@property (nonatomic, strong)UIView * backView;

/**
 * 尺寸背景视图
 */
@property (nonatomic, strong)UIView * sizeAndColorBackView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * colorViewArray;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * selectedColorView;
/**
 * 选中的颜色信息
 */
@property (nonatomic, strong)XZZColor * seColor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * sizeViewArray;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * selectedSizeButton;
/**
 * 选中的尺寸信息
 */
@property (nonatomic, strong)XZZSize * seSize;





/**
 * 展示颜色尺码信息
 */
@property (nonatomic, strong)XZZChooseColorAndSizeView * colorAndSizeView;


/**
 * 展示图片信息
 */
@property (nonatomic, strong)FLAnimatedImageView * goodsImageView;

/**
 * 展示价格信息
 */
@property (nonatomic, strong)UILabel * priceLabel;

/**
 * 原价  虚价 价格信息
 */
@property (nonatomic, strong)UILabel * originalPriceLabel;


@end

@implementation XZZAddCartAndBuyNewView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZAddCartAndBuyNewView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}



- (void)setGoods:(XZZGoodsDetails *)goods
{
    _goods = goods;
    [self.goodsImageView addImageFromUrlStr:goods.goods.pictureUrl];

    [self.scrollView removeAllSubviews];
    self.selectedColorView = nil;
    UIView * colorView = [self createColorViewInformation];
    [self.scrollView addSubview:colorView];
    
    UIView * sizeView = [self createSizeViewInformation];
    sizeView.top = colorView.bottom;
    [self.scrollView addSubview:sizeView];
    
    UIView * numView = [self createNumViewInformation];
    numView.top = sizeView.bottom;
    [self.scrollView addSubview:numView];
    self.scrollView.contentSize = CGSizeMake(0, numView.bottom + 40);
    
    
    if (goods.goods.discountPercent > 0) {
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goods.goods.discountPrice];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goods.goods.currentPrice];
    }
    if (goods.goods.nominalPrice > 0) {
        self.originalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", goods.goods.nominalPrice];
    }else{
        self.originalPriceLabel.text = @"";
    }
    
    XZZSku * sku = nil;
    for (XZZSku * sku2 in self.goods.skuList) {
        if (sku2.status) {
            sku = sku2;
            break;
        }
    }
    int i = 0;
    for (XZZColor * color in goods.colorInforArray) {
        if ([color.colorCode isEqualToString:sku.colorCode]) {
            [self clickOnChooseColor:self.colorViewArray[i]];
            break;
        }
        i++;
    }
    
    i = 0;
    for (XZZSize * size in goods.sizeInforArray) {
        if ([size.sizeCode isEqualToString:sku.sizeCode]) {
            [self selectSizeInforButton:self.sizeViewArray[i]];
            break;
        }
        i++;
    }
    
}

- (void)selectedColor:(XZZColor *)color size:(nonnull XZZSize *)size
{
    if (color) {
        for (int i = 0; i < self.goods.colorInforArray.count; i++) {
            XZZColor * colorTwo = self.goods.colorInforArray[i];
            if ([colorTwo.colorCode isEqualToString:color.colorCode]) {
                self.selectedColorView.layer.borderWidth = 0;
                self.selectedColorView = nil;
                [self clickOnChooseColor:self.colorViewArray[i]];
                break;
            }
        }
    }else{
        [self clickOnChooseColor:nil];
    }
    
}

- (void)setButtonType:(XZZAddCartAndBuyNewButtonType)buttonType
{
    self.addCartAndBuyButtonView.buttonType = buttonType;
}

- (void)addView{
    [self removeAllSubviews];
    WS(wSelf)
    self.backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.backView.backgroundColor = kColorWithRGB(0, 0, 0, .55);
    [self.backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:self.backView];
    
    self.sizeAndColorBackView = [UIView allocInitWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * (1.1 / 2.0))];
    self.sizeAndColorBackView.backgroundColor = kColor(0xffffff);
    [self addSubview:self.sizeAndColorBackView];
    
    
    UIButton * shutDownButton = [UIButton allocInitWithImageName:@"home_Shun_down" selectedImageName:@"home_Shun_down"];
    shutDownButton.frame = CGRectMake(self.sizeAndColorBackView.width - 32, 16, 16, 16);
    [shutDownButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.sizeAndColorBackView addSubview:shutDownButton];
    

    self.goodsImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(10, 10, 36, 48)];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.goodsImageView.clipsToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 4;
    [self.sizeAndColorBackView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.equalTo(@16);
        make.width.equalTo(@90);
        make.height.equalTo(@90);
    }];
    
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self.sizeAndColorBackView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.goodsImageView.mas_right).offset(15);
    }];
    
    self.originalPriceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:original_price_color textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self.sizeAndColorBackView addSubview:self.originalPriceLabel];
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.priceLabel).offset(2);
        make.bottom.equalTo(wSelf.goodsImageView).offset(-5);
        make.top.equalTo(wSelf.priceLabel.mas_bottom).offset(8);
    }];
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0)];
    dividerView.backgroundColor = original_price_color;
    [self.sizeAndColorBackView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wSelf.originalPriceLabel);
        make.left.equalTo(wSelf.originalPriceLabel).offset(-1);
        make.height.equalTo(@.5);
    }];
    
    UIView * dividerView2 = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0)];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self.sizeAndColorBackView addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@.0);
        make.top.equalTo(wSelf.goodsImageView.mas_bottom).offset(10);
    }];
    weakView(weak_dividerView2, dividerView2)
    self.scrollView = [UIScrollView allocInit];
    [self.sizeAndColorBackView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_dividerView2.mas_bottom);
    }];
    
    self.addCartAndBuyButtonView = [XZZAddCartAndBuyNewButtonView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    self.addCartAndBuyButtonView.buttonType = XZZAddCartAndBuyNewButtonTypeNone;
    [self.sizeAndColorBackView addSubview:self.addCartAndBuyButtonView];
    [self.addCartAndBuyButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(wSelf.scrollView.mas_bottom);
        make.bottom.equalTo(wSelf.sizeAndColorBackView);
    }];

}



- (UIView *)createColorViewInformation
{
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UILabel * colorLabel = [UILabel labelWithFrame:CGRectMake(16, 10, 200, 15) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    colorLabel.text = @"Color";
    [view addSubview:colorLabel];
    
    CGFloat left = colorLabel.left;
    CGFloat top = colorLabel.bottom + 10;
    CGFloat width = 45;
    CGFloat height = 45;
    CGFloat interval = 16;
    CGFloat bottom = colorLabel.bottom;
    NSInteger tag = 0;
    
    
    NSMutableArray * array = @[].mutableCopy;
    
    for (XZZColor * color in self.goods.colorInforArray) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnChooseColor:)];
        UIView * backView = [UIView allocInitWithFrame:CGRectMake(left, top, width, height)];
        backView.tag = tag;
        backView.layer.borderColor = kColor(0xeaeaea).CGColor;
        backView.layer.cornerRadius = width / 2.0;
        backView.layer.masksToBounds = YES;
        backView.layer.borderWidth = 1;

        [backView addGestureRecognizer:tap];
        [view addSubview:backView];
        
        NSString * picture = color.smallMainPicture;
        FLAnimatedImageView * colorImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(2, 2, width - 4, height - 4)];
        [colorImageView addImageFromUrlStr:picture];
        colorImageView.layer.cornerRadius = (width - 4) / 2.0;
        colorImageView.layer.masksToBounds = YES;
        colorImageView.contentMode = UIViewContentModeScaleAspectFill;
        colorImageView.clipsToBounds = YES;
        [backView addSubview:colorImageView];
        [array addObject:tap];
        
        if (backView.right + interval > self.width) {
            backView.top += (height + interval);
            backView.left = colorLabel.left;
        }
        tag++;
        top = backView.top;
        left = backView.right + interval;
        bottom = backView.bottom + 10;
    }
    self.colorViewArray = array.copy;

    view.height = bottom;
    
    
    return view;
}

- (void)clickOnChooseColor:(UITapGestureRecognizer *)tap
{
    NSLog(@"%s %d 行", __func__, __LINE__);
        if ([self.selectedColorView isEqual:tap.view] || !tap) {
            return;
            [self.goodsImageView addImageFromUrlStr:self.goods.goods.smallPictureUrl];
            self.selectedColorView = nil;
            self.seColor = nil;
            !self.selectedColor?:self.selectedColor(nil);
        }else{
            self.selectedColorView.layer.borderColor = kColor(0xeaeaea).CGColor;
            XZZColor * color = self.goods.colorInforArray[tap.view.tag];
            NSString * picture = color.smallMainPicture;
            [self.goodsImageView addImageFromUrlStr:picture];
            self.selectedColorView = tap.view;
            self.selectedColorView.layer.borderColor = kColor(0xff4444).CGColor;
            self.seColor = color;
            !self.selectedColor?:self.selectedColor(color);
    }

    
    
    

    
    NSDictionary * sizeCodeDic = self.goods.colorCodeDictionary[self.seColor.colorCode];
    int i = 0;
    for (XZZSize * size in self.goods.sizeInforArray) {
        UIButton * button = self.sizeViewArray[i];
        if (!sizeCodeDic[size.sizeCode] && self.seColor) {
            button.userInteractionEnabled = NO;
            [button setTitleColor:kColor(0xcccccc) forState:(UIControlStateNormal)];

        }else{
            button.userInteractionEnabled = YES;
            [button setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
        }
        i++;
    }
    
    if (sizeCodeDic[self.seSize.sizeCode] || !self.seColor) {
        self.selectedSizeButton.backgroundColor = button_back_color;
        self.selectedSizeButton.selected = YES;
        self.selectedSizeButton.layer.borderWidth = 0;
    }else{
        self.selectedSizeButton.userInteractionEnabled = NO;
        self.selectedSizeButton.selected = NO;
        [self.selectedSizeButton setTitleColor:kColor(0x323232) forState:(UIControlStateNormal)];
        self.selectedSizeButton.backgroundColor = kColor(0xf4f4f4);
        self.selectedSizeButton.layer.borderColor = DIVIDER_COLOR.CGColor;
        self.selectedSizeButton = nil;
        self.seSize = nil;
        !self.selectedSize?:self.selectedSize(nil);
    }
    
    
    
    
    
}

- (UIView *)createSizeViewInformation
{
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UILabel * sizeLabel = [UILabel labelWithFrame:CGRectMake(16, 10, 200, 15) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    sizeLabel.text = @"Size";
    [view addSubview:sizeLabel];
    
    
    
    if (self.goods.goods.sizeTypeCodePicture.length) {
        UIButton * sizeGuideButton = [UIButton allocInitWithFrame:CGRectMake(self.width - 70 - 15 - 6, sizeLabel.top, 70, 20)];
        [sizeGuideButton setTitle:@"Size Guide" forState:(UIControlStateNormal)];
        [sizeGuideButton setTitleColor:button_back_color forState:(UIControlStateNormal)];
        sizeGuideButton.titleLabel.font = textFont(12);
        [sizeGuideButton addTarget:self action:@selector(clickOnSizeGuide) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:sizeGuideButton];
        
        UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 15, 15) imageName:@"goods_details_size_guide"];
        imageView.centerY = sizeGuideButton.centerY;
        imageView.left = sizeGuideButton.right - 7;
        [view addSubview:imageView];
    }
    
    
    CGFloat left = sizeLabel.left;
    CGFloat top = sizeLabel.bottom + 10;
    CGFloat width = 45;
    CGFloat height = 45;
    CGFloat bottom = sizeLabel.bottom;
    CGFloat interval = 15;
    NSInteger tag = 0;
    
    
    NSMutableArray * array = @[].mutableCopy;
    for (XZZSize * size in self.goods.sizeInforArray) {
        UIButton * button = [UIButton allocInitWithTitle:size.shortSizeCode color:kColor(0x000000) selectedTitle:size.shortSizeCode selectedColor:kColor(0xffffff) font:14];
        button.frame = CGRectMake(left, top, width, height);
        if ([size.shortSizeCode isEqualToString:@"One size"]) {
            button.width = 100;
        }
        [button addTarget:self action:@selector(selectSizeInforButton:) forControlEvents:(UIControlEventTouchUpInside)];
        button.backgroundColor = BACK_COLOR;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = height / 2.0;
        [view addSubview:button];
        [array addObject:button];
        button.tag = tag;

        UIView * roundView = [UIView allocInitWithFrame:CGRectMake(1, 1, button.width - 2, button.height - 2)];
        roundView.layer.borderColor = [UIColor whiteColor].CGColor;
        roundView.layer.borderWidth = 2;
        roundView.layer.masksToBounds = YES;
        roundView.layer.cornerRadius = roundView.height / 2.0;
        roundView.userInteractionEnabled = NO;
        [button addSubview:roundView];
        
        if (button.right + interval > view.width) {
            button.left = sizeLabel.left;
            button.top += (height + interval);
        }
        
        tag++;
        left = button.right + interval;
        top = button.top;
        bottom = button.bottom + 10;
    }
    self.sizeViewArray = array.copy;
    view.height = bottom;
    
    
    return view;
}

- (void)selectSizeInforButton:(UIButton *)button
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    self.selectedSizeButton.selected = NO;
    self.selectedSizeButton.backgroundColor = BACK_COLOR;
    if ([self.selectedSizeButton isEqual:button]) {
        self.selectedSizeButton = nil;
        !self.selectedSize?:self.selectedSize(nil);
        self.seSize = nil;
    }else{
        button.backgroundColor = button_back_color;
        button.selected = YES;
        XZZSize * size = self.goods.sizeInforArray[button.tag];
        self.seSize = size;
        self.selectedSizeButton = button;
        !self.selectedSize?:self.selectedSize(size);
    }

    NSDictionary * sizeCodeDictionary = self.goods.sizeCodeDictionary[self.seSize.sizeCode];
    int i = 0;
    for (XZZColor * color in self.goods.colorInforArray) {
        UITapGestureRecognizer * tap = self.colorViewArray[i];
        UIImageView * imageView = tap.view;
        UIView * view = [imageView viewWithTag:10000];
        [view removeFromSuperview];
        if (sizeCodeDictionary[color.colorCode] || !self.seSize) {
            imageView.userInteractionEnabled = YES;
        }else{
            if (!view) {
                view = [UIView allocInitWithFrame:CGRectMake(0, 0, imageView.width, imageView.height)];
                view.backgroundColor = kColorWithRGB(256, 256, 256, .6);
                view.tag = 10000;
            }
            [imageView addSubview:view];
            imageView.userInteractionEnabled = NO;
        }
        i++;
    }
}

- (void)clickOnSizeGuide
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    !self.sizeGuide?:self.sizeGuide();
}


- (UIView *)createNumViewInformation
{
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UILabel * numLabel = [UILabel labelWithFrame:CGRectMake(16, 10, 200, 15) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    numLabel.text = @"Qty";
    [view addSubview:numLabel];
    
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(numLabel.left, numLabel.bottom + 15, 36 * 3, 36)];
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = BACK_COLOR;
    backView.layer.cornerRadius = 18;
    [view addSubview:backView];
    
    UIButton * reductionButton = [UIButton allocInitWithTitle:@"-" color:kColor(0x000000) selectedTitle:@"-" selectedColor:kColor(0x000000) font:18];
    reductionButton.frame = CGRectMake(0, 0, backView.width / 3, backView.height);
    [reductionButton addTarget:self action:@selector(reduceNumber) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:reductionButton];
    
    UIButton * addButton = [UIButton allocInitWithTitle:@"+" color:kColor(0x000000) selectedTitle:@"+" selectedColor:kColor(0x000000) font:18];
    addButton.frame = CGRectMake(backView.width / 3 * 2, 0, backView.width / 3, backView.height);
    [addButton addTarget:self action:@selector(IncreaseQuantity) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:addButton];
    
    self.numLabel = [UILabel labelWithFrame:CGRectMake(reductionButton.right, -1, reductionButton.width, reductionButton.height + 2) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.numLabel.text = @"1";
    self.numLabel.layer.borderWidth = .5;
    self.numLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    [backView addSubview:self.numLabel];
    
    return view;
}

- (void)IncreaseQuantity
{
    int num = self.numLabel.text.intValue;
    num++;
    self.numLabel.text = [NSString stringWithFormat:@"%d", num];
    
}

- (void)reduceNumber
{
    int num = self.numLabel.text.intValue;
    if (num <= 1) {
        return;
    }
    num--;
    self.numLabel.text = [NSString stringWithFormat:@"%d", num];
}

- (void)setSelectedSku:(XZZSku *)selectedSku
{
    if (selectedSku) {
        _selectedSku = selectedSku;

    }
}

- (void)setBuyNew:(GeneralBlock)buyNew
{
    self.addCartAndBuyButtonView.buyNew = buyNew;
}

- (void)setAddToCart:(GeneralBlock)addToCart
{
    self.addCartAndBuyButtonView.addToCart = addToCart;
}

- (void)setGoCart:(GeneralBlock)goCart
{
    self.addCartAndBuyButtonView.goShopingCart = goCart;
}

/**
 *  加购和购买  用于修改y按钮颜色
 */
- (void)whetherCanAddShoppingCartAndBuy:(BOOL)is
{
    [self.addCartAndBuyButtonView whetherCanAddShoppingCartAndBuy:is];
    return;
    if (is) {
        self.addCartAndBuyButtonView.addToCartButton.backgroundColor = kColor(0xff8a00);
        self.addCartAndBuyButtonView.addToCartTwoButton.backgroundColor = kColor(0xff8a00);
        self.addCartAndBuyButtonView.buyNewButton.backgroundColor = button_back_color;
        self.addCartAndBuyButtonView.buyNewTwoButton.backgroundColor = button_back_color;
    }else{
        self.addCartAndBuyButtonView.addToCartButton.backgroundColor = kColor(0xc4c4c4);
        self.addCartAndBuyButtonView.addToCartTwoButton.backgroundColor = kColor(0xc4c4c4);
        self.addCartAndBuyButtonView.buyNewButton.backgroundColor = kColor(0x989898);
        self.addCartAndBuyButtonView.buyNewTwoButton.backgroundColor = kColor(0x989898);
    }
}



/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        [UIView animateWithDuration:.3 animations:^{
            wSelf.sizeAndColorBackView.bottom = ScreenHeight;
        }];
    });
}

/**
 * 移除视图
 */
- (void)removeView
{
    WS(wSelf)    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            wSelf.sizeAndColorBackView.top = ScreenHeight;
        } completion:^(BOOL finished) {
            [wSelf removeFromSuperview];
        }];
    });
    
}


@end



