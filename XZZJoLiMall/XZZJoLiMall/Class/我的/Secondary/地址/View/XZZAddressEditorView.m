//
//  XZZAddressEditorView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddressEditorView.h"

@interface XZZAddressEditorView ()

/**
 * label
 */
@property (nonatomic, strong)UILabel * titleLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * arrowImageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * button;

@end

@implementation XZZAddressEditorView



- (void)setTitle:(NSString *)title
{
    _title = title;
    
    
    [self addView];
    
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)addView{
    WS(wSelf)
    self.titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0xffffff) textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.titleLabel.text = self.title;
    [self addSubview:self.titleLabel];
    [self.titleLabel sizeToFit];
    CGFloat width = self.titleLabel.width + 10;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.width.equalTo(@(width));
        make.top.bottom.equalTo(wSelf);
    }];
    
    self.textField = [UITextField allocInit];
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.font = textFont(14);
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.titleLabel.mas_right).offset(10);
        make.top.bottom.equalTo(wSelf);
        make.right.equalTo(wSelf).offset(-11);
    }];
    self.arrowImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"address_arrow"];
    self.arrowImageView.hidden = YES;
    [self addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-11);
        make.centerY.equalTo(wSelf);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.titleLabel);
        make.bottom.centerX.equalTo(wSelf);
        make.height.equalTo(@(divider_view_width));
    }];
    
    self.button = [UIButton allocInit];
    [self.button addTarget:self action:@selector(clickOnEditorTextFirld) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf);
    }];
    
}

- (void)textFieldDidChange:(id) sender {
    
    self.titleLabel.textColor = kColor(0x000000);
    
}

- (void)setInput:(BOOL)input
{
    _input = input;
    self.button.userInteractionEnabled = input;
    self.textField.userInteractionEnabled = input;
    self.arrowImageView.hidden = input;
    CGFloat right = input ? -11 : -25;
    WS(wSelf)
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(right);
    }];
}


/**
 *  输入内容缺失
 */
- (void)inputUnfilledContent
{
    self.titleLabel.textColor = kColor(0xf41c19);
}

#pragma mark ----点击进行编辑输入框
/**
 *  点击进行编辑输入框
 */
- (void)clickOnEditorTextFirld {
    [self.textField becomeFirstResponder];
}

@end
