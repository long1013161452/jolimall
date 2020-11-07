//
//  XZZCountdownChellysunView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCountdownChellysunView.h"


@interface XZZCountdownChellysunView ()
/**
 * <#expression#>
 */
@property (nonatomic, strong)dispatch_source_t timer;
/**
 * 倒计时背景
 */
@property (nonatomic, strong)UIView * countdownBackView;

/**
 * 倒计时  天
 */
@property (nonatomic, strong)UILabel * dayLabel;

/**
 * 倒计时  小时
 */
@property (nonatomic, strong)UILabel * hoursLabel;

/**
 * 倒计时  分钟
 */
@property (nonatomic, strong)UILabel * minutesLabel;

/**
 * 倒计时  秒
 */
@property (nonatomic, strong)UILabel * secondsLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

@end

#define activity_interval 8
#define Aspect_ratio (108.0 / 718.0)
#define activity_Commodity_width 108
#define Commodity_image_Aspect_ratio (4.0 / 3.0)

@implementation XZZCountdownChellysunView

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    if (goodsArray.count) {
        [self addViewTwo];
    }else{
        self.height = 0;
    }
}

- (void)addViewTwo{
    CGFloat left = activity_interval;

    CGFloat commodityheight = self.scrollView.height;

    
    for (int i = 0; i < self.goodsArray.count; i++) {
        XZZCountdownChellysunGoodsView * goodsView = [XZZCountdownChellysunGoodsView allocInitWithFrame:CGRectMake(left , 0, activity_Commodity_width, commodityheight)];
        goodsView.tag = i;
        goodsView.goods = self.goodsArray[i];
        [goodsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnGoodsTap:)]];
        [self.scrollView addSubview:goodsView];
        left = goodsView.right + activity_interval;
    }
    
    /**
     *  创建所有的按钮
     */
    UIButton * allButtonTwo = [UIButton allocInitWithFrame:CGRectMake(left, 0, activity_Commodity_width, activity_Commodity_width * 406.0 / 304.0)];
    [allButtonTwo setImage:imageName(@"home_all_activity") forState:(UIControlStateNormal)];
    [allButtonTwo setImage:imageName(@"home_all_activity") forState:(UIControlStateHighlighted)];
    [allButtonTwo addTarget:self action:@selector(clickOnViewAll) forControlEvents:(UIControlEventTouchUpInside)];
    [allButtonTwo setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    allButtonTwo.titleLabel.font = textFont(11);
    [self.scrollView addSubview:allButtonTwo];
    
    self.scrollView.contentSize = CGSizeMake(allButtonTwo.right + activity_interval, 0);
}

