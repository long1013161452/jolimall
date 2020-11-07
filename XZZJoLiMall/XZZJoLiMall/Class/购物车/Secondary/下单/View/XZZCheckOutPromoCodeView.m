//
//  XZZCheckOutPromoCodeView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutPromoCodeView.h"
#import "XZZCheckOutTitleView.h"


@interface XZZCheckOutPromoCodeView ()


/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;


@end



@implementation XZZCheckOutPromoCodeView

+ (instancetype)allocInit
{
    XZZCheckOutPromoCodeView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)

    self.backView = [UIView allocInit];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(@10);
        make.height.equalTo(@45);
    }];
    
    UIView * dividerView1 = [UIView allocInit];
    dividerView1.backgroundColor = DIVIDER_COLOR;
    [self.backView addSubview:dividerView1];
    [dividerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.backView);
        make.height.equalTo(@.5);
    }];
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self.backView addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf.backView);
        make.height.equalTo(@.5);
    }];
    
    
    UILabel * new10Label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    new10Label.text = My_Basic_Infor.confirmPageCouponcodeCopywriting;
    new10Label.userInteractionEnabled = YES;
    [new10Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fillCouponCodeAutomatically)]];
    [self.backView addSubview:new10Label];
    [new10Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.bottom.centerX.equalTo(wSelf.backView);
    }];
    
    
    
    UIView * textBackView = [UIView allocInit];
    textBackView.layer.borderColor = kColor(0x2f2f2f).CGColor;
    textBackView.layer.borderWidth = .5;
    textBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:textBackView];
    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(wSelf.backView.mas_bottom).offset(15);
        make.height.equalTo(@36);
//        make.centerX.equalTo(wSelf);
        make.bottom.equalTo(wSelf).offset(-30);
    }];
    weakView(weak_textBackView, textBackView)
    UIButton * applyButton = [UIButton allocInitWithTitle:@"Apply" color:kColor(0xffffff) selectedTitle:@"Apply" selectedColor:kColor(0xffffff) font:13];
    applyButton.backgroundColor = button_back_color;
    [applyButton addTarget:self action:@selector(clickOnCalculatePrice) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:applyButton];
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weak_textBackView);
        make.right.equalTo(wSelf).offset(-15);
        make.left.equalTo(weak_textBackView.mas_right);
        make.width.equalTo(@75);
    }];
    weakView(weak_applyButton, applyButton)
    self.textField = [UITextField allocInit];
    self.textField.font = textFont(13);
    self.textField.placeholder = @"Coupon Code";
    self.textField.delegate = self;
    [textBackView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weak_textBackView);
        make.left.equalTo(@11);
        make.right.equalTo(weak_applyButton.mas_left);
    }];
    
//    UILabel * couponLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x727272) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
//    couponLabel.text = @"The coupon is unavailable now";
//    [self addSubview:couponLabel];
//    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weak_textBackView);
//        make.top.equalTo(weak_textBackView.mas_bottom).offset(10);
//        make.bottom.equalTo(wSelf).offset(-30);
//    }];
    
    if (My_Basic_Infor.confirmPageCouponcodeCopywriting.length > 0) {
        self.hiddenCouponTip = YES;
    }else{
        self.hiddenCouponTip = NO;
    }

    
}

- (void)setHiddenCouponTip:(BOOL)hiddenCouponTip
{
    CGFloat height = !hiddenCouponTip ? 0 : 45;
    self.backView.hidden = !hiddenCouponTip;
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self clickOnCalculatePrice];
}

- (void)fillCouponCodeAutomatically
{
    self.textField.text = My_Basic_Infor.confirmPageCouponcode;
    !self.calculatePrice?:self.calculatePrice();
}

- (void)clickOnCalculatePrice
{
    [self.textField resignFirstResponder];
    !self.calculatePrice?:self.calculatePrice();
}




@end
