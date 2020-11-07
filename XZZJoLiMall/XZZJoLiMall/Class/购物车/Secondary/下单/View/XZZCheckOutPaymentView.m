//
//  XZZCheckOutPaymentView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutPaymentView.h"
#import "XZZCheckOutTitleView.h"

@interface XZZCheckOutPaymentView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * selectedButton;


/**
 * 是否是银行卡支付
 */
@property (nonatomic, assign)BOOL isCartPay;

/**
 * 展示银行卡可用类型的图标
 */
@property (nonatomic, strong)UIView * cartIconView;

@end

@implementation XZZCheckOutPaymentView

- (void)setPaymentTypeArr:(NSArray *)paymentTypeArr
{
//    if (paymentTypeArr.count != self.paymentTypeArr.count) {
        _paymentTypeArr = paymentTypeArr;
        [self addView];
//    }else
    
}

- (void)addView{
    WS(wSelf)
    [self removeAllSubviews];
    self.layer.masksToBounds = YES;
    
    XZZCheckOutTitleView * titleView = [XZZCheckOutTitleView allocInit];
    titleView.title = @"Payment Method";
    titleView.titleLabel.font = textFont_bold(13);
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@35);
    }];
    
    weakView(weak_titleView, titleView)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_titleView.mas_bottom);
        make.height.equalTo(@.5);
    }];
    weakView(weak_dividerView, dividerView)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@80);
        make.top.equalTo(weak_dividerView.mas_bottom);
    }];
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];

    weakView(weak_backView, backView)
    CGFloat width = 100;
    UIButton * cardButton = [UIButton allocInitWithImageName:@"order_pay_type_Bank_card" selectedImageName:@"order_pay_type_Bank_card_selected"];
    [cardButton addTarget:self action:@selector(switchingPaymentMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:cardButton];
    [cardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weak_backView);
        make.left.equalTo(weak_backView.mas_centerX).offset(-width);
        make.width.equalTo(@(width));
    }];
    
    weakView(weak_cardButton, cardButton)
    UIButton * payPalButton = [UIButton allocInitWithImageName:@"order_pay_type_PayPal" selectedImageName:@"order_pay_type_PayPal_selected"];
    [payPalButton addTarget:self action:@selector(switchingPaymentMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:payPalButton];
    
    [payPalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_backView.mas_centerX);
        make.top.bottom.equalTo(weak_backView);
        make.width.equalTo(weak_cardButton);
    }];
    
    
    
    self.cartIconView = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0)];// imageName:@"order_pay_Bank_card"];
    [self addSubview:self.cartIconView];
    if (self.selectedButton && self.selectedButton.tag == 0) {
        self.cartIconView.hidden = YES;
        [self.cartIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weak_backView.mas_bottom);
            make.bottom.right.left.equalTo(wSelf);
            make.height.equalTo(@0);
        }];
    }else{
        self.cartIconView.hidden = NO;
        [self.cartIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weak_backView.mas_bottom);
            make.bottom.right.left.equalTo(wSelf);
            make.height.equalTo(@45);
        }];
    }
    UIImageView * iconImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"order_pay_Bank_card"];
    [self.cartIconView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(wSelf.cartIconView);
    }];
    
    if (self.paymentTypeArr.count > 1) {
        for (int i = 0; i < 2; i++) {
            XZZPaymentType * type = self.paymentTypeArr[i];
            if (type.payType == 0) {
                payPalButton.tag = type.payType;
            }else{
                cardButton.tag = type.payType;
            }
        }
        UIButton * button = (self.selectedButton.tag == 0 && self.selectedButton) ? payPalButton : cardButton;
        [self switchingPaymentMethod:button];
        
    }else if(self.paymentTypeArr.count == 1){
        XZZPaymentType * type = [self.paymentTypeArr firstObject];
        UIView * view = nil;
        if (type.payType == 0) {
            cardButton.hidden = YES;
            payPalButton.tag = 0;
            view = payPalButton;
        }else{
            payPalButton.hidden = YES;
            cardButton.tag = type.payType;
            view = cardButton;
        }
        [self switchingPaymentMethod:view];
        view.tag = type.payType;
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weak_backView.mas_centerX).offset(-(width / 2.0));
            make.top.bottom.equalTo(weak_backView);
            make.width.equalTo(@(width));
        }];
    }else{
        cardButton.hidden = YES;
        payPalButton.hidden = YES;
    }
    
}

- (void)switchingPaymentMethod:(UIButton *)button{
    if (![button isEqual:self.selectedButton]) {
        self.selectedButton.selected = NO;
        button.selected = YES;
        NSInteger paymentType = button.tag;
        if (self.selectedButton.tag != button.tag) {
            self.isCartPay = paymentType;
        }
        self.selectedButton = button;
        !self.paymentType?:self.paymentType(paymentType);
    }
}

- (void)setIsCartPay:(BOOL)isCartPay
{
    _isCartPay = isCartPay;
    
    CGFloat height = 0;
    if (isCartPay) {
        height = 45;
        
    }
    WS(wSelf)
    
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:.3 animations:^{
        wSelf.cartIconView.hidden = !isCartPay;
        [wSelf.cartIconView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        
        [wSelf.superview layoutIfNeeded];//强制绘制
        
    } completion:^(BOOL finished) {
        !wSelf.refreshBlock?:wSelf.refreshBlock();
    }];

    

    
    
}

@end