- (void)addView{
    
    CGFloat width = (ScreenWidth - activity_interval * 2);
    //    CGFloat height = width * Aspect_ratio;
    self.backgroundColor = [UIColor whiteColor];
    CGFloat countdownHeight = 19;
    CGFloat countdownWidth = 19;
    CGFloat colonWidth = 10;
    
    [self removeAllSubviews];
    
    UIView * activityView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    activityView.backgroundColor = kColor(0xf8f8f8);
    [self addSubview:activityView];
    
    UILabel * flashDealslabel = [[UILabel alloc] init];
    flashDealslabel.frame = CGRectMake(13,0,80,activityView.height);
    flashDealslabel.text = @"Flash Deals";
    flashDealslabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    flashDealslabel.textColor = Selling_price_color;
    [activityView addSubview:flashDealslabel];
    [flashDealslabel sizeToFit];
    flashDealslabel.height = activityView.height;
    
    self.countdownBackView = [UIView allocInitWithFrame:CGRectMake(flashDealslabel.right + 10, 0, 300, activityView.height)];
    [activityView addSubview:self.countdownBackView];
    
    self.dayLabel = [self createLabel:CGRectMake(0, 0, countdownWidth, countdownHeight) textColor:kColor(0xffffff) backColor:Selling_price_color text:@"00" fontSize:12];
    self.dayLabel.centerY = flashDealslabel.centerY;
    [self.countdownBackView addSubview:self.dayLabel];
    
    UILabel * colonLabel1 = [self createLabel:CGRectMake(self.dayLabel.right, self.dayLabel.top, colonWidth, countdownHeight) textColor:Selling_price_color backColor:[UIColor clearColor] text:@":" fontSize:15];
    [self.countdownBackView addSubview:colonLabel1];
    
    self.hoursLabel = [self createLabel:CGRectMake(colonLabel1.right, colonLabel1.top, countdownWidth, countdownHeight) textColor:kColor(0xffffff) backColor:Selling_price_color text:@"00" fontSize:12];
    [self.countdownBackView addSubview:self.hoursLabel];
    
    UILabel * colonLabel2 = [self createLabel:CGRectMake(self.hoursLabel.right, self.dayLabel.top, colonWidth, countdownHeight) textColor:Selling_price_color backColor:[UIColor clearColor] text:@":" fontSize:15];
    [self.countdownBackView addSubview:colonLabel2];
    
    self.minutesLabel = [self createLabel:CGRectMake(colonLabel2.right, colonLabel2.top, countdownWidth, countdownHeight) textColor:kColor(0xffffff) backColor:Selling_price_color text:@"00" fontSize:12];
    [self.countdownBackView addSubview:self.minutesLabel];
    
    UILabel * colonLabel3 = [self createLabel:CGRectMake(self.minutesLabel.right, self.dayLabel.top, colonWidth, countdownHeight) textColor:Selling_price_color backColor:[UIColor clearColor] text:@":" fontSize:15];
    [self.countdownBackView addSubview:colonLabel3];
    
    self.secondsLabel = [self createLabel:CGRectMake(colonLabel3.right, colonLabel3.top, countdownWidth, countdownHeight) textColor:kColor(0xffffff) backColor:Selling_price_color text:@"00" fontSize:12];
    [self.countdownBackView addSubview:self.secondsLabel];
    
    [self countdown];
    
    
    /**
     *  创建所有的按钮
     */
    UIButton * allButton = [UIButton allocInitWithFrame:CGRectMake(activityView.width - 80, 0, 80, activityView.height)];
    [allButton setTitle:@"View All >" forState:(UIControlStateNormal)];
    [allButton setTitle:@"View All >" forState:(UIControlStateHighlighted)];
    [allButton addTarget:self action:@selector(clickOnViewAll) forControlEvents:(UIControlEventTouchUpInside)];
    [allButton setTitleColor:Selling_price_color forState:(UIControlStateNormal)];
    allButton.titleLabel.font = textFont(11);
    [activityView addSubview:allButton];
    
    CGFloat commodityheight = activity_Commodity_width * Commodity_image_Aspect_ratio + 20 + 20;
    
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, activityView.bottom + activity_interval, ScreenWidth, commodityheight)];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    

    
    
    self.height = scrollView.bottom + home_Template_interval;
    
    
    
}

#pragma mark ----   点击手势   商品
- (void)clickOnGoodsTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnGoodsAccordingId:state:)]) {
        NSLog(@"%s %d 行 点击了商品  ", __func__, __LINE__);
        
        id goods = self.goodsArray[tap.view.tag];
        NSString * goodsId = @"";
        BOOL state = false ;
        if ([goods isKindOfClass:[XZZGoodsList class]]) {
            XZZGoodsList * goodsList = goods;
            goodsId = goodsList.goodsId;
            state = YES;
        }
        [self.delegate clickOnGoodsAccordingId:goodsId state:state];
    }
}

#pragma mark ----查看所有活动信息
/**
 *  查看所有活动信息
 */
- (void)clickOnViewAll
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:[self.homeTemplateArray firstObject]];
    }
 
}

