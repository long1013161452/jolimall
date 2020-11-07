//
//  XZZCartListTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCartListTableViewCell.h"

@interface XZZCartListTableViewCell ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * selectedButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * goodsImageView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * soldOutLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * nameLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * collectionButton;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * sizeAndColorLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * sizeLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * colorLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * priceLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * originalPriceLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * reductionButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * addButton;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * numLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * flashDealsView;

@end

@implementation XZZCartListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCartInfor:(XZZCartInfor *)cartInfor
{
    _cartInfor = cartInfor;
    
    if (!self.selectedButton) {
        [self addViewNew];
    }
    
    [self.goodsImageView addImageFromUrlStr:cartInfor.mainPicture];
    self.nameLabel.text = cartInfor.goodsTitle;
    self.numLabel.text = [NSString stringWithFormat:@"%ld", (long)cartInfor.skuNum];
    self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", cartInfor.skuPrice];
    if (self.cartInfor.skuNominalPrice > 0) {
        self.originalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", cartInfor.skuNominalPrice];
    }else{
        self.originalPriceLabel.text = @"";
    }
    
    
    self.collectionButton.selected = StateCollectionGoodsId(cartInfor.goodsId);
    
    if (cartInfor.skuNum == 1 || cartInfor.status == 0) {
        [self.reductionButton setImage:imageName(@"cart_goods_delete") forState:(UIControlStateNormal)];
        [self.reductionButton setTitle:@"" forState:(UIControlStateNormal)];
    }else{
        [self.reductionButton setImage:nil forState:(UIControlStateNormal)];
        [self.reductionButton setTitle:@"-" forState:(UIControlStateNormal)];
    }
    NSString * sizeAndColor = @"";
    NSString * colorName = cartInfor.colorName;//GoodsCodeName(cartInfor.colorCode);
    if (colorName.length) {
        sizeAndColor = [NSString stringWithFormat:@"Color: %@", colorName];
    }
    
    sizeAndColor = [NSString stringWithFormat:@"%@  Size: %@", sizeAndColor, cartInfor.shortSizeCode.length > 0 ? cartInfor.shortSizeCode : cartInfor.sizeCode];
    
    
    if (self.cartInfor.secKillVo) {//秒杀商品
        [self.flashDealsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@80);
        }];
        self.priceLabel.textColor = button_back_color;
        self.flashDealsView.hidden = NO;
    }else{
        [self.flashDealsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
        self.priceLabel.textColor = Selling_price_color;
        self.flashDealsView.hidden = YES;
    }
    self.sizeAndColorLabel.text = sizeAndColor;
    
    self.colorLabel.text = colorName;
    self.sizeLabel.text = cartInfor.shortSizeCode.length ? cartInfor.shortSizeCode : cartInfor.sizeCode;
    
    self.selectedButton.selected = [all_cart isSelectedCart:cartInfor];
    
    if (cartInfor.status == 0) {
        self.soldOutLabel.hidden = NO;
        self.selectedButton.hidden = YES;
        self.backView.hidden = NO;
        self.addButton.userInteractionEnabled = NO;
    }else{
        self.soldOutLabel.hidden = YES;
        self.selectedButton.hidden = NO;
        self.backView.hidden = YES;
        self.addButton.userInteractionEnabled = YES;
    }
    
    return;
    if (cartInfor.status == 0) {
        self.selectedButton.hidden = YES;
        self.nameLabel.textColor = kColor(0xadadad);
        self.sizeAndColorLabel.textColor = kColor(0xadadad);
        self.priceLabel.textColor = kColor(0xadadad);
        self.originalPriceLabel.textColor = kColor(0xadadad);
        self.numLabel.hidden = YES;
        self.addButton.hidden = YES;
        self.collectionButton.hidden = YES;
        [self.reductionButton setImage:imageName(@"cart_goods_delete") forState:(UIControlStateNormal)];
        [self.reductionButton setTitle:@"" forState:(UIControlStateNormal)];
        self.soldOutLabel.hidden = NO;
    }else{
        self.selectedButton.hidden = NO;
        self.nameLabel.textColor = kColor(0x505050);
        self.sizeAndColorLabel.textColor = kColor(0x000000);
        self.priceLabel.textColor = Selling_price_color;
        self.originalPriceLabel.textColor = kColor(0x767676);
        self.numLabel.hidden = NO;
        self.addButton.hidden = NO;
        self.collectionButton.hidden = NO;
        self.soldOutLabel.hidden = YES;
    }
}

