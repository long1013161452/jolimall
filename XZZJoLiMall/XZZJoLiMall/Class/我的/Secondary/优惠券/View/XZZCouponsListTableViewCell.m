//
//  XZZCouponsListTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponsListTableViewCell.h"

@interface XZZCouponsListTableViewCell ()
/**
 * 背景图
 */
@property (nonatomic, strong)UIImageView * backImageView1;
/**
 * 背景图
 */
@property (nonatomic, strong)UIImageView * backImageView2;
/**
 * 背景图
 */
@property (nonatomic, strong)UIImageView * backImageView3;


/**
 * 优惠额度  label
 */
@property (nonatomic, strong)UILabel * discountAmountLabel;

/**
 * 到期时间  label
 */
@property (nonatomic, strong)UILabel * expiresTimeLabel;

/**
 * 优惠码code  label
 */
@property (nonatomic, strong)UILabel * couponsCodeLabel;

/**
 * 详情  label
 */
@property (nonatomic, strong)UILabel * detailsLabel;

/**
 * 使用按钮  button
 */
@property (nonatomic, strong)UIButton * useButton;
@end

@implementation XZZCouponsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)addView
{
    CGFloat left = 10;
    if (ScreenWidth == 320) {
        left = 7;
    }
    
    WS(wSelf)
    
    self.backImageView1 = [UIImageView allocInit];
    self.backImageView1.image = imageName(@"coupons_list_red_2");
    [self addSubview:self.backImageView1];
    [self.backImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-left);
        make.top.equalTo(@10);
        make.height.equalTo(@105);
        make.width.equalTo(@99);
    }];
    
    self.backImageView2 = [UIImageView allocInit];
    self.backImageView2.image = imageName(@"coupons_list_red_1");
    [self addSubview:self.backImageView2];
    [self.backImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.top.equalTo(wSelf.backImageView1);
        make.right.equalTo(wSelf.backImageView1.mas_left);
        make.height.equalTo(wSelf.backImageView1);
    }];
    
    self.backImageView3 = [UIImageView allocInit];
    self.backImageView3.image = imageName(@"coupons_list_red_4");
    [self addSubview:self.backImageView3];
    [self.backImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.backImageView2).offset(11);
        make.right.equalTo(wSelf.backImageView2).offset(3);
        make.bottom.equalTo(wSelf.backImageView2).offset(-30);
        make.height.equalTo(@2);
    }];
    
    self.discountAmountLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xf41c19) textFont:24 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self.backImageView2 addSubview:self.discountAmountLabel];
    [self.discountAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@17);
    }];
    
    self.detailsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    if (ScreenWidth == 320) {
        self.detailsLabel.numberOfLines = 2;
    }
    [self.backImageView2 addSubview:self.detailsLabel];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.discountAmountLabel);
        make.right.equalTo(wSelf.backImageView2);
        make.bottom.equalTo(wSelf.backImageView3.mas_top).offset(-2);
    }];
    
    self.expiresTimeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x666666) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self.backImageView2 addSubview:self.expiresTimeLabel];
    [self.expiresTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.detailsLabel);
        make.bottom.equalTo(@(-12.5));
    }];
    
    
    CGFloat width = 83.0;
    
    
    self.couponsCodeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:10 textAlignment:(NSTextAlignmentRight) tag:1];
    [self.backImageView2 addSubview:self.couponsCodeLabel];
    [self.couponsCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.expiresTimeLabel);
        make.right.equalTo(wSelf.backImageView2).offset(-5);
    }];
    
    self.useButton = [UIButton allocInitWithTitle:@"Use it" color:kColor(0x000000) selectedTitle:@"Use it" selectedColor:kColor(0x000000) font:13];
    self.useButton.layer.cornerRadius = 12;
    self.useButton.layer.masksToBounds = YES;
    self.useButton.backgroundColor = kColor(0xfff8f5);
    [self.useButton addTarget:self action:@selector(clickOnButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.useButton];
    [self.useButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.backImageView1);
        make.right.equalTo(wSelf.backImageView1).offset(-12);
        make.width.equalTo(@(width - 20));
        make.height.equalTo(@24);
    }];
}

- (void)clickOnButton
{
    !self.getCouponBlock?:self.getCouponBlock(self.couponsInfor);
}


