//
//  XZZGoodsCanCommentSkuView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGoodsCanCommentSkuView.h"

@interface XZZGoodsCanCommentSkuView ()

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

@end


@implementation XZZGoodsCanCommentSkuView

+ (instancetype)allocInit
{
    XZZGoodsCanCommentSkuView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [FLAnimatedImageView allocInit];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = 5;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.centerY.equalTo(wSelf);
                make.width.equalTo(wSelf.imageView.mas_height).multipliedBy(image_width_height_proportion);

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
    
    UILabel * colorLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    colorLabel.text = @"Color: ";
    [self addSubview:colorLabel];
    [colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.nameLabel);
//        make.top.equalTo(wSelf.priceLabel.mas_bottom).offset(10);
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
        make.left.equalTo(weak_colorLabel);
        make.top.equalTo(weak_colorLabel.mas_bottom).offset(5);
        make.bottom.equalTo(wSelf.imageView);
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
        make.left.equalTo(wSelf.sizeLabel.mas_right).offset(5);
        make.top.equalTo(weak_sizeLabel);
    }];
    
    weakView(weak_numLabel, numLabel)
    self.numLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_numLabel.mas_right);
        make.top.equalTo(weak_numLabel);
    }];
}


- (void)setCanCommentSku:(XZZCanCommentSku *)canCommentSku
{
    _canCommentSku = canCommentSku;
    
    [self.imageView addImageFromUrlStr:canCommentSku.image];
    self.nameLabel.text = canCommentSku.goodsTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", canCommentSku.price];
    
    self.colorLabel.text = canCommentSku.color;
    self.sizeLabel.text = canCommentSku.size;
    
    self.numLabel.text = canCommentSku.quantity;
}




@end
