//
//  XZZCartActivityCountdownHeaderView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/6.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCartActivityCountdownHeaderView.h"



@interface XZZCartActivityCountdownHeaderView ()

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



@implementation XZZCartActivityCountdownHeaderView

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOutActivity)]];
    }
    return self;
}

- (void)setActivityOrSecKillInfor:(id)activityOrSecKillInfor
{
    _activityOrSecKillInfor = activityOrSecKillInfor;
    [self addView];
}

- (void)clickOutActivity
{
    !self.viewActivityGoodsInfor?:self.viewActivityGoodsInfor(self.activityOrSecKillInfor);
}

- (void)addView{
    [self removeAllSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    BOOL isActivity = [self.activityOrSecKillInfor isKindOfClass:[XZZActivityInfor class]];
    
    XZZActivityInfor * activityInfor = (XZZActivityInfor *)self.activityOrSecKillInfor;
    XZZSecKillVo * secKillVo = (XZZSecKillVo *)self.activityOrSecKillInfor;
    
    WS(wSelf)
    FLAnimatedImageView * iconImageView = nil;
    if (isActivity) {
        iconImageView = [FLAnimatedImageView allocInit];
        [iconImageView cutRounded:10];
        if (activityInfor.iconPictureOne.length) {
            [iconImageView addImageFromUrlStr:activityInfor.iconPictureOne];
        }else{
            iconImageView.image = imageName(@"goods_details_discount_icon");
        }
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf);
            make.left.equalTo(wSelf).offset(10);
            make.width.height.equalTo(@20);
        }];
    }

    
    weakView(weak_iconImageView, iconImageView)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x333333) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.font = textFont_bold(14);
    if (isActivity) {
        titleLabel.text = activityInfor.shortTitle;
    }else{
        titleLabel.text = @"Sale Price Ends In";
    }
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isActivity) {
            make.left.equalTo(@40);
        }else{
            make.left.equalTo(@10);
        }
        make.top.bottom.equalTo(wSelf);
        make.right.equalTo(wSelf.mas_centerX);
    }];
    weakView(weak_titleLabel, titleLabel)
    
//    UIImageView * arrowImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"address_arrow"];
//    [self addSubview:arrowImageView];
//    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(wSelf).offset(-11);
//        make.centerY.equalTo(wSelf);
//        make.width.equalTo(@8);
//    }];
    
//    weakView(weak_arrowImageView, arrowImageView)
    
    UIColor * countdownTextColor = button_back_color;//kColor(0xd73e3e);
    UIColor * countdownBackColor = kColor(0xf9e7e7);
    UIFont * countdownTextFont = textFont_bold(14);
    
    self.countdownLabel4 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:countdownBackColor textColor:countdownTextColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel4.font = countdownTextFont;
    [self.countdownLabel4 cutRounded:4];
    self.countdownLabel4.text = @"00";
    [self addSubview:self.countdownLabel4];
    [self.countdownLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.right.equalTo(wSelf).offset(-15);
        make.height.width.equalTo(@24);
    }];
    
    UILabel * colonLabel1 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:countdownTextColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel1.font = countdownTextFont;
    colonLabel1.text = @":";
    [self addSubview:colonLabel1];
    [colonLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.width.equalTo(@10);
        make.right.equalTo(wSelf.countdownLabel4.mas_left);
    }];
    
    weakView(weak_colonLabel1, colonLabel1)
    self.countdownLabel3 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:countdownBackColor textColor:countdownTextColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel3.font = countdownTextFont;
    [self.countdownLabel3 cutRounded:4];
    self.countdownLabel3.text = @"00";
    [self addSubview:self.countdownLabel3];
    [self.countdownLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.right.equalTo(weak_colonLabel1.mas_left);
        make.height.width.equalTo(wSelf.countdownLabel4);
    }];
    
    UILabel * colonLabel2 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:countdownTextColor textFont:12 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel2.text = @":";
    colonLabel2.font = countdownTextFont;
    [self addSubview:colonLabel2];
    [colonLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.width.equalTo(weak_colonLabel1);
        make.right.equalTo(wSelf.countdownLabel3.mas_left);
    }];
    
    weakView(weak_colonLabel2, colonLabel2)
    self.countdownLabel2 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:countdownBackColor textColor:countdownTextColor textFont:12 textAlignment:(NSTextAlignmentCenter) tag:1];
    [self.countdownLabel2 cutRounded:4];
    self.countdownLabel2.font = countdownTextFont;
    self.countdownLabel2.text = @"00";
    [self addSubview:self.countdownLabel2];
    [self.countdownLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.right.equalTo(weak_colonLabel2.mas_left);
        make.height.width.equalTo(wSelf.countdownLabel4);
    }];
    
    UILabel * colonLabel3 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:countdownTextColor textFont:12 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel3.text = @":";
    colonLabel3.font = countdownTextFont;
    [self addSubview:colonLabel3];
    [colonLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.width.equalTo(weak_colonLabel1);
        make.right.equalTo(wSelf.countdownLabel2.mas_left);
    }];
    
    weakView(weak_colonLabel3, colonLabel3)
    self.countdownLabel1 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:countdownBackColor textColor:countdownTextColor textFont:12 textAlignment:(NSTextAlignmentCenter) tag:1];
    [self.countdownLabel1 cutRounded:4];
    self.countdownLabel1.text = @"00";
    self.countdownLabel1.font = countdownTextFont;
    [self addSubview:self.countdownLabel1];
    [self.countdownLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.right.equalTo(weak_colonLabel3.mas_left);
        make.height.width.equalTo(wSelf.countdownLabel4);
//        make.left.equalTo(weak_titleLabel.mas_right);
    }];
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0 )];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf);
        make.height.equalTo(@.5);
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
    BOOL isActivity = [self.activityOrSecKillInfor isKindOfClass:[XZZActivityInfor class]];
      
      XZZActivityInfor * activityInfor = (XZZActivityInfor *)self.activityOrSecKillInfor;
      XZZSecKillVo * secKillVo = (XZZSecKillVo *)self.activityOrSecKillInfor;
    NSDate * endTimeDate = [self conversionDate: isActivity ? activityInfor.endTime : secKillVo.endTime];
    
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
//                wSelf.activityInfor.isShow = NO;
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
