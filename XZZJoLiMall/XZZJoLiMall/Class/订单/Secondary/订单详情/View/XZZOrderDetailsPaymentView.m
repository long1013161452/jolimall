//
//  XZZOrderDetailsPaymentView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderDetailsPaymentView.h"

#import "XZZPaymentType.h"


@interface XZZOrderDetailsPaymentView ()

/**
 * 银行卡  按钮
 */
@property (nonatomic, strong)UIButton * cardButton;
/**
 * 银行卡按钮
 */
@property (nonatomic, strong)UIButton * cardTwoButton;

/**
 * PayPal按钮
 */
@property (nonatomic, strong)UIButton * payPalButton;
/**
 * PayPal按钮
 */
@property (nonatomic, strong)UIButton * payPalTwoButton;

/**
 * 运费
 */
@property (nonatomic, strong)UILabel * shippingLabel;

/**
 * 支付金额
 */
@property (nonatomic, strong)UILabel * totalLabel;
/**
 * d商品总价
 */
@property (nonatomic, strong)UILabel * subTotalLabel;
/**
 * 优惠价格
 */
@property (nonatomic, strong)UILabel * discountLabel;
/**
 * 利润label
 */
@property (nonatomic, strong)UILabel * profitLabel;

@end


@implementation XZZOrderDetailsPaymentView

+ (instancetype)allocInit
{
    XZZOrderDetailsPaymentView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)

    NSLog(@"%s %d 行", __func__, __LINE__);
    self.backgroundColor = [UIColor whiteColor];
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    self.subTotalLabel = [self priceInforTitle:@"Subtotal" textColor:kColor(0x000000) font:textFont(12)];
    UIView * subTotalView = self.subTotalLabel.superview;
    [subTotalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@30);
    }];
    weakView(weak_subTotalView, subTotalView)
    self.shippingLabel = [self priceInforTitle:@"Shipping" textColor:kColor(0x000000) font:textFont(12)];
    UIView * shippingView = self.shippingLabel.superview;
    [shippingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_subTotalView.mas_bottom);
        make.height.equalTo(@30);
    }];
    weakView(weak_shippingView, shippingView)
    
    self.discountLabel = [self priceInforTitle:@"Discount" textColor:kColor(0x000000) font:textFont(12)];
    UIView * discountView = self.discountLabel.superview;
    [discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_shippingView.mas_bottom);
        make.height.equalTo(@30);
        make.left.right.equalTo(wSelf);
    }];
    
    weakView(weak_discountView, discountView)
    
    self.profitLabel = [self priceInforTitle:@"Profit" textColor:kColor(0x000000) font:textFont(12)];
    UIView * profitView = self.profitLabel.superview;
    [profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_discountView.mas_bottom);
        make.height.equalTo(@30);
        make.left.right.equalTo(wSelf);
    }];
    
    weakView(weak_profitView, profitView)
    self.totalLabel = [self priceInforTitle:@"Total" textColor:kColor(0x000000) font:textFont_bold(14)];
    UIView * totalView = self.totalLabel.superview;
    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_profitView.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    weakView(weak_totalView, totalView)
    
    CGFloat buttonBottom = StatusRect.size.height > 20 ? bottomHeight : 0;
    
    self.cardButton = [UIButton allocInitWithTitle:@"Check Out" color:kColor(0xffffff) selectedTitle:@"Check Out" selectedColor:kColor(0xffffff) font:18];
    self.cardButton.backgroundColor = button_back_color;
    [self.cardButton addTarget:self action:@selector(clickOnCardButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.cardButton];
    [self.cardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_totalView);
        make.top.equalTo(weak_totalView.mas_bottom);
        make.height.equalTo(@46);
        make.bottom.equalTo(wSelf).offset(-buttonBottom);
    }];
    
    self.payPalButton = [UIButton allocInitWithTitle:@"check out with" color:kColor(0x000000) selectedTitle:@"check out with" selectedColor:kColor(0x000000) font:11];
    [self.payPalButton setImage:imageName(@"order_pay_paypal") forState:(UIControlStateNormal)];
    [self.payPalButton setImage:imageName(@"order_pay_paypal") forState:(UIControlStateSelected)];
    self.payPalButton.backgroundColor = kColor(0xffb400);
    self.payPalButton.frame = CGRectMake(0, 0, ScreenWidth / 2.0, 46);
    [self.payPalButton addTarget:self action:@selector(clickOnPayPalButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.payPalButton];
    [self initButton:self.payPalButton];
    [self.payPalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(wSelf.cardButton);
        make.left.equalTo(wSelf.cardButton.mas_right);
        make.right.equalTo(wSelf);
    }];
    
    
    self.cardTwoButton = [UIButton allocInitWithTitle:@"Check Out" color:kColor(0xffffff) selectedTitle:@"Check Out" selectedColor:kColor(0xffffff) font:18];
    self.cardTwoButton.backgroundColor = button_back_color;
    [self.cardTwoButton addTarget:self action:@selector(clickOnCardButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.cardTwoButton];
    [self.cardTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(wSelf.cardButton);
        make.right.equalTo(wSelf);
    }];
    
    self.payPalTwoButton = [UIButton allocInitWithTitle:@"check out with" color:kColor(0x000000) selectedTitle:@"check out with" selectedColor:kColor(0x000000) font:11];
    [self.payPalTwoButton setImage:imageName(@"order_pay_paypal") forState:(UIControlStateNormal)];
    [self.payPalTwoButton setImage:imageName(@"order_pay_paypal") forState:(UIControlStateSelected)];
    self.payPalTwoButton.backgroundColor = kColor(0xffb400);
    self.payPalTwoButton.frame = CGRectMake(0, 0, ScreenWidth, 46);
    [self.payPalTwoButton addTarget:self action:@selector(clickOnPayPalButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.payPalTwoButton];
    [self initButton:self.payPalTwoButton];
    [self.payPalTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(wSelf.cardButton);
        make.right.equalTo(wSelf);
    }];
    
    
    
}

