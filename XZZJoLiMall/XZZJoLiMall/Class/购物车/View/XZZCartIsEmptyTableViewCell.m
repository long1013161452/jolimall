//
//  XZZCartIsEmptyTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/5.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCartIsEmptyTableViewCell.h"

@implementation XZZCartIsEmptyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)addView
{
    [self removeAllSubviews];
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"cart_goods_null"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf);
        make.top.equalTo(@30);
    }];
    weakView(weak_imageView, imageView)
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:16 textAlignment:(NSTextAlignmentCenter) tag:1];
    label.text = @"Your Cart is Empty";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.centerX.equalTo(wSelf);
        make.top.equalTo(weak_imageView.mas_bottom).offset(15);
    }];
    
    weakView(weak_label, label)
    UILabel * labelTwo = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x9b9b9b) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    labelTwo.text = @"Add some products to your cart and try again";
    labelTwo.numberOfLines = 2;
    [self addSubview:labelTwo];
    [labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_label);
        make.top.equalTo(weak_label.mas_bottom).offset(15);
    }];
    
    weakView(weak_labelTwo, labelTwo)
    UIButton * button = [UIButton allocInitWithTitle:@"Shop Now" color:kColor(0xffffff) selectedTitle:@"Shop Now" selectedColor:kColor(0xffffff) font:18];
    button.backgroundColor = button_back_color;
    [button cutRounded:5];
    [button addTarget:self action:@selector(returnHomePage) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerX.equalTo(wSelf);
        make.height.equalTo(@45);
        make.bottom.equalTo(wSelf).offset(-30);
    }];
    
    
    
}


- (void)returnHomePage
{
    if ([self.delegate respondsToSelector:@selector(enterHomePage)]) {
        [self.delegate enterHomePage];
    }
}



@end
