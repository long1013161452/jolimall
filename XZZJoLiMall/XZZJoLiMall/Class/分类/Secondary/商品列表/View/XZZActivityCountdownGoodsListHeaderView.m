//
//  XZZActivityCountdownGoodsListHeaderView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/6.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZActivityCountdownGoodsListHeaderView.h"



@interface XZZActivityCountdownGoodsListHeaderView ()
/**
 * <#expression#>
 */
@property (nonatomic, strong)dispatch_source_t timer;
/**
 * 倒计时  label  1
 */
@property (nonatomic, strong)UILabel * countdownLabel1;

/**
 * 倒计时  label 2
 */
@property (nonatomic, strong)UILabel * countdownLabel2;

/**
 * 倒计时  label  3
 */
@property (nonatomic, strong)UILabel * countdownLabel3;

/**
 * 倒计时  label  4
 */
@property (nonatomic, strong)UILabel * countdownLabel4;


@end






@implementation XZZActivityCountdownGoodsListHeaderView

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

- (void)setActivityInfor:(XZZActivityInfor *)activityInfor
{
    _activityInfor = activityInfor;
    [self addView];
}

#pragma mark ---- * 创建视图信息
/**
 * 创建视图信息
 */
- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
        
        [self removeAllSubviews];
    
    UIImageView * backView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    backView.image = imageName(@"list_sale_bg");
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(wSelf);
    }];
    
    UIImageView * titleBackImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"list_saleprice"];
    [backView addSubview:titleBackImageView];
    titleBackImageView.image = [[UIImage imageNamed:@"list_saleprice"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 18, 16, 26) resizingMode:UIImageResizingModeStretch];
    [titleBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(wSelf);
    }];
    
    FLAnimatedImageView * iconImageView = [FLAnimatedImageView allocInit];
    [iconImageView cutRounded:16];
    if (self.activityInfor.iconPictureTwo.length) {
        [iconImageView addImageFromUrlStr:self.activityInfor.iconPictureTwo];
    }else{
        iconImageView.image = imageName(@"list_sale");
    }
    [backView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.left.equalTo(@16);
        make.width.height.equalTo(@32);
    }];
    
    weakView(weak_iconImageView, iconImageView)
    weakView(weak_titleBackImageView, titleBackImageView)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:16 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.text = self.activityInfor.longTitle;
//    titleLabel.font = textFont_bold(16);
//    titleLabel.font = [UIFont italicSystemFontOfSize:16];
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    titleLabel.numberOfLines = 2;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_iconImageView.mas_right).offset(5);
        make.top.bottom.equalTo(wSelf);
        make.right.equalTo(weak_titleBackImageView).offset(-40);
    }];
        
    UILabel * saleEndLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:12 textAlignment:(NSTextAlignmentRight) tag:1];
    saleEndLabel.text = @"Sale ends in:";
    [backView addSubview:saleEndLabel];
    [saleEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
    }];
    weakView(weak_saleEndLabel, saleEndLabel)
    ///秒
    self.countdownLabel4 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel4.text = @"00";
    self.countdownLabel4.font = textFont_bold(14);
    [self.countdownLabel4 cutRounded:3];
    [backView addSubview:self.countdownLabel4];
    [self.countdownLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf).offset(6);
        make.right.equalTo(backView).offset(-16);
        make.right.equalTo(weak_saleEndLabel);
        make.width.height.equalTo(@24);
        make.top.equalTo(weak_saleEndLabel.mas_bottom);
    }];
        
    UILabel * colonLabel1 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:self.countdownLabel4.backgroundColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel1.text = @":";
    [backView addSubview:colonLabel1];
    [colonLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.width.equalTo(@10);
        make.right.equalTo(wSelf.countdownLabel4.mas_left);
    }];
    
    weakView(weak_colonLabel1, colonLabel1)
    ///分钟
    self.countdownLabel3 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel3.text = @"00";
    self.countdownLabel3.font = textFont_bold(14);
    [self.countdownLabel3 cutRounded:3];
    [backView addSubview:self.countdownLabel3];
    [self.countdownLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.right.equalTo(weak_colonLabel1.mas_left);
        make.width.height.equalTo(wSelf.countdownLabel4);
    }];
        
    UILabel * colonLabel2 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:self.countdownLabel4.backgroundColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel2.text = @":";
    [backView addSubview:colonLabel2];
    [colonLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.width.equalTo(@10);
        make.right.equalTo(wSelf.countdownLabel3.mas_left);
    }];
    
    weakView(weak_colonLabel2, colonLabel2)
    self.countdownLabel2 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel2.text = @"00";
    self.countdownLabel2.font = textFont_bold(14);
    [self.countdownLabel2 cutRounded:3];
    [backView addSubview:self.countdownLabel2];
    [self.countdownLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.right.equalTo(weak_colonLabel2.mas_left);
        make.width.height.equalTo(wSelf.countdownLabel4);
    }];
        
    UILabel * colonLabel3 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:self.countdownLabel4.backgroundColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel3.text = @":";
    [backView addSubview:colonLabel3];
    [colonLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.width.equalTo(@10);
        make.right.equalTo(wSelf.countdownLabel2.mas_left);
    }];
    
    weakView(weak_colonLabel3, colonLabel3)
    self.countdownLabel1 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel1.text = @"00";
    self.countdownLabel1.font = textFont_bold(14);
    [self.countdownLabel1 cutRounded:3];
    [backView addSubview:self.countdownLabel1];
    [self.countdownLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.right.equalTo(weak_colonLabel3.mas_left);
        make.width.height.equalTo(wSelf.countdownLabel4);
        make.left.equalTo(titleBackImageView.mas_right).offset(5);
    }];

    
    [self startCountdown];
}





#pragma mark ----*  开始倒计时
/**
 *  开始倒计时
 */
- (void)startCountdown
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    NSDate * currentDate = [NSDate date];
    NSDate * endTimeDate = [self conversionDate:self.activityInfor.endTime];
    
    NSTimeInterval endTimeTime = 0;
    NSTimeInterval currentTime = 0;
    
    if (currentDate) {
        currentTime = currentDate.timeIntervalSince1970;
    }
    if (endTimeDate) {
        endTimeTime = endTimeDate.timeIntervalSince1970;
    }
    
    if (currentTime == 0) {
        currentTime = [NSDate date].timeIntervalSince1970;
    }
    WS(wSelf)
    __block int timeout = endTimeTime - currentTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                !wSelf.refreshBlock?:wSelf.refreshBlock();

            });
        }else{
            int day = timeout / (3600 * 24);
            int hours = (timeout % (3600 * 24)) / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.countdownLabel1.text = [NSString stringWithFormat:@"%02d", day];
                wSelf.countdownLabel2.text = [NSString stringWithFormat:@"%02d", hours];
                wSelf.countdownLabel3.text = [NSString stringWithFormat:@"%02d", minutes];
                wSelf.countdownLabel4.text = [NSString stringWithFormat:@"%02d", seconds];

            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
