//
//  XZZFillEmailInforView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/15.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZFillEmailInforView.h"

@interface XZZFillEmailInforView ()


/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;


@end

@implementation XZZFillEmailInforView


+ (instancetype)allocInitWithFrame:(CGRect)frame
{
    XZZFillEmailInforView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

- (void)addView{
    
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = kColorWithRGB(0, 0, 0, .5);
    [self addSubview:view];
    
    self.backView = [UIView allocInitWithFrame:CGRectMake(0, 0, (ScreenWidth * 2.0 / 3.0), 100)];
//    self.backView.layer.borderColor = kColor(0x000000).CGColor;
//    self.backView.layer.borderWidth = .5;
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.centerX = self.centerX;
    [self addSubview:self.backView];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(10, 10, self.backView.width - 20, 20) backColor:nil textColor:kColor(0x000000) textFont:16 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.text = @"Please fill in the contact information";
    [label changeTheHeightInputInformation ];
    [self.backView addSubview:label];
    
    self.textField = [UITextField allocInitWithFrame:CGRectMake(label.left, label.bottom + 20, label.width, 45)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"Email";
    self.textField.font = textFont(14);
    [self.backView addSubview:self.textField];
    
    UIButton * cancelButton = [UIButton allocInitWithTitle:@"cancel" color:kColor(0xFFFFFF) selectedTitle:@"cancel" selectedColor:kColor(0xFFFFFF) font:15];
    cancelButton.backgroundColor = [UIColor blackColor];
    cancelButton.frame = CGRectMake(0, self.textField.bottom + 25, self.backView.width / 2.0, 45);
    [cancelButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:cancelButton];
    
    self.backView.height = cancelButton.bottom;
    
    UIButton * determineButton = [UIButton allocInitWithTitle:@"determine" color:kColor(0xFFFFFF) selectedTitle:@"determine" selectedColor:kColor(0xFFFFFF) font:15];
    determineButton.backgroundColor = button_back_color;
    determineButton.frame = CGRectMake(cancelButton.right, cancelButton.top, cancelButton.width, cancelButton.height);
    [determineButton addTarget:self action:@selector(clickOnDetermineButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:determineButton];
    
    
}

- (void)clickOnDetermineButton
{
    !self.determine?:self.determine() ;
}


- (void)addSubView:(UIView *)view
{
    [view addSubview:self];
    WS(wSelf)
    [UIView animateWithDuration:.3 animations:^{
        wSelf.backView.centerY = self.centerY - 50;
    }];
}

/**
 * 移除视图
 */
- (void)removeView
{
    WS(wSelf)
    [UIView animateWithDuration:.3 animations:^{
        wSelf.backView.top = ScreenHeight;
    } completion:^(BOOL finished) {
        [wSelf removeFromSuperview];
        wSelf.backView.bottom = 0;
    }];
}


@end
