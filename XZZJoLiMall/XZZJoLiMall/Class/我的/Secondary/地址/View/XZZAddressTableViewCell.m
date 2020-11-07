//
//  XZZAddressTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddressTableViewCell.h"


@interface XZZAddressTableViewCell ()

/**
 * 姓名
 */
@property (nonatomic, strong)UILabel * nameLabel;

/**
 * 电话
 */
@property (nonatomic, strong)UILabel * phoneLabel;

/**
 * 地址
 */
@property (nonatomic, strong)UILabel * addressLabel;

/**
 * 地区信息
 */
@property (nonatomic, strong)UILabel * regionLabel;

/**
 * 箭头
 */
@property (nonatomic, strong)FLAnimatedImageView * arrowImageView;

/**
 * 选中状态
 */
@property (nonatomic, strong)UIButton * selectedButton;

/**
 * 选中默认
 */
@property (nonatomic, strong)UILabel * dafultAddressLabel;

/**
 * 删除按钮
 */
@property (nonatomic, strong)UIButton * deleteButton;

/**
 * 编辑
 */
@property (nonatomic, strong)FLAnimatedImageView * editorImageView;


@end

@implementation XZZAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddressInfor:(XZZAddressInfor *)addressInfor
{
    _addressInfor = addressInfor;
    if (!self.nameLabel) {
        [self addView];
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", addressInfor.firstName, addressInfor.lastName];
    self.phoneLabel.text = addressInfor.phone;
    self.addressLabel.text = [NSString stringWithFormat:@"%@,%@", addressInfor.detailAddress1, addressInfor.detailAddress2];
    self.regionLabel.text = [NSString stringWithFormat:@"%@,%@/%@,%@", addressInfor.cityName, addressInfor.provinceName, addressInfor.countryName, addressInfor.zipCode];
    self.selectedButton.selected = addressInfor.status;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.selectedButton.selected = isSelected;
    self.dafultAddressLabel.text = @"Select the address";
    self.arrowImageView.image = nil;
    self.editorImageView.image = nil;
    self.selectedButton.userInteractionEnabled = NO;
    self.dafultAddressLabel.userInteractionEnabled = NO;
    [self.deleteButton removeTarget:self action:@selector(deleteAddress) forControlEvents:(UIControlEventTouchUpInside)];
    [self.deleteButton addTarget:self action:@selector(editorAddress) forControlEvents:(UIControlEventTouchUpInside)];
    [self.deleteButton setImage:imageName(@"address_editor") forState:(UIControlStateNormal)];
    [self.deleteButton setImage:imageName(@"address_editor") forState:(UIControlStateSelected)];
}


- (void)addView
{
    [self removeAllSubviews];
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    UIView * backView = [UIView allocInit];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
    }];
    weakView(weak_backView, backView)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(weak_backView.mas_bottom);
        make.centerX.equalTo(wSelf);
        make.height.equalTo(@(divider_view_width));
    }];
    weakView(weak_dividerView, dividerView)
    UIView * selectedBackView = [UIView allocInit];
    [self addSubview:selectedBackView];
    [selectedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf);
        make.height.equalTo(@40);
        make.top.equalTo(weak_dividerView.mas_bottom);
    }];
    
    self.arrowImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"address_arrow"];
    [backView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_backView).offset(-11);
        make.centerY.equalTo(weak_backView);
        make.width.equalTo(@8);
    }];
    
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_backView).offset(11);
        make.top.equalTo(weak_backView).offset(10);
        make.right.equalTo(wSelf.arrowImageView.mas_left).offset(-10);
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
        make.bottom.equalTo(weak_backView).offset(-8);
    }];
    
    weakView(weak_selectedBackView, selectedBackView)
    self.selectedButton = [UIButton allocInitWithImageName:@"cart_goods_no_selected" selectedImageName:@"cart_goods_selected"];
    [self.selectedButton addTarget:self action:@selector(addressDefault) forControlEvents:(UIControlEventTouchUpInside)];
    [selectedBackView addSubview:self.selectedButton];
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.nameLabel.mas_left);
        make.top.bottom.equalTo(weak_selectedBackView);
    }];
    
    self.dafultAddressLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.dafultAddressLabel.text = @"Set as Dafult Address";
    self.dafultAddressLabel.userInteractionEnabled = YES;
    [self.dafultAddressLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressDefault)]];
    [selectedBackView addSubview:self.dafultAddressLabel];
    [self.dafultAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.selectedButton.mas_right).offset(10);
        make.width.equalTo(@150);
        make.top.bottom.equalTo(weak_selectedBackView);
    }];
    
    self.deleteButton = [UIButton allocInitWithImageName:@"address_delete" selectedImageName:@"address_delete"];
    [self.deleteButton addTarget:self action:@selector(deleteAddress) forControlEvents:(UIControlEventTouchUpInside)];
    [selectedBackView addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.arrowImageView);
        make.top.bottom.equalTo(weak_selectedBackView);
        make.width.equalTo(@45);
    }];
    
    self.editorImageView = [FLAnimatedImageView allocInit];
    self.editorImageView.image = imageName(@"address_editor");
    [selectedBackView addSubview:self.editorImageView];
    [self.editorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.deleteButton.mas_left).offset(-10);
        make.centerY.equalTo(wSelf.deleteButton);
    }];
    
    
    
    
}
#pragma mark ----*  删除地址
/**
 *  删除地址
 */
- (void)deleteAddress{
    
    if ([self.delegate respondsToSelector:@selector(deleteAddressInfor:)]) {
        [self.delegate deleteAddressInfor:self.addressInfor];
    }
}
- (void)editorAddress
{
    if ([self.delegate respondsToSelector:@selector(editorAddressInfor:)]) {
        [self.delegate editorAddressInfor:self.addressInfor];
    }
}

#pragma mark ----*  设置默认
/**
 *  设置默认
 */
- (void)addressDefault
{
    if ([self.delegate respondsToSelector:@selector(setAddressDefault:)]) {
        [self.delegate setAddressDefault:self.addressInfor];
    }
}


@end
