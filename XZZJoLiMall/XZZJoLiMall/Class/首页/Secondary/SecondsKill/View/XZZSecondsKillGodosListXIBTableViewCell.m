//
//  XZZSecondsKillGodosListXIBTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/28.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecondsKillGodosListXIBTableViewCell.h"




@interface XZZSecondsKillGodosListXIBTableViewCell ()
/**
 * 背景 带圆角
 */
@property (nonatomic, weak)IBOutlet UIView * roundedCornersbackView;
/**
 * 背景
 */
@property (nonatomic, weak)IBOutlet UIView * backView;
/**
 * 分割线
 */
@property (nonatomic, weak)IBOutlet UIView * deviewView;
/**
 * 背景  top
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backTop;
/**
 * 背景 bottom
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backBottom;



/**
 * 图片
 */
@property (nonatomic, weak)IBOutlet FLAnimatedImageView * goodsImageView;
/**
 * 已结束
 */
@property (nonatomic, weak)IBOutlet UIView * saleExpiredView;
/**
 * 已结束
 */
@property (nonatomic, weak)IBOutlet UILabel * saleExpiredLabel;
/**
 * 商品名
 */
@property (nonatomic, weak)IBOutlet UILabel * goodsTitleLabel;
/**
 * 售价
 */
@property (nonatomic, weak)IBOutlet UILabel * priceLabel;
/**
 * 虚价划线
 */
@property (nonatomic, weak)IBOutlet UIView * nominalPriceView;
/**
 * 虚价
 */
@property (nonatomic, weak)IBOutlet UILabel * nominalPriceLabel;
/**
 * 向下箭头
 */
@property (nonatomic, weak)IBOutlet UIImageView * arrowImageView;
/**
 * 折扣
 */
@property (nonatomic, weak)IBOutlet UILabel * offLabel;
/**
 * 进度条  底部
 */
@property (nonatomic, weak)IBOutlet UIView * progressBackView;
/**
 * 进度条
 */
@property (nonatomic, weak)IBOutlet UIView * progressView;
/**
 * 进度条 宽度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidth;

/**
 * 进度 label
 */
@property (nonatomic, weak)IBOutlet UILabel * progressLabel;
/**
 * buy now 按钮
 */
@property (nonatomic, weak)IBOutlet UIButton * buyNowButton;
/**
 * sold Out
 */
@property (nonatomic, weak)IBOutlet UIButton * soldOutButton;
/**
 * 提醒 按钮
 */
@property (nonatomic, weak)IBOutlet UIButton * remindMeButton;
/**
 * 取消提醒 按钮
 */
@property (nonatomic, weak)IBOutlet UIButton * cancleReminderButton;



@end




@implementation XZZSecondsKillGodosListXIBTableViewCell


