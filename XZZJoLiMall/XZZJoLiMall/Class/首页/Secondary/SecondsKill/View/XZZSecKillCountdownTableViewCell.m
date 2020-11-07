//
//  XZZSecKillCountdownTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/12/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecKillCountdownTableViewCell.h"


@interface XZZSecKillCountdownTableViewCell ()
@property (nonatomic, strong) dispatch_source_t timer;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * stateLabel;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * daysLabel;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * colonLabel1;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * hrsLabel;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * colonLabel2;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * minLabel;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * colonLabel3;
/**
 * <#expression#>
 */
@property (nonatomic, weak)IBOutlet UILabel * secLabel;

@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation XZZSecKillCountdownTableViewCell

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

/**
 *  当一个对象从xib中创建初始化完毕的时候就会调用一次
 */
- (void)awakeFromNib {
    [super awakeFromNib];
 
    [self.daysLabel cutRounded:4];
    [self.hrsLabel cutRounded:4];
    [self.minLabel cutRounded:4];
    [self.secLabel cutRounded:4];
    
    self.daysLabel.textColor = button_back_color;
    self.colonLabel1.textColor = button_back_color;
    self.hrsLabel.textColor = button_back_color;
    self.colonLabel2.textColor = button_back_color;
    self.minLabel.textColor = button_back_color;
    self.colonLabel3.textColor = button_back_color;
    self.secLabel.textColor = button_back_color;
    
    [self.backView cutRounded:8];
    
}


- (void)setTime:(NSString *)time
{
    _time = time;
    [self startCountdown];
}

- (void)setState:(NSString *)state
{
    self.stateLabel.text = state;
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
    NSDate * endTimeDate = [self conversionDate:self.time];
    
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
                wSelf.daysLabel.text = [NSString stringWithFormat:@"%02d", day];
                wSelf.hrsLabel.text = [NSString stringWithFormat:@"%02d", hours];
                wSelf.minLabel.text = [NSString stringWithFormat:@"%02d", minutes];
                wSelf.secLabel.text = [NSString stringWithFormat:@"%02d", seconds];

            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
