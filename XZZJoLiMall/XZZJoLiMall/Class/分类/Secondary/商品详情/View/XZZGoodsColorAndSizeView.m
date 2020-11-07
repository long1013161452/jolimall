//
//  XZZGoodsColorAndSizeView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/22.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGoodsColorAndSizeView.h"


@interface XZZGoodsColorAndSizeView ()

/**
 * 占位图
 */
@property (nonatomic, strong)UIView * placeholderView;
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
 * 颜色边框视图
 */
@property (nonatomic, strong)UIView * colorBorderView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * sizeViewArray;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * selectedSizeButton;

/**
 * 尺码边框视图
 */
@property (nonatomic, strong)UIView * sizeBorderView;
/**
 * 选中的尺寸信息
 */
@property (nonatomic, strong)XZZSize * seSize;

@end

@implementation XZZGoodsColorAndSizeView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZGoodsColorAndSizeView * view = [super allocInitWithFrame:frame];
    view.goods = nil;
    return view;
}

- (void)setGoods:(XZZGoodsDetails *)goods
{
    _goods = goods;
    
    [self.placeholderView removeFromSuperview];
    [self removeAllSubviews];
    
    [self addView];

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

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView * colorView = [self createColorViewInformation];
    [self addSubview:colorView];

    UIView * sizeView = [self createSizeViewInformation];
    sizeView.top = colorView.bottom;
    [self addSubview:sizeView];

    UIView * numView = [self createNumViewInformation];
    numView.top = sizeView.bottom;
    [self addSubview:numView];
    
    float height = 45;
    float width = (ScreenWidth - 16 * 2);
    UIButton * buyNowButton = [UIButton allocInitWithTitle:@"Buy Now" color:kColor(0xffffff) selectedTitle:@"Buy Now" selectedColor:kColor(0xffffff) font:18];
    buyNowButton.titleLabel.font = textFont_bold(18);
    buyNowButton.frame = CGRectMake(16, numView.bottom, width, height);
    [buyNowButton addTarget:self action:@selector(clickOnBuyNewButton) forControlEvents:(UIControlEventTouchUpInside)];
    buyNowButton.backgroundColor = kColor(0xf41c19);
    buyNowButton.layer.cornerRadius = height / 2.0;;
    buyNowButton.layer.masksToBounds = YES;
    [self addSubview:buyNowButton];
    
    UIButton * addCartButton = [UIButton allocInitWithTitle:@"Add To Cart" color:kColor(0xf41c19) selectedTitle:@"Add To Cart" selectedColor:kColor(0xf41c19) font:18];
    addCartButton.titleLabel.font = textFont_bold(18);
    addCartButton.frame = CGRectMake(16, buyNowButton.bottom+ 16, width, height);
    [addCartButton addTarget:self action:@selector(clickOnAddToCart) forControlEvents:(UIControlEventTouchUpInside)];
    addCartButton.layer.borderColor = kColor(0xf41c19).CGColor;
    addCartButton.layer.borderWidth = .5;
    addCartButton.layer.cornerRadius = height / 2.0;
    addCartButton.layer.masksToBounds = YES;
    [self addSubview:addCartButton];
    

    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, addCartButton.bottom + 20, ScreenWidth, 8)];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    self.height = dividerView.bottom;
    
    !self.refresh?:self.refresh();
    
    
}

- (void)clickOnBuyNewButton
{
    !self.buyNew?:self.buyNew();
}

