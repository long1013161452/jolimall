//
//  XZZSecondsKillGodosListTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecondsKillGodosListTableViewCell.h"


@interface XZZSecondsKillGodosListTableViewCell ()

/**
 * 背景 带圆角
 */
@property (nonatomic, strong)UIView * roundedCornersbackView;
/**
 * 背景
 */
@property (nonatomic, strong)UIView * backView;

/**
 * 图片
 */
@property (nonatomic, strong)FLAnimatedImageView * goodsImageView;
/**
 * 以结束
 */
@property (nonatomic, strong)UILabel * saleExpiredLabel;
/**
 * 商品名
 */
@property (nonatomic, strong)UILabel * goodsTitleLabel;
/**
 * 售价
 */
@property (nonatomic, strong)UILabel * priceLabel;
/**
 * 虚价
 */
@property (nonatomic, strong)UILabel * nominalPriceLabel;
/**
 * 向下箭头
 */
@property (nonatomic, strong)UIImageView * arrowImageView;
/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * offLabel;
/**
 * 进度条  底部
 */
@property (nonatomic, strong)UIView * progressBackView;
/**
 * 进度条
 */
@property (nonatomic, strong)UIView * progressView;
/**
 * 进度 label
 */
@property (nonatomic, strong)UIView * progressLabel;
/**
 * buy now 按钮
 */
@property (nonatomic, strong)UIButton * buyNowButton;
/**
 * sold Out
 */
@property (nonatomic, strong)UIButton * soldOutButton;
/**
 * 提醒 按钮
 */
@property (nonatomic, strong)UIButton * remindMeButton;
/**
 * 取消提醒 按钮
 */
@property (nonatomic, strong)UIButton * cancleReminderButton;

@end


@implementation XZZSecondsKillGodosListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)addView{
    WS(wSelf)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [backView cutRounded:8];
    [self addSubview:backView];
    self.roundedCornersbackView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(wSelf);
        make.center.equalTo(wSelf);
    }];
    weakView(weak_backView, backView);
    self.backView = [UIView allocInit];
    self.backView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_backView);
        make.top.equalTo(@20);
        make.bottom.equalTo(weak_backView);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weak_backView);
        make.height.equalTo(@(divider_view_width));
    }];
    
    self.goodsImageView = [FLAnimatedImageView allocInit];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.goodsImageView.clipsToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 4;
    [backView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_backView).offset(12);
        
        make.top.equalTo(weak_backView).offset(12);
       make.centerY.equalTo(weak_backView); make.width.equalTo(wSelf.imageView.mas_height).multipliedBy(image_width_height_proportion);
    }];
    
    self.saleExpiredLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColorWithRGB(0, 0, 0, 0.3) textColor:kColor(0xffffff) textFont:16 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.saleExpiredLabel.text = @"Sale Expired";
    self.saleExpiredLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    self.saleExpiredLabel.hidden = YES;
    [backView addSubview:self.saleExpiredLabel];
    [self.saleExpiredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.centerY.centerX.equalTo(wSelf.goodsImageView);
    }];
    
    
    self.goodsTitleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.goodsTitleLabel.numberOfLines = 2;
    [backView addSubview:self.goodsTitleLabel];
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.goodsImageView.mas_right).offset(12);
        make.top.equalTo(wSelf.goodsImageView);
        make.right.equalTo(weak_backView).offset(-12);
    }];
    
    self.priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:button_back_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.priceLabel.font = textFont_bold(14);
    [backView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.goodsTitleLabel);
        make.centerY.equalTo(wSelf.goodsImageView);
    }];
    
    self.nominalPriceLabel =  [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:original_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.nominalPriceLabel];
    [self.nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.priceLabel.mas_right).offset(5);
        make.centerY.equalTo(wSelf.priceLabel);
    }];
    
    self.arrowImageView = [UIImageView allocInit];
    [backView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.
    }];
    
    
}

- (void)setGoodsLocation:(XZZSecondsKillGoodsLocation)goodsLocation
{
    if (_goodsLocation != goodsLocation) {
        _goodsLocation = goodsLocation;
        WS(wSelf)
        switch (goodsLocation) {
            case XZZSecondsKillGoodsFirst:{//第一个商品   上部圆角  下部没有
                [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@20);
                    make.bottom.equalTo(wSelf.roundedCornersbackView);
                }];
            }
                break;
            case XZZSecondsKillGoodsMiddle:{//中间商品  上下没有圆角
                [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@0);
                    make.bottom.equalTo(wSelf.roundedCornersbackView);
                }];
            }
                break;
            case XZZSecondsKillGoodsLast:{//最后一个   下部圆角  上部没有
                [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@0);
                    make.bottom.equalTo(wSelf.roundedCornersbackView).offset(-20);
                }];
            }
                break;
            default:
                break;
        }
        
    }else{
        
    }
}


@end
