//
//  XZZOrderDetailsAddressView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZOrderDetailsAddressView.h"

@interface XZZOrderDetailsAddressView ()

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

@implementation XZZOrderDetailsAddressView

+ (instancetype)allocInit
{
    XZZOrderDetailsAddressView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView
{
    WS(wSelf)

    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@10);
    }];
    weakView(weak_dividerView, dividerView)
    self.backgroundColor = [UIColor whiteColor];
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.text = @"Address";
    titleLabel.font = textFont_bold(14);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf);
        make.left.equalTo(@18);
        make.top.equalTo(weak_dividerView.mas_bottom).offset(10);
    }];
    
    weakView(weak_titleLabel, titleLabel)
    
    //    weakView(weak_dividerView, dividerView)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnAddressView)]];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_titleLabel.mas_bottom);
    }];
    weakView(weak_backView, backView)
    
    
    self.arrowImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"address_arrow"];
    [backView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_backView).offset(-15);
        make.centerY.equalTo(weak_backView);
        make.width.equalTo(@8);
    }];
    
    weakView(weak_arrowImageView, self.arrowImageView)
    
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_titleLabel);
        make.top.equalTo(weak_backView).offset(10);
        make.right.equalTo(weak_arrowImageView.mas_left).offset(-10);
    }];
    
    UIColor * addressColor = kColor(0x191919);
    

    
    self.addressLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:addressColor textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.addressLabel.numberOfLines = 2;
    [backView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.nameLabel);
        make.top.equalTo(wSelf.nameLabel.mas_bottom).offset(10);
    }];
    
    self.regionLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:addressColor textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.regionLabel];
    self.regionLabel.numberOfLines = 2;
    [self.regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.addressLabel);
        make.top.equalTo(wSelf.addressLabel.mas_bottom).offset(10);
    }];
    
    
    self.phoneLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:addressColor textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.nameLabel);
        make.top.equalTo(wSelf.regionLabel.mas_bottom).offset(10);
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
