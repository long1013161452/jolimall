//
//  XZZOrderGoodsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZOrderGoodsView.h"


@interface XZZOrderGoodsView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * imageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * nameLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * priceLabel;
/**
 * 推荐商品展示价格
 */
@property (nonatomic, strong)UILabel * freeGoodsPriceLabel;
/**
 * color label
 */
@property (nonatomic, strong)UILabel * colorLabel;

/**
 * size label
 */
@property (nonatomic, strong)UILabel * sizeLabel;

/**
 * num label
 */
@property (nonatomic, strong)UILabel * numLabel;
/**
 * 评论按钮
 */
@property (nonatomic, strong)UIButton * commentButton;
/**
 * 查看评论按钮
 */
@property (nonatomic, strong)UIButton * viewCommentButton;
/**
 * 商品下架
 */
@property (nonatomic, strong)UILabel * soldOutLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsId;

@end

@implementation XZZOrderGoodsView

+ (instancetype)allocInit
{
    XZZOrderGoodsView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewGoodsDetails:)]];
    
    
    self.imageView = [FLAnimatedImageView allocInit];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = 5;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.left.equalTo(@16);
        make.bottom.equalTo(wSelf).offset(-16);
        make.width.equalTo(@90);
        make.height.equalTo(@120);
    }];
    
    self.soldOutLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x000000) textColor:kColor(0xffffff) textFont:10 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.soldOutLabel.text = @"Sold out";
    self.soldOutLabel.layer.cornerRadius = 10;
    self.soldOutLabel.layer.masksToBounds = YES;
    [self addSubview:self.soldOutLabel];
    [self.soldOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@50);
        make.center.equalTo(wSelf.imageView);
    }];
    
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.imageView.mas_right).offset(10);
        make.top.equalTo(wSelf.imageView).offset(5);
        make.right.equalTo(wSelf).offset(-16);
    }];
    
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.priceLabel.font = textFont_bold(14);
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.nameLabel);
        make.height.equalTo(@20);
        make.top.equalTo(wSelf.nameLabel.mas_bottom).offset(5);
    }];
    
    self.freeGoodsPriceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:original_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.freeGoodsPriceLabel];
    [self.freeGoodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.priceLabel);
        make.left.equalTo(wSelf.priceLabel.mas_right).offset(10);
    }];
    
    UIView * freeGoodsPriceView = [UIView allocInit];
    freeGoodsPriceView.backgroundColor = self.freeGoodsPriceLabel.textColor;
    [self.freeGoodsPriceLabel addSubview:freeGoodsPriceView];
    [freeGoodsPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.centerX.equalTo(wSelf.freeGoodsPriceLabel);
        make.height.equalTo(@1);
    }];
    
    UILabel * colorLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    colorLabel.text = @"Color: ";
    [self addSubview:colorLabel];
    [colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.nameLabel);
        make.top.equalTo(wSelf.priceLabel.mas_bottom).offset(20);
    }];
    
    weakView(weak_colorLabel, colorLabel)
    self.colorLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.colorLabel];
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_colorLabel.mas_right);
        make.top.equalTo(weak_colorLabel);
    }];
    
    UILabel * sizeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    sizeLabel.text = @"Size: ";
    [self addSubview:sizeLabel];
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.colorLabel.mas_right).offset(5);
        make.top.equalTo(wSelf.colorLabel);
    }];
    
    weakView(weak_sizeLabel, sizeLabel)
    self.sizeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.sizeLabel];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_sizeLabel.mas_right);
        make.top.equalTo(weak_sizeLabel);
    }];
    
    UILabel * numLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    numLabel.text = @"Qty:";
    [self addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_colorLabel);
        make.bottom.equalTo(wSelf.imageView).offset(-5);
    }];
    
    weakView(weak_numLabel, numLabel)
    self.numLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_numLabel.mas_right);
        make.top.equalTo(weak_numLabel);
    }];
    
    
    self.commentButton = [UIButton allocInitWithTitle:@"Review" color:kColor(0xffffff) selectedTitle:@"Review" selectedColor:kColor(0xffffff) font:12];
    self.commentButton.hidden = YES;
    self.commentButton.titleLabel.font = textFont_bold(14);
    self.commentButton.backgroundColor = button_back_color;
    [self.commentButton addTarget:self action:@selector(clickOnCommentsGoodsButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.commentButton cutRounded:12];
    [self addSubview:self.commentButton];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.nameLabel.mas_right);
        make.height.equalTo(@24);
        make.width.equalTo(@65);
        make.bottom.equalTo(wSelf.numLabel);
    }];
    
    self.viewCommentButton = [UIButton allocInitWithTitle:@"View Reviews" color:button_back_color selectedTitle:@"View Reviews" selectedColor:button_back_color font:14];
    self.viewCommentButton.hidden = YES;
    [self.viewCommentButton addTarget:self action:@selector(clickOnCommentsGoodsButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.viewCommentButton cutRounded:12];
    self.viewCommentButton.layer.borderWidth = 0.5;
    self.viewCommentButton.layer.borderColor = button_back_color.CGColor;
    [self addSubview:self.viewCommentButton];
    [self.viewCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.nameLabel.mas_right);
        make.height.equalTo(@24);
        make.width.equalTo(@100);
        make.centerY.equalTo(wSelf.commentButton);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.imageView);
        make.right.bottom.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    
}