- (void)setCouponsInfor:(XZZCouponsInfor *)couponsInfor
{
    _couponsInfor = couponsInfor;
    if (!self.useButton) {
        [self addView];
    }
//    self.couponsInforView.couponsInfor = couponsInfor;
    self.backImageView1.image = imageName(@"coupons_list_red_2");
    self.backImageView2.image = imageName(@"coupons_list_red_1");
    self.backImageView3.image = imageName(@"coupons_list_red_4");
    self.discountAmountLabel.textColor = kColor(0xf41c19);
    self.detailsLabel.textColor = kColor(0x000000);
    self.expiresTimeLabel.textColor = kColor(0x666666);
    self.couponsCodeLabel.textColor = kColor(0x000000);
    self.useButton.hidden = YES;
    
    if (self.isGoodsDetauls) {
        if (couponsInfor.isReceived) {
            self.useButton.hidden = YES;
        }else{
            self.useButton.hidden = NO;
        }
    }else{
        if (couponsInfor.status == 0) {//未使用
            if (self.couponAvailable && !couponsInfor.orderCanUse) {
                self.backImageView1.image = imageName(@"coupons_list_gray_3");
                self.backImageView2.image = imageName(@"coupons_list_gray_1");
                self.backImageView3.image = imageName(@"coupons_list_gray_4");
                self.discountAmountLabel.textColor = kColor(0xC2C2C2);
                self.detailsLabel.textColor = kColor(0xC2C2C2);
                self.expiresTimeLabel.textColor = kColor(0xC2C2C2);
                self.couponsCodeLabel.textColor = kColor(0xC2C2C2);
            }else{
                self.useButton.hidden = NO;
            }
        }else if (couponsInfor.status == 1){//已使用
            self.backImageView1.image = imageName(@"coupons_list_gray_3");
            self.backImageView2.image = imageName(@"coupons_list_gray_1");
            self.backImageView3.image = imageName(@"coupons_list_gray_4");
            self.discountAmountLabel.textColor = kColor(0xC2C2C2);
            self.detailsLabel.textColor = kColor(0xC2C2C2);
            self.expiresTimeLabel.textColor = kColor(0xC2C2C2);
            self.couponsCodeLabel.textColor = kColor(0xC2C2C2);
        }else{//已过期
            self.backImageView1.image = imageName(@"coupons_list_gray_2");
            self.backImageView2.image = imageName(@"coupons_list_gray_1");
            self.backImageView3.image = imageName(@"coupons_list_gray_4");
            self.discountAmountLabel.textColor = kColor(0xC2C2C2);
            self.detailsLabel.textColor = kColor(0xC2C2C2);
            self.expiresTimeLabel.textColor = kColor(0xC2C2C2);
            self.couponsCodeLabel.textColor = kColor(0xC2C2C2);
        }
    }
    if (couponsInfor.giftGoodsId) {
        self.discountAmountLabel.text =  couponsInfor.giftCopyWriting;
    }else if (couponsInfor.discountPercent) {
        self.discountAmountLabel.text =  couponsInfor.discountPercent;
    }else{
        self.discountAmountLabel.text =  couponsInfor.discountMoney;
    }
    
    self.detailsLabel.text = couponsInfor.prompt;
    if (couponsInfor.endTime) {
        self.expiresTimeLabel.text = [NSString stringWithFormat:@"Expires %@", [self timeFormat:@"yyyy-MM-dd" conversionDate:couponsInfor.endTime]];
    }else{
        if (self.isGoodsDetauls) {
          self.expiresTimeLabel.text = [NSString stringWithFormat:@"Expires in %@ days", couponsInfor.expireDays];
        }else{
        self.expiresTimeLabel.text = [NSString stringWithFormat:@"Expires in %@", couponsInfor.expireDays];
        }
    }
    if (couponsInfor.code) {
        self.couponsCodeLabel.text = [NSString stringWithFormat:@"Code:%@", couponsInfor.code];
    }else{
        self.couponsCodeLabel.text = @"";
    }
}

- (void)setButtonTitle:(NSString *)title
{
    [self.useButton setTitle:title forState:(UIControlStateNormal)];
    [self.useButton setTitle:title forState:(UIControlStateHighlighted)];
}


@end