/**
 *  当一个对象从xib中创建初始化完毕的时候就会调用一次
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    
    self.deviewView.backgroundColor = DIVIDER_COLOR;
    
    [self.roundedCornersbackView cutRounded:8];
    [self.goodsImageView cutRounded:4];
    
    self.priceLabel.textColor = button_back_color;
    self.saleExpiredLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    
    [self.buyNowButton cutRounded:16];
    self.buyNowButton.backgroundColor = button_back_color;
    self.buyNowButton.userInteractionEnabled = NO;
    
    [self.soldOutButton cutRounded:16];
    self.soldOutButton.userInteractionEnabled = NO;
    
    [self.remindMeButton cutRounded:16];
    self.remindMeButton.backgroundColor = button_back_color;
    
    [self.cancleReminderButton cutRounded:16];
    [self.cancleReminderButton setTitleColor:button_back_color forState:(UIControlStateNormal)];
    [self.cancleReminderButton setTitleColor:button_back_color forState:(UIControlStateHighlighted)];
    self.cancleReminderButton.layer.borderColor = button_back_color.CGColor;
    self.cancleReminderButton.layer.borderWidth = 0.5;
    
    [self.progressBackView cutRounded:4];
    [self.progressView cutRounded:4];
    
    self.saleExpiredView.hidden = NO;
    self.buyNowButton.hidden = YES;
    self.soldOutButton.hidden = YES;
    self.remindMeButton.hidden = YES;
    self.cancleReminderButton.hidden = YES;
    self.progressView.backgroundColor = kColor(0x999999);
    self.progressBackView.hidden = NO;
    self.progressLabel.hidden = NO;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setGoods:(XZZSecondsKillGoods *)goods
{
    _goods = goods;
    
    [self.goodsImageView addImageFromUrlStr:goods.pictureUrl];
    
    self.goodsTitleLabel.text = goods.title;
    self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goods.salePrice];
    self.nominalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", goods.currentPrice];;
    self.offLabel.text = [NSString stringWithFormat:@"%.0f%%OFF", goods.discountPercent * 100];
    
    self.progressWidth.constant = 80 * ((goods.haveSale * 1.0) / (goods.seckillStock * 1.0));
    if (self.state == XZZSecondsKillStateOngoing) {
        BOOL hidden = goods.seckillStock <= goods.haveSale;
        self.buyNowButton.hidden = hidden;
        self.soldOutButton.hidden = !hidden;
    }else if (self.state == XZZSecondsKillStateNot) {
        BOOL hidden = PushRecord_isPush(self.secKillId, goods.ID);
        self.remindMeButton.hidden = hidden;
        self.cancleReminderButton.hidden = !hidden;
    }
}

- (IBAction)clickOutbuyNowButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goodsViewShopCartAccordingId:state:)]) {
        [self.delegate goodsViewShopCartAccordingId:self.goods.ID state:YES];
    }
}

- (IBAction)clickOutRemindMeButton:(id)sender {
    !self.remindMe?:self.remindMe(self.goods.ID, self.goodsImageView.image);
}

- (IBAction)clickOutCancleReminderButton:(id)sender {
    !self.cancleReminder?:self.cancleReminder(self.goods.ID, self.goodsImageView.image);
}



- (void)setState:(XZZSecondsKillState)state
{
    if (self.state != state) {
        _state = state;
        
        switch (state) {
            case XZZSecondsKillStateEnd:{//以结束
                self.saleExpiredView.hidden = NO;
                self.buyNowButton.hidden = YES;
                self.soldOutButton.hidden = YES;
                self.remindMeButton.hidden = YES;
                self.cancleReminderButton.hidden = YES;
                self.progressView.backgroundColor = kColor(0x999999);
                self.progressBackView.hidden = NO;
                self.progressLabel.hidden = NO;
            }
                break;
            case XZZSecondsKillStateOngoing:{//进行中
                self.saleExpiredView.hidden = YES;
                
                self.buyNowButton.hidden = NO;
                self.soldOutButton.hidden = NO;
                
                self.remindMeButton.hidden = YES;
                self.cancleReminderButton.hidden = YES;
                
                self.progressView.backgroundColor = button_back_color;
                self.progressBackView.hidden = NO;
                self.progressLabel.hidden = NO;
            }
                break;
            case XZZSecondsKillStateNot:{//未开始
                self.saleExpiredView.hidden = YES;
                
                self.buyNowButton.hidden = YES;
                self.soldOutButton.hidden = YES;
                
                self.remindMeButton.hidden = YES;
                self.cancleReminderButton.hidden = YES;
                
                self.progressBackView.hidden = YES;
                self.progressLabel.hidden = YES;
            }
                break;
                
            default:
                break;
        }
        
    }
}

- (void)setGoodsLocation:(XZZSecondsKillGoodsLocation)goodsLocation
{
    if (_goodsLocation != goodsLocation) {
        _goodsLocation = goodsLocation;
        switch (goodsLocation) {
            case XZZSecondsKillGoodsFirst:{//第一个商品   上部圆角  下部没有
                self.backTop.constant = 20;
                self.backBottom.constant = 0;
            }
                break;
            case XZZSecondsKillGoodsMiddle:{//中间商品  上下没有圆角
                self.backTop.constant = 0;
                self.backBottom.constant = 0;
            }
                break;
            case XZZSecondsKillGoodsLast:{//最后一个   下部圆角  上部没有
                self.backTop.constant = 0;
                self.backBottom.constant = 20;
            }
                break;
            default:
                break;
        }
        
    }else{
        
    }
}








@end
