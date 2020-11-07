//
//  HYCircleProgressView.m
//  HYCircleProgressView-master
//
//  Created by 黄海燕 on 16/8/12.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "HYCircleProgressView.h"

#define kDuration 2.0
#define kDefaultLineWidth 1.5

@interface HYCircleProgressView()

@property (nonatomic,strong) CAShapeLayer *backgroundLayer;
@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic,assign) CGFloat sumSteps;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation HYCircleProgressView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createSubViews];
        //init default variable
        self.backgroundLineWidth = kDefaultLineWidth;
        self.progressLineWidth = kDefaultLineWidth;
        self.percentage = 0;
        self.offset = 0;
        self.sumSteps = 0;
        self.step = 0.05;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createSubViews];
        //init default variable
        self.backgroundLineWidth = kDefaultLineWidth;
        self.progressLineWidth = kDefaultLineWidth;
        self.percentage = 0;
        self.offset = 0;
        self.sumSteps = 0;
        self.step = 0.05;
    }
    return self;
}

- (void)createSubViews
{
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.frame = self.bounds;
    _backgroundLayer.fillColor = nil;
    _backgroundLayer.strokeColor = kColor(0xd8d8d8).CGColor;
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor = kColor(0xfe5d41).CGColor;
    
    [self.layer addSublayer:_backgroundLayer];
    [self.layer addSublayer:_progressLayer];
}

#pragma mark - draw circleLine
- (void)setBackgroundCircleLine
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)
                                          radius:(self.frame.size.width - _backgroundLineWidth)/2 - _offset
                                      startAngle:0
                                        endAngle:M_PI*2
                                       clockwise:YES];
    
    _backgroundLayer.path = path.CGPath;
}

- (void)setProgressCircleLine
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)
                                          radius:(self.frame.size.width - _progressLineWidth)/2 - _offset
                                      startAngle:-M_PI_2
                                        endAngle:-M_PI_2 + M_PI *2
                                       clockwise:YES];
    
    _progressLayer.path = path.CGPath;
}

- (void)setDigitTintColor:(UIColor *)digitTintColor
{
    _digitTintColor = digitTintColor;
}

- (void)setBackgroundLineWidth:(CGFloat)backgroundLineWidth
{
    _backgroundLineWidth = backgroundLineWidth;
    _backgroundLayer.lineWidth = _backgroundLineWidth;
    [self setBackgroundCircleLine];
}

- (void)setProgressLineWidth:(CGFloat)progressLineWidth
{
    _progressLineWidth = progressLineWidth;
    _progressLayer.lineWidth = _progressLineWidth;
    [self setProgressCircleLine];
}

- (void)setPercentage:(CGFloat)percentage
{
    _percentage = percentage;
}

- (void)setBackgroundStrokeColor:(UIColor *)backgroundStrokeColor
{
    _backgroundStrokeColor = backgroundStrokeColor;
    _backgroundLayer.strokeColor = _backgroundStrokeColor.CGColor;
}

- (void)setProgressStrokeColor:(UIColor *)progressStrokeColor
{
    _progressStrokeColor = progressStrokeColor;
    _progressLayer.strokeColor = _progressStrokeColor.CGColor;
}

#pragma mark - progress animated YES or NO
- (void)setProgress:(CGFloat)percentage animated:(BOOL)animated
{
    self.percentage = percentage;
    _progressLayer.strokeEnd = _percentage;
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = [NSNumber numberWithFloat:0.0];
        animation.toValue = [NSNumber numberWithFloat:_percentage];
        animation.duration = kDuration;
        
        //start timer
        _timer = [NSTimer scheduledTimerWithTimeInterval:_step
                                                  target:self
                                                selector:@selector(numberAnimation)
                                                userInfo:nil
                                                 repeats:YES];
        
        
        [_progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    }else{
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [CATransaction commit];
    }
}

- (void)numberAnimation
{
    _sumSteps += _step;
    if (_sumSteps >= kDuration) {
        
        UIColor * color = self.backgroundStrokeColor;
        self.backgroundStrokeColor = self.progressStrokeColor;
        self.progressStrokeColor = color;
        
        
        [_timer invalidate];
        [self loadView];
        _sumSteps = 0;
        return;
    }
}


- (void)loadView
{
    _progressLayer.strokeEnd = 1;
    self.percentage = 1;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:_percentage];
    animation.duration = kDuration;
    //start timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:_step
                                              target:self
                                            selector:@selector(numberAnimation)
                                            userInfo:nil
                                             repeats:YES];
    
    
    [_progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
}

- (void)stop
{
    [_timer invalidate];
}

@end