- (void)addViewNew
{
    
    WS(wSelf)
    
    self.selectedButton = [UIButton allocInitWithImageName:@"cart_goods_no_selected" selectedImageName:@"cart_goods_selected"];
    [self.selectedButton addTarget:self action:@selector(clickOnSelectedCartButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.selectedButton];
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(wSelf);
        make.width.equalTo(@40);
    }];
    
    self.goodsImageView = [FLAnimatedImageView allocInit];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.goodsImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.goodsImageView.layer.masksToBounds = YES;
    [self.goodsImageView cutRounded:5];
    [self addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.selectedButton.mas_right);
        make.top.equalTo(@16);
        make.bottom.equalTo(wSelf).offset(-16);
        make.width.equalTo(@90);
        make.height.equalTo(@120);
    }];
    

    
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.goodsImageView).offset(3);
        make.right.equalTo(wSelf).offset(-16);
        make.left.equalTo(wSelf.goodsImageView.mas_right).offset(12);
    }];
    
    self.flashDealsView = [UIView allocInit];
    [self addSubview:self.flashDealsView];
    [self.flashDealsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.nameLabel);
        make.height.equalTo(@18);
        make.width.equalTo(@0);
    }];
    
    UILabel * flashDealsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:button_back_color textColor:kColor(0xffffff) textFont:12 textAlignment:(NSTextAlignmentCenter) tag:1];
    flashDealsLabel.text = @"Flash Deals";
    [flashDealsLabel cutRounded:9];
    [self.flashDealsView addSubview:flashDealsLabel];
    [flashDealsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@75);
        make.height.equalTo(@18);
    }];

    
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.priceLabel.font = textFont_bold(14);
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.flashDealsView.mas_right);
        make.top.equalTo(wSelf.nameLabel.mas_bottom).offset(6);
        make.centerY.equalTo(wSelf.flashDealsView);
    }];
    
    
    self.originalPriceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:original_price_color textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.originalPriceLabel.font = original_price_font;
    [self addSubview:self.originalPriceLabel];
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.priceLabel).offset(-1);
        make.left.equalTo(wSelf.priceLabel.mas_right).offset(10);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = self.originalPriceLabel.textColor;
    [self.originalPriceLabel addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(wSelf.originalPriceLabel);
        make.height.equalTo(@.5);
    }];
    
    UILabel * colorLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    colorLabel.text = @"Color: ";
    [self addSubview:colorLabel];
    [colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.nameLabel);
        make.top.equalTo(wSelf.priceLabel.mas_bottom).offset(10);
    }];

    weakView(weak_colorLabel, colorLabel)
    self.colorLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.colorLabel];
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_colorLabel.mas_right);
        make.top.equalTo(weak_colorLabel);
    }];
    
    UILabel * sizeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    sizeLabel.text = @"Size: ";
    [self addSubview:sizeLabel];
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.colorLabel.mas_right).offset(10);
        make.top.equalTo(weak_colorLabel);
    }];
    
    weakView(weak_sizeLabel, sizeLabel)
    self.sizeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.sizeLabel];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_sizeLabel.mas_right);
        make.top.equalTo(weak_colorLabel);
    }];
    
    
    UIView * buttonBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, 32 * 3, 32)];
    buttonBackView.layer.cornerRadius = 16;
    buttonBackView.layer.masksToBounds = YES;
    buttonBackView.backgroundColor = BACK_COLOR;
    [self addSubview:buttonBackView];
    [buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.goodsImageView);
        make.left.equalTo(wSelf.nameLabel);
        make.width.equalTo(@96);
        make.height.equalTo(@32);
    }];
    
    weakView(weak_buttonBackView, buttonBackView)
    self.reductionButton = [UIButton allocInitWithImageName:@"cart_goods_delete" selectedImageName:@""];
    [self.reductionButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    self.reductionButton.titleLabel.font = textFont(20);
    [self.reductionButton addTarget:self action:@selector(clickOnReductionButton) forControlEvents:(UIControlEventTouchUpInside)];
    [buttonBackView addSubview:self.reductionButton];
    [self.reductionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@2);
        make.width.equalTo(@30);
        make.height.equalTo(weak_buttonBackView).offset(-2);
    }];
    
    self.numLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    [self addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.reductionButton.mas_right);
        make.centerY.equalTo(weak_buttonBackView);
        make.width.equalTo(@32);
    }];
    
    self.addButton = [UIButton allocInitWithTitle:@"+" color:kColor(0x000000) selectedTitle:@"+" selectedColor:kColor(0x000000) font:20];
    [self.addButton addTarget:self action:@selector(clickOnAddCartButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.numLabel.mas_right);
        make.width.equalTo(@30);
        make.top.equalTo(wSelf.reductionButton);
        make.bottom.equalTo(wSelf.reductionButton);
    }];
    
    UIView * numDividerView = [UIView allocInit];
    numDividerView.backgroundColor = [UIColor whiteColor];
    [buttonBackView addSubview:numDividerView];
    [numDividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.numLabel);
        make.top.equalTo(@0);
        make.centerY.equalTo(wSelf.numLabel);
        make.width.equalTo(@1);
    }];
    
    UIView * numDividerView2 = [UIView allocInit];
    numDividerView2.backgroundColor = [UIColor whiteColor];
    [buttonBackView addSubview:numDividerView2];
    [numDividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.numLabel);
        make.top.equalTo(@0);
        make.centerY.equalTo(wSelf.numLabel);
        make.width.equalTo(@1);
    }];
    
    
    self.backView = [UIView allocInit];
    self.backView.backgroundColor = kColorWithRGB(255, 255, 255, .5);
    [self addSubview:self.backView];
    self.backView.hidden = YES;
    self.backView.userInteractionEnabled = NO;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.centerX.centerY.equalTo(wSelf);
    }];
    
    self.soldOutLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:11 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.soldOutLabel.text = @"Sold out";
    self.soldOutLabel.font = textFont_bold(14);
    self.soldOutLabel.backgroundColor = kColorWithRGB(0, 0, 0, .1);
    [self.soldOutLabel cutRounded:10];
    [self addSubview:self.soldOutLabel];
    [self.soldOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.left.top.equalTo(wSelf.goodsImageView);
//        make.height.equalTo(@20);
//        make.width.equalTo(@60);
    }];
    
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.goodsImageView);
        make.bottom.equalTo(wSelf);
        make.right.equalTo(wSelf).offset(-16);
        make.height.equalTo(@.5);
    }];
    
}