- (void)clickOnAddToCart
{
    !self.addToCart?:self.addToCart();
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
    
    CGFloat border = 3;
    self.colorBorderView = [UIView allocInitWithFrame:CGRectMake(left - border, top - border, 10, 10)];
    self.colorBorderView.layer.borderColor = Selling_price_color.CGColor;
    self.colorBorderView.layer.borderWidth = .5;
    [view addSubview:self.colorBorderView];
    self.colorBorderView.hidden = YES;
    
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
        if (self.colorBorderView.right <= backView.right) {
            self.colorBorderView.width = backView.right - self.colorBorderView.left + border;
        }
        
        if (self.colorBorderView.bottom <= backView.bottom) {
            self.colorBorderView.height = backView.bottom - self.colorBorderView.top + border;
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
    self.colorBorderView.hidden = YES;
    NSLog(@"%s %d 行", __func__, __LINE__);
    if ([self.selectedColorView isEqual:tap.view] || !tap) {

    }else{
        self.selectedColorView.layer.borderColor = kColor(0xeaeaea).CGColor;
        XZZColor * color = self.goods.colorInforArray[tap.view.tag];
        self.selectedColorView = tap.view;
        self.selectedColorView.layer.borderColor = kColor(0xff4444).CGColor;
        self.seColor = color;
        !self.chooseColor?:self.chooseColor(color);
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
        self.selectedSizeButton = nil;
        self.seSize = nil;
        !self.chooseSize?:self.chooseSize(nil);
    }
    
    
    
    
    
}

- (UIView *)createSizeViewInformation
{
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UILabel * sizeLabel = [UILabel labelWithFrame:CGRectMake(16, 10, 200, 15) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    sizeLabel.text = @"Size";
    [view addSubview:sizeLabel];
    
    
    
    if (self.goods.goods.sizeTypeCodePicture.length) {
        UIButton * sizeGuideButton = [UIButton allocInitWithFrame:CGRectMake(self.width - 70 - 15 - 7, sizeLabel.top, 70, 20)];
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
    
    
    CGFloat Border = 3;
    self.sizeBorderView = [UIView allocInitWithFrame:CGRectMake(left - Border, top - Border, 10, 10)];
    self.sizeBorderView.layer.borderWidth = .5;
    self.sizeBorderView.layer.borderColor = Selling_price_color.CGColor;
    [view addSubview:self.sizeBorderView];
    self.sizeBorderView.hidden = YES;
    
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
        
        if (self.sizeBorderView.right <= button.right) {
            self.sizeBorderView.width = button.right - self.sizeBorderView.left + Border;
        }
        if (self.sizeBorderView.bottom <= button.bottom) {
            self.sizeBorderView.height = button.bottom - self.sizeBorderView.top + Border;
        }
        
        tag++;
        left = button.right + interval;
        top = button.top;
        bottom = button.bottom;
    }
    self.sizeViewArray = array.copy;
    view.height = bottom;
    
    
    return view;
}

- (void)selectSizeInforButton:(UIButton *)button
{
    self.sizeBorderView.hidden = YES;
    NSLog(@"%s %d 行", __func__, __LINE__);
    self.selectedSizeButton.selected = NO;
    self.selectedSizeButton.backgroundColor = BACK_COLOR;
    if ([self.selectedSizeButton isEqual:button]) {
        self.selectedSizeButton = nil;
        !self.chooseSize?:self.chooseSize(nil);
        self.seSize = nil;
    }else{
        button.backgroundColor = button_back_color;
        button.selected = YES;
        XZZSize * size = self.goods.sizeInforArray[button.tag];
        self.seSize = size;
        self.selectedSizeButton = button;
        !self.chooseSize?:self.chooseSize(size);
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
    self.numLabel.layer.borderWidth = 1;
    self.numLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    [backView addSubview:self.numLabel];
    
//    if (!my_AppDelegate.iskol) {
        self.couponsButton = [UIButton allocInitWithFrame:CGRectMake(self.width - 65 - 5 - 12, backView.top, 70, backView.height)];
        [self.couponsButton setTitle:@"Coupon" forState:(UIControlStateNormal)];
        [self.couponsButton setTitleColor:button_back_color forState:(UIControlStateNormal)];
        self.couponsButton.titleLabel.font = textFont(12);
        [self.couponsButton addTarget:self action:@selector(clickOnCoupons) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:self.couponsButton];
        self.couponsButton.hidden = YES;
    
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 15, 15) imageName:@"goods_details_size_guide"];
    imageView.centerY = self.couponsButton.height / 2.0;
    imageView.left = self.couponsButton.width - 15;
    [self.couponsButton addSubview:imageView];
//    }

    
    
    return view;
}

- (void)clickOnCoupons
{
    !self.couponsBack?:self.couponsBack();
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

#pragma mark ---- *  提示选中尺码或颜色
/**
 *  提示选中尺码或颜色
 */
- (void)promptsSelectColorOrSize
{
    return;
    if (!self.selectedColorView) {
        self.colorBorderView.hidden = NO;
    }
    
    if (!self.selectedSizeButton) {
        self.sizeBorderView.hidden = NO;
    }
}


@end
