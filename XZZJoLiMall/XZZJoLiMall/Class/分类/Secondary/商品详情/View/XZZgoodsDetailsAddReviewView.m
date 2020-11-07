//
//  XZZgoodsDetailsAddReviewView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZgoodsDetailsAddReviewView.h"

@implementation XZZgoodsDetailsAddReviewView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZgoodsDetailsAddReviewView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

- (void)addView
{
    [self removeAllSubviews];
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 10, ScreenWidth, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    weakView(weak_backView, backView);
    UILabel * label = [UILabel labelWithFrame:CGRectMake(16, 0, 200, backView.height) backColor:nil textColor:kColor(0x191919) textFont:16 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.font = textFont_bold(16);
    label.text = @"Be the first to review";
    [backView addSubview:label];
    
    
    weakView(weak_label, label);
    UIButton * button = [UIButton allocInitWithTitle:@"Add a review" color:button_back_color selectedTitle:@"Add a review" selectedColor:button_back_color font:14];
    button.titleLabel.font = textFont_bold(14);
    [button cutRounded:14];
    button.layer.borderColor = button_back_color.CGColor;
    button.layer.borderWidth = 0.5;
    [button addTarget:self action:@selector(clickOutAddReview) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_backView).offset(-16);
        make.height.equalTo(@28);
        make.width.equalTo(@110);
        make.centerY.equalTo(weak_label);
    }];
    
    self.height = 80;
    
    
}

- (void)clickOutAddReview
{
    !self.addReview?:self.addReview();
}



@end
