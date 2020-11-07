//
//  XZZCheckOutProfitInformationView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/11.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutProfitInformationView.h"


@interface XZZCheckOutProfitInformationView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * selectedButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * label;

@end

@implementation XZZCheckOutProfitInformationView

+ (instancetype)allocInit
{
    XZZCheckOutProfitInformationView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    
    WS(wSelf)
    
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf);
        make.center.equalTo(wSelf);
        make.top.equalTo(@0);
    }];
    
    self.selected = YES;
    
    UIButton * selectedButton = [UIButton allocInitWithImageName:@"order_check_out_no_selected" selectedImageName:@"order_check_out_selected"];
    [backView addSubview:selectedButton];
    self.selectedButton = selectedButton;
    selectedButton.selected = YES;
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(wSelf);
    }];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x323232) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.text = [NSString stringWithFormat:@"Reward Jolimall a $%.2f profit or refer it to friends instead.", My_Basic_Infor.kolProfit];
    label.numberOfLines = 2;
    self.label = label;
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.selectedButton.mas_right).offset(4);
        make.right.equalTo(wSelf).offset(-10);
        make.centerY.equalTo(wSelf);
    }];
    
    UIButton * button = [UIButton allocInit];
    [button addTarget:self action:@selector(clickOonSelected) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf);
    }];
}

- (void)clickOonSelected
{
    self.selected = !self.selected;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.selectedButton.selected = self.selected;
    !self.generalBlock?:self.generalBlock();
}

- (void)editProfitInfor
{
    self.label.text = [NSString stringWithFormat:@"Reward Jolimall a $%.2f profit or refer it to friends instead.", My_Basic_Infor.kolProfit];
//    self.selected = self.selected;
}

@end