- (void)setOrderDetail:(XZZOrderDetail *)orderDetail
{
    _orderDetail = orderDetail;
    
    if (orderDetail.discount <= 0) {
        self.discountLabel.superview.hidden = YES;
        [self.discountLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else{
        self.discountLabel.text = [NSString stringWithFormat:@"-$%.2f", orderDetail.discount];
    }
    
    if (orderDetail.profit <= 0) {
        self.profitLabel.superview.hidden = YES;
        [self.profitLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else{
        self.profitLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.profit];
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.total];;
    self.shippingLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.shipping];
    self.subTotalLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.subTotal];
    
    
}

- (void)clickOnCardButton
{
    !self.cardPay?:self.cardPay();
}

- (void)clickOnPayPalButton
{
    !self.payPalPay?:self.payPalPay();
}

- (void)setTypeArray:(NSArray *)typeArray
{
    _typeArray = typeArray;
    if (!self.hideButton) {
        if (typeArray.count > 1) {
            self.buttonType = XZZMethodPaymentTypeNone;
        }else if (typeArray.count > 0){
            XZZPaymentType * type = typeArray[0];
            if (type.payType == 0) {
                self.buttonType = XZZMethodPaymentTypePayPal;
            }else{
                self.buttonType = XZZMethodPaymentTypeCard;
            }
        }else{
            self.buttonType = XZZMethodPaymentTypeNOPay;
        }
    }
}


- (void)setHideButton:(BOOL)hideButton
{
    _hideButton = hideButton;
    if (hideButton) {
        [self.cardButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.cardButton.hidden = YES;
        self.cardTwoButton.hidden = YES;
        self.payPalButton.hidden = YES;
        self.payPalTwoButton.hidden = YES;
    }
}

- (void)setButtonType:(XZZMethodPaymentType)buttonType
{
    _buttonType = buttonType;
    self.payPalTwoButton.hidden = YES;
    self.cardTwoButton.hidden = YES;
    self.payPalButton.hidden = NO;
    self.cardButton.hidden = NO;
    switch (buttonType) {
        case XZZMethodPaymentTypeCard:{
            self.cardTwoButton.hidden = NO;
        }
            break;
        case XZZMethodPaymentTypePayPal:{
            self.payPalTwoButton.hidden = NO;
        }
            break;
        case XZZMethodPaymentTypeNone:{

        }
            break;
        case XZZMethodPaymentTypeNOPay:{
            self.payPalTwoButton.hidden = YES;
            self.payPalButton.hidden = YES;
            self.cardButton.hidden = YES;
            self.cardTwoButton.hidden = YES;
        }
        default:
            break;
    }
}

- (UILabel *)priceInforTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font
{
    UIView * view = [UIView allocInit];
    [self addSubview:view];
    weakView(weak_view, view)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.font = font;
    titleLabel.text = title;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.bottom.equalTo(weak_view);
    }];
    
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:12 textAlignment:(NSTextAlignmentRight) tag:1];
    priceLabel.font = font;
    [view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_view).offset(-11);
        make.top.bottom.equalTo(weak_view);
    }];
    return priceLabel;
    
}

#pragma mark ----    设置按钮上图下文的编辑
-(void)initButton:(UIButton*)btn{
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    CGFloat imageW = btn.imageView.frame.size.width;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake( 0, -imageW, 0.0, imageW)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.width,0.0, -btn.titleLabel.width)];//图片距离右边框距离减少图片的宽度，其它不边
    
}


@end
