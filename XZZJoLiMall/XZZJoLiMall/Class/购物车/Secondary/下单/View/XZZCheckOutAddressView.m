//
//  XZZCheckOutAddressView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutAddressView.h"



@interface XZZCheckOutAddressView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * nameLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * phoneLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * addressLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * regionLabel;

@end


@implementation XZZCheckOutAddressView

+ (instancetype)allocInit
{
    XZZCheckOutAddressView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView
{
    WS(wSelf)
    self.titleView = [XZZCheckOutTitleView allocInit];
    self.titleView.title = @"Address";
    self.titleView.titleLabel.font = textFont_bold(13);
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@35);
    }];
    
    weakView(weak_titleView, self.titleView)

//    weakView(weak_dividerView, dividerView)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnAddressView)]];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_titleView.mas_bottom);
    }];
    weakView(weak_backView, backView)

    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_backView);
        make.height.equalTo(@.5);
    }];
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.bottom.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    
    self.arrowImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"address_arrow"];
    [backView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_backView).offset(-15);
        make.centerY.equalTo(weak_backView);
        make.width.equalTo(@8);
    }];
    
    weakView(weak_arrowImageView, self.arrowImageView)
    
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_backView).offset(11);
        make.top.equalTo(weak_backView).offset(10);
        make.right.equalTo(weak_arrowImageView.mas_left).offset(-10);
    }];
    
    UIColor * addressColor = kColor(0x727272);
    
    self.phoneLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:addressColor textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.nameLabel);
        make.top.equalTo(wSelf.nameLabel.mas_bottom).offset(10);
    }];
    
    self.addressLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:addressColor textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.addressLabel.numberOfLines = 2;
    [backView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.phoneLabel);
        make.top.equalTo(wSelf.phoneLabel.mas_bottom).offset(10);
    }];
    
    self.regionLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:addressColor textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.regionLabel];
    self.regionLabel.numberOfLines = 2;
    [self.regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.addressLabel);
        make.top.equalTo(wSelf.addressLabel.mas_bottom).offset(10);
        make.bottom.equalTo(weak_backView).offset(-15);
    }];
    
    
    
    
    
    
}

- (void)clickOnAddressView
{
    !self.chooseAddress?:self.chooseAddress();
}


- (void)setAddress:(XZZAddressInfor *)address
{
    _address = address;
    if (address) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", address.firstName, address.lastName];
        self.phoneLabel.text = address.phone;
        self.addressLabel.text = [NSString stringWithFormat:@"%@,%@", address.detailAddress1, address.detailAddress2];
        self.regionLabel.text = [NSString stringWithFormat:@"%@,%@/%@,%@", address.cityName, address.provinceName, address.countryName, address.zipCode];
    }else{
        self.nameLabel.text = @"";
        self.phoneLabel.text = @"";
        self.addressLabel.text = @"";
        self.regionLabel.text = @"";
    }
    
    
}


@end