- (void)countdown
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    NSDate * currentDate = [NSDate date];
    NSDate * endTimeDate = [self conversionDate:self.homeTemplateArray[0].endTime];
    
    
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
    //    NSTimeInterval currentTime = [NSDate date].timeIntervalSince1970;
    
    
    
    
    WS(wSelf)
    __block int timeout = endTimeTime - currentTime; //倒计时时间
    //    timeout = self.timeout;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                wSelf.dayLabel.text = @"00";
                wSelf.hoursLabel.text = @"00";
                wSelf.minutesLabel.text = @"00";
                wSelf.secondsLabel.text = @"00";
                wSelf.countdownBackView.hidden = YES;
            });
        }else{
            int day = timeout / (3600 * 24);
            int hours = (timeout % (3600 * 24)) / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.countdownBackView.hidden = NO;
                //设置界面的按钮显示 根据自己需求设置
                wSelf.dayLabel.text = [NSString stringWithFormat:@"%02d", day];
                wSelf.hoursLabel.text = [NSString stringWithFormat:@"%02d", hours];
                wSelf.minutesLabel.text = [NSString stringWithFormat:@"%02d", minutes];
                wSelf.secondsLabel.text = [NSString stringWithFormat:@"%02d", seconds];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end


@interface XZZCountdownChellysunGoodsView ()

/**
 * 图片
 */
@property (nonatomic, strong)FLAnimatedImageView * goodsImageView;

/**
 * 售价
 */
@property (nonatomic, strong)UILabel * priceLabel;

/**
 * 虚价
 */
@property (nonatomic, strong)UILabel * nominalPriceLabel;

/**
 * 折扣背景
 */
@property (nonatomic, strong)UIImageView * discountImageView;

/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * discountLabel;

@end


@implementation XZZCountdownChellysunGoodsView

- (void)setGoods:(id)goods
{
    _goods = goods;
    
    [self addView];
    
    if ([goods isKindOfClass:[XZZGoodsList class]]) {
        XZZGoodsList * goodsList = goods;
        if (goodsList.cornerMark) {
            self.discountImageView.hidden = NO;
            self.discountLabel.text = [NSString stringWithFormat:@"%d%%\nOFF", goodsList.cornerMarkValue];
        }else{
            self.discountImageView.hidden = YES;
        }
        
        [self.goodsImageView addImageFromUrlStr:goodsList.pictureUrl];
        self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.discountPrice > 0 ? goodsList.discountPrice : goodsList.currentPrice];
        if (goodsList.nominalPrice > 0) {
            self.nominalPriceLabel.text = [NSString stringWithFormat:@"$%.2f", goodsList.nominalPrice];
        }else{
            self.nominalPriceLabel.text = @"";
        }
        
        
        
    }
    

}

- (void)addView
{
    WS(wSelf)
    self.goodsImageView = [FLAnimatedImageView allocInit];
    [self.goodsImageView cutRounded:5];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  图片大于或小于显示区域
    self.goodsImageView.clipsToBounds = YES;
    [self.goodsImageView cutRounded:4];
    [self addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(wSelf.goodsImageView.mas_width).multipliedBy(image_height_width_proportion);
    }];
    
    self.priceLabel = [UILabel allocInit];
    self.priceLabel.font = Selling_price_font;
    self.priceLabel.textColor = Selling_price_color;
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf);
        make.top.equalTo(wSelf.goodsImageView.mas_bottom);
        make.height.equalTo(@(price_height_Two));
    }];
    
    self.nominalPriceLabel = [UILabel allocInit];
    self.nominalPriceLabel.font = original_price_font;
    self.nominalPriceLabel.textColor = original_price_color;
    [self addSubview:self.nominalPriceLabel];
//    [self.nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(wSelf.priceLabel.mas_right).offset(5);
//        make.centerY.equalTo(wSelf.priceLabel).offset(1);
//    }];
    [self.nominalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.priceLabel);
        make.bottom.equalTo(wSelf).offset(-5);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = original_price_color;
    [self.nominalPriceLabel addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.centerY.equalTo(wSelf.nominalPriceLabel);
        make.height.equalTo(@.5);
    }];
    
}

- (UIImageView *)discountImageView
{
    if (!_discountImageView) {
        WS(wSelf)
        self.discountImageView = [UIImageView allocInit];
        _discountImageView.image = imageName(@"home_discount_No_rounded_corners");
        [self addSubview:_discountImageView];
        /***  折扣背景图片约束 */
        [_discountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf);
            make.left.equalTo(@5);
            make.width.equalTo(@21);
            make.height.equalTo(@24);
        }];
    }
    return _discountImageView;
}

- (UILabel *)discountLabel
{
    if (!_discountLabel) {
        WS(wSelf)
        self.discountLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xbc24c3) textFont:7 textAlignment:(NSTextAlignmentCenter) tag:1];
        _discountLabel.numberOfLines = 2;
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.font = textFont_bold(7);
        [self.discountImageView addSubview:_discountLabel];
        [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(wSelf.discountImageView);
        }];
    }
    return _discountLabel;
}

@end