- (void)clickOnSelectedCartButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(SelectCartInfor:)]) {
        button.selected = [self.delegate SelectCartInfor:self.cartInfor];
    }
}


- (void)clickOnAddCartButton
{
    int count = self.numLabel.text.intValue;
    count++;
    self.numLabel.text = [NSString stringWithFormat:@"%d", count];
    self.cartInfor.skuNum = count;
    if ([self.delegate respondsToSelector:@selector(editCartInfor:count:)]) {
        [self.delegate editCartInfor:self.cartInfor count:YES];
    }
    [self.reductionButton setImage:nil forState:(UIControlStateNormal)];
    [self.reductionButton setTitle:@"-" forState:(UIControlStateNormal)];
}

- (void)clickOnReductionButton
{
    if (self.cartInfor.status == 0) {
        if ([self.delegate respondsToSelector:@selector(deleteCartInfor:)]) {
            [self.delegate deleteCartInfor:self.cartInfor];
        }
        return;
    }
    int count = self.numLabel.text.intValue;
    count--;
    
    if (count <= 0) {
        if ([self.delegate respondsToSelector:@selector(deleteCartInfor:)]) {
            [self.delegate deleteCartInfor:self.cartInfor];
        }
    }else{
        self.numLabel.text = [NSString stringWithFormat:@"%d", count];
        self.cartInfor.skuNum = count;
        if ([self.delegate respondsToSelector:@selector(editCartInfor:count:)]) {
            [self.delegate editCartInfor:self.cartInfor count:NO];
        }
    }
    if (count <= 1) {
            [self.reductionButton setImage:imageName(@"cart_goods_delete") forState:(UIControlStateNormal)];
            [self.reductionButton setTitle:@"" forState:(UIControlStateNormal)];
        }else{
            [self.reductionButton setImage:nil forState:(UIControlStateNormal)];
            [self.reductionButton setTitle:@"-" forState:(UIControlStateNormal)];
    }
}



- (void)clickOnCollection
{
    if ([self.delegate respondsToSelector:@selector(collectGoodsAccordingId:)]) {
        [self.delegate collectGoodsAccordingId:self.cartInfor.goodsId];
    }
}



@end
