//
//  XZZCheckOutOrderGoodsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutOrderGoodsView.h"
#import "XZZCheckOutTitleView.h"


@interface XZZCheckOutOrderGoodsView ()

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
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * sizeAndColorAndNumLabel;

/**
 * 评论按钮
 */
@property (nonatomic, strong)UIButton * commentButton;

/**
 * 商品下架
 */
@property (nonatomic, strong)UILabel * soldOutLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsId;

@end



@implementation XZZCheckOutOrderGoodsView

+ (instancetype)allocInit
{
    XZZCheckOutOrderGoodsView * view = [super allocInit];
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
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@10);
        make.bottom.equalTo(wSelf).offset(-5);
        make.width.equalTo(@60);
        make.height.equalTo(@80);
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
    self.nameLabel.numberOfLines = 2;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.imageView.mas_right).offset(10);
        make.top.equalTo(wSelf.imageView);
        make.right.equalTo(wSelf).offset(-10);
    }];
    
    self.sizeAndColorAndNumLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x4d4d4d) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.sizeAndColorAndNumLabel];
    [self.sizeAndColorAndNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.nameLabel);
        make.bottom.equalTo(wSelf.imageView);
        make.height.equalTo(@15);
    }];
    
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.priceLabel.font = textFont_bold(14);
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.sizeAndColorAndNumLabel);
        make.height.equalTo(@20);
        make.bottom.equalTo(wSelf.sizeAndColorAndNumLabel.mas_top).offset(-5);
    }];
    
    
    self.commentButton = [UIButton allocInitWithTitle:@"review" color:kColor(0xffffff) selectedTitle:@"review" selectedColor:kColor(0xffffff) font:12];
    self.commentButton.hidden = YES;
    self.commentButton.backgroundColor = button_back_color;
    [self.commentButton addTarget:self action:@selector(clickOnCommentsGoodsButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.commentButton];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.nameLabel.mas_right);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
        make.centerY.equalTo(wSelf.priceLabel);
    }];
}


- (void)setCartInfor:(XZZCartInfor *)cartInfor
{
    _cartInfor = cartInfor;
    self.goodsId = cartInfor.goodsId;
    [self.imageView addImageFromUrlStr:cartInfor.mainPicture];
    self.nameLabel.text = cartInfor.goodsTitle;
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", cartInfor.skuPrice];
    self.soldOutLabel.hidden = YES;
    
    NSString * colorName = cartInfor.colorName;//GoodsCodeName(cartInfor.colorCode);
    self.sizeAndColorAndNumLabel.text = [NSString stringWithFormat:@"Size: %@   %@%@   Qty: %ld", cartInfor.sizeCode, colorName.length > 0 ? @"Color: " : @"", colorName.length > 0 ? colorName : @"", (long)cartInfor.skuNum];
}

- (void)setOrderSku:(XZZOrderSku *)orderSku
{
    _orderSku = orderSku;
    self.goodsId = orderSku.goodsId;
    [self.imageView addImageFromUrlStr:orderSku.imageTwo];
    self.nameLabel.text = orderSku.goodsTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", orderSku.price];
    self.soldOutLabel.hidden = orderSku.status.intValue;
    NSString * colorName = orderSku.colorName;//GoodsCodeName(orderSku.color);
    NSString * sizeAndColorAndNum = @"";
    
    if (colorName.length > 0) {
        sizeAndColorAndNum = [NSString stringWithFormat:@"Color: %@", colorName];
    }
    if (orderSku.size.length) {
        sizeAndColorAndNum = [NSString stringWithFormat:@"%@%@Size: %@", sizeAndColorAndNum, sizeAndColorAndNum.length > 0 ? @"   " : @"", orderSku.shortSizeCode.length > 0 ? orderSku.shortSizeCode : orderSku.size];
    }

    sizeAndColorAndNum = [NSString stringWithFormat:@"%@%@Qty: %@", sizeAndColorAndNum, sizeAndColorAndNum.length > 0 ? @"   " : @"", orderSku.quantity];

    self.sizeAndColorAndNumLabel.text = sizeAndColorAndNum;

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