- (void)setCartInfor:(XZZCartInfor *)cartInfor
{
    _cartInfor = cartInfor;
    self.goodsId = cartInfor.goodsId;
    [self.imageView addImageFromUrlStr:cartInfor.mainPicture];
    self.nameLabel.text = cartInfor.goodsTitle;
    if (self.isFreeGoods) {
        self.freeGoodsPriceLabel.text = [NSString stringWithFormat:@"$%.2f", cartInfor.skuPrice];
        self.priceLabel.text = @"$0.00";
    }else{
    self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", cartInfor.skuPrice];
        self.freeGoodsPriceLabel.text = @"";
    }
    
    
    self.soldOutLabel.hidden = YES;
    
    NSString * colorName =  cartInfor.colorName;//GoodsCodeName(cartInfor.colorCode);
    self.colorLabel.text = colorName;
    self.sizeLabel.text = cartInfor.shortSizeCode.length > 0 ? cartInfor.shortSizeCode : cartInfor.sizeCode;
    self.numLabel.text = [NSString stringWithFormat:@"%ld", (long)cartInfor.skuNum];
}

- (void)setOrderSku:(XZZOrderSku *)orderSku
{
    _orderSku = orderSku;
    self.goodsId = orderSku.goodsId;
    [self.imageView addImageFromUrlStr:orderSku.imageTwo];
    self.nameLabel.text = orderSku.goodsTitle;
    if (orderSku.isGiftGoods) {
        self.priceLabel.text = @"$0.00";
        self.freeGoodsPriceLabel.text = [NSString stringWithFormat:@"$%.2f", orderSku.price];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", orderSku.price];
        self.freeGoodsPriceLabel.text = @"";
    }
    self.soldOutLabel.hidden = orderSku.status.intValue;
    NSString * colorName = orderSku.colorName;//GoodsCodeName(orderSku.color);
    NSString * sizeAndColorAndNum = @"";
    if (orderSku.size.length) {
        sizeAndColorAndNum = [NSString stringWithFormat:@"Size:%@", orderSku.size];
    }
    if (colorName.length > 0) {
        sizeAndColorAndNum = [NSString stringWithFormat:@"%@%@Color:%@", sizeAndColorAndNum, sizeAndColorAndNum.length > 0 ? @"   " : @"", colorName];
    }
    sizeAndColorAndNum = [NSString stringWithFormat:@"%@%@Qty:%@", sizeAndColorAndNum, sizeAndColorAndNum.length > 0 ? @"   " : @"", orderSku.quantity];
    
    self.colorLabel.text = colorName;
    self.sizeLabel.text = orderSku.shortSizeCode.length > 0 ? orderSku.shortSizeCode : orderSku.size;
    
    self.numLabel.text = orderSku.quantity;

    self.viewCommentButton.hidden = orderSku.commentId.length > 0 ? NO : YES;
    //    self.sizeAndColorAndNumLabel.text = [NSString stringWithFormat:@"Size:%@   Color:%@   Qty:%@", orderSku.size, colorName, orderSku.quantity];
    
}

- (void)setHideCommentButton:(BOOL)hideCommentButton
{
    _hideCommentButton = hideCommentButton;
    self.commentButton.hidden = hideCommentButton;
    if (!hideCommentButton) {
        self.commentButton.hidden = self.orderSku.isComment;
    }
}

- (void)ViewGoodsDetails:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnGoodsAccordingId:state:)]) {
        [self.delegate clickOnGoodsAccordingId:self.goodsId state:self.soldOutLabel.hidden];
    }
}

#pragma mark ----*  点击评论
/**
 *  点击评论
 */
- (void)clickOnCommentsGoodsButton
{
    if ([self.delegate respondsToSelector:@selector(productReviewOrderSku:)]) {
        [self.delegate productReviewOrderSku:self.orderSku];
    }
}
@end
