//
//  XZZCheckOutFreightView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/1.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutFreightView.h"


@interface XZZCheckOutFreightView ()

/**
 * 选中按钮
 */
@property (nonatomic, strong)FLAnimatedImageView * selectedImageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * promptLabel;



@end

@implementation XZZCheckOutFreightView

+ (instancetype)allocInit
{
    XZZCheckOutFreightView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    
    WS(wSelf)
    
    self.selectedImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"cart_goods_selected"];
    [self addSubview:self.selectedImageView];
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.centerY.equalTo(wSelf);
    }];
    
    UIView * backView = [UIView allocInit];
    backView.userInteractionEnabled = NO;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@45);
        make.centerY.equalTo(wSelf.selectedImageView);
    }];
    
    weakView(weak_backView, backView)
    self.freightPriceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.freightPriceLabel];
    [self.freightPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(weak_backView);
    }];
    
    self.dateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x727272) textFont:9 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.freightPriceLabel);
        make.top.equalTo(wSelf.freightPriceLabel.mas_bottom).offset(5);
    }];
    
    self.promptLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x727272) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.dateLabel);
        make.top.equalTo(wSelf.dateLabel.mas_bottom).offset(3);
        make.bottom.equalTo(weak_backView);
    }];
    
    
}

- (void)setPostageInfor:(XZZOrderPostageInfor *)postageInfor
{
    _postageInfor = postageInfor;
    
    self.freightPriceLabel.text = [NSString stringWithFormat:@"%@    $%.2f", postageInfor.name, postageInfor.fee];
    self.dateLabel.text = postageInfor.desc;
    
    if (postageInfor.freeLimit != -1) {
        self.promptLabel.text = [NSString stringWithFormat:@"Free Standard Shipping $%.2f and up", postageInfor.freeLimit];
    }else{
        self.promptLabel.text = @"";
    }
}

- (void)calculateFreight:(CGFloat)price
{
    CGFloat freight = self.postageInfor.fee;

    if (price >= self.postageInfor.freeLimit && self.postageInfor.freeLimit != -1) {
        freight = 0;
    }
    self.freightPriceLabel.text = [NSString stringWithFormat:@"%@    $%.2f", self.postageInfor.name, freight];
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.selectedImageView.image = selected ? imageName(@"cart_goods_selected") : imageName(@"cart_goods_no_selected");
}

@end
