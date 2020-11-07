//
//  XZZFilterView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZFilterView.h"


#define MAXSPEED 800

#define left_distance 50

@interface XZZFilterView ()

/**
 * 背景视图  透明层
 */
@property (nonatomic, strong)UIView * backView;

/**
 * 尺寸颜色的背景视图
 */
@property (nonatomic, strong)UIView * sizeAndColorBackView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * topView;

/**
 * 选中的尺寸按钮
 */
@property (nonatomic, strong)NSMutableArray * selectedSizeButtonArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * colorView;

/**
 * 选中的c颜色按钮
 */
@property (nonatomic, strong)NSMutableArray * selectedColorButtonArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableDictionary * sizeCodeDictionary;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * colorCodeArray;

@end



@implementation XZZFilterView


+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZFilterView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

- (NSMutableArray *)selectedSizeButtonArray
{
    if (!_selectedSizeButtonArray) {
        self.selectedSizeButtonArray = @[].mutableCopy;
    }
    return _selectedSizeButtonArray;
}
- (NSMutableArray *)selectedColorButtonArray
{
    if (!_selectedColorButtonArray) {
        self.selectedColorButtonArray = @[].mutableCopy;
    }
    return _selectedColorButtonArray;
}

- (NSMutableDictionary *)sizeCodeDictionary
{
    if (!_sizeCodeDictionary) {
        self.sizeCodeDictionary = @{}.mutableCopy;
    }
    return _sizeCodeDictionary;
}
- (NSMutableArray *)colorCodeArray
{
    if (!_colorCodeArray) {
        self.colorCodeArray = @[].mutableCopy;
    }
    return _colorCodeArray;
}

- (void)addView{
    
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(screenGesture:)]];

    
    self.backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.backView.backgroundColor = kColorWithRGB(0, 0, 0, .55);
    [self.backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:self.backView];
    
    self.sizeAndColorBackView = [UIView allocInitWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth - left_distance, ScreenHeight)];
    self.sizeAndColorBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.sizeAndColorBackView];
    
    CGFloat navHeight = StatusRect.size.height > 20 ? 88 : 64;
    
    UILabel * titleLabel = [UILabel allocInitWithFrame:CGRectMake(0, navHeight - 44, self.sizeAndColorBackView.width, 44)];
    titleLabel.text = @"FILTER";
    titleLabel.font = textFont_bold(17);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.sizeAndColorBackView addSubview:titleLabel];

    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, navHeight, titleLabel.width, .5)];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self.sizeAndColorBackView addSubview:dividerView];
    
    CGFloat buttonBottom = StatusRect.size.height > 20 ? 34 : 0;
    CGFloat buttonHeight = 48;
    
    UIButton * clearButton = [UIButton allocInitWithFrame:CGRectMake(0, self.height - buttonHeight - buttonBottom, self.sizeAndColorBackView.width / 2.0, buttonHeight)];
    clearButton.backgroundColor = [UIColor whiteColor];
    [clearButton setTitle:@"Clear" forState:(UIControlStateNormal)];
    [clearButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    [clearButton addTarget:self action:@selector(cleckOnClearButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.sizeAndColorBackView addSubview:clearButton];

    
    UIButton * applyButton = [UIButton allocInitWithFrame:CGRectMake(clearButton.right, clearButton.top, clearButton.width, clearButton.height)];
    applyButton.backgroundColor = [UIColor whiteColor];
    [applyButton setTitle:@"Apply" forState:(UIControlStateNormal)];
    [applyButton setTitleColor:kColor(0xffffff) forState:(UIControlStateNormal)];
    applyButton.backgroundColor = button_back_color;
    [applyButton addTarget:self action:@selector(clickOnApplyButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.sizeAndColorBackView addSubview:applyButton];

    UIView * dividerView2 = [UIView allocInitWithFrame:CGRectMake(0, clearButton.top, clearButton.width, .5)];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [self.sizeAndColorBackView addSubview:dividerView2];
    
    UIView * dividerView3 = [UIView allocInitWithFrame:CGRectMake(0, clearButton.bottom - .5, clearButton.width, .5)];
    dividerView3.backgroundColor = DIVIDER_COLOR;
    [self.sizeAndColorBackView addSubview:dividerView3];
    
    
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, dividerView.bottom, dividerView.width, dividerView2.top - dividerView.bottom)];
    [self.sizeAndColorBackView addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    
}

#pragma mark ----*  点击了clear按钮
/**
 *  点击了clear按钮
 */
- (void)cleckOnClearButton
{
    while (self.selectedColorButtonArray.count) {
        [self selectColorInforButton:self.selectedColorButtonArray[0]];
    }
    while (self.selectedSizeButtonArray.count) {
        [self selectSizeInforButton:self.selectedSizeButtonArray[0]];
    }
    [self.sizeCodeDictionary removeAllObjects];
    [self.colorCodeArray removeAllObjects];
    [self clickOnApplyButton];
}

#pragma mark ----*  点击APPly按钮
/**
 *  点击APPly按钮
 */
- (void)clickOnApplyButton
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    NSMutableArray * size = @[].mutableCopy;
    NSArray * keys = self.sizeCodeDictionary.allKeys;
    for (NSString * key in keys) {
        [size addObjectsFromArray:self.sizeCodeDictionary[key]];
    }
    
    !self.selectSizeAndColorInfor?:self.selectSizeAndColorInfor(size, self.colorCodeArray);
    [self removeView];
}

- (void)setSizeArray:(NSArray *)sizeArray
{
    _sizeArray = sizeArray;
    [self addSizeView];
    CGFloat top = 0;//StatusRect.size.height > 20 ? 88 : 64;
    self.colorView.top = self.topView ? (self.topView.bottom + 10) : top;
    self.scrollView.contentSize = CGSizeMake(0, self.colorView.bottom + 10);
}

- (void)addSizeView
{
    CGFloat viewTop = 0;//StatusRect.size.height > 20 ? 88 : 64;

    NSInteger sizeTap = 0;
    for (XZZFilterSize * size in self.sizeArray) {
        if (sizeTap >= 2) {
            break;
        }
        self.topView = [UIView allocInitWithFrame:CGRectMake(0, viewTop, self.sizeAndColorBackView.width, 100)];
        self.topView.tag = sizeTap;
        [self.scrollView addSubview:self.topView];
        sizeTap++;
        UILabel * sizeLabel = [UILabel labelWithFrame:CGRectMake(15, 15, 300, 20) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
        sizeLabel.text = size.typeName;
        [self.topView addSubview:sizeLabel];
        
        CGFloat left = sizeLabel.left;
        CGFloat top = sizeLabel.bottom + 20;
        CGFloat width = 45;
        CGFloat height = 45;
        CGFloat bottom = sizeLabel.bottom;
        
        CGFloat interval = 10;
        NSInteger tag = 0;
        for (NSString * sizeCode in size.shortSizeCodeList) {
            UIButton * button = [UIButton allocInitWithTitle:sizeCode color:kColor(0x000000) selectedTitle:sizeCode selectedColor:kColor(0xffffff) font:11];
            button.frame = CGRectMake(left, top, width, height);
            if ([sizeCode isEqualToString:@"One size"]) {
                button.width = 100;
            }
            [button addTarget:self action:@selector(selectSizeInforButton:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.topView addSubview:button];
            button.tag = tag;
            button.backgroundColor = BACK_COLOR;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = height / 2.0;
            
            UIView * roundView = [UIView allocInitWithFrame:CGRectMake(1, 1, button.width - 2, button.height - 2)];
            roundView.layer.borderColor = [UIColor whiteColor].CGColor;
            roundView.layer.borderWidth = 2;
            roundView.layer.masksToBounds = YES;
            roundView.layer.cornerRadius = roundView.height / 2.0;
            roundView.userInteractionEnabled = NO;
            [button addSubview:roundView];
            
            if (button.right + interval > self.topView.width) {
                button.left = sizeLabel.left;
                button.top += (height + interval);
            }
            tag++;
            left = button.right + interval;
            top = button.top;
            bottom = button.bottom;
        }
        
        self.topView.height = bottom + 40;
        
        UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.topView.height - .5, self.topView.width, .5)];
        dividerView.backgroundColor = DIVIDER_COLOR;
        [self.topView addSubview:dividerView];
        
        viewTop = self.topView.bottom + 10;
    }
    
}

- (void)selectSizeInforButton:(UIButton *)button{
    if (!button) {
        return;
    }
    
    button.selected = !button.selected;
    NSInteger superZViewTag = button.superview.tag;
    XZZFilterSize * size = self.sizeArray[superZViewTag];
    NSArray * sizeCodeList = size.sizeCodeList;
    NSString * sizeCode = sizeCodeList[button.tag];
    
    NSString * tagStr = [NSString stringWithFormat:@"%ld", (long)button.superview.tag];
    NSMutableArray * array = self.sizeCodeDictionary[tagStr];
    if (!array) {
        array = @[].mutableCopy;
        [self.sizeCodeDictionary setValue:array forKey:tagStr];
    }
    
    if (!button.selected) {
        [self.selectedSizeButtonArray removeObject:button];
        button.backgroundColor = [UIColor whiteColor];
        [array removeObject:sizeCode];
        button.backgroundColor = BACK_COLOR;
    }else{
        [self.selectedSizeButtonArray addObject:button];
        button.backgroundColor = button_back_color;
        [array addObject:sizeCode];
    }
}

- (void)setColorArray:(NSArray *)colorArray
{
    _colorArray = colorArray;
    [self addColorView];
    CGFloat top = 0;//StatusRect.size.height > 20 ? 88 : 64;
    self.colorView.top = self.topView ? (self.topView.bottom + 10) : top;
    self.scrollView.contentSize = CGSizeMake(0, self.colorView.bottom + 10);}

- (void)addColorView
{
    CGFloat navHeight = 0;//StatusRect.size.height > 20 ? 88 : 64;

    self.colorView = [UIView allocInitWithFrame:CGRectMake(0, navHeight, self.sizeAndColorBackView.width, 100)];
    [self.scrollView addSubview:self.colorView];
    
    UILabel * colorLabel = [UILabel labelWithFrame:CGRectMake(15, 15, 100, 20) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    colorLabel.text = @"Color";
    [self.colorView addSubview:colorLabel];
    
    CGFloat left = colorLabel.left;
    CGFloat top = colorLabel.bottom + 20;
    CGFloat width = 32;
    CGFloat height = 32;
    if (ScreenWidth > 375) {
        width = 38;
        height = 38;
    }
    
    CGFloat bottom = colorLabel.bottom;
    
    CGFloat interval = 10;
    CGFloat tag = 0;
    for (XZZFilterColor * color in self.colorArray) {
        UIButton * button = [UIButton allocInit];
        button.frame = CGRectMake(left, top, width, height);
        [button addTarget:self action:@selector(selectColorInforButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.colorView addSubview:button];
        button.tag = tag;
        button.layer.borderColor = kColor(0xF41C19).CGColor;
        button.layer.cornerRadius = width / 2.0;
        button.layer.masksToBounds = YES;
        
        
        UIView * view = [UIView allocInitWithFrame:CGRectMake(2, 2, width - 4, height - 4)];
        view.backgroundColor = color.color;
        view.layer.cornerRadius = view.width / 2.0;
        view.userInteractionEnabled = NO;
        [button addSubview:view];
        if (tag == 1) {
            view.layer.borderColor = DIVIDER_COLOR.CGColor;
            view.layer.borderWidth = .5;
        }
        
        if (button.right + interval > self.colorView.width) {
            button.left = colorLabel.left;
            button.top += (height + interval);
        }
        tag++;
        left = button.right + interval;
        top = button.top;
        bottom = button.bottom;
    }
    
    self.colorView.height = bottom + 30;
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.colorView.height - .5, self.colorView.width, .5)];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self.colorView addSubview:dividerView];
}

- (void)selectColorInforButton:(UIButton *)button{
    if (!button) {
        return;
    }
    button.selected = !button.selected;
    XZZFilterColor * color = self.colorArray[button.tag];
    if (!button.selected) {
        [self.selectedColorButtonArray removeObject:button];
        button.layer.borderWidth = 0;
        [self.colorCodeArray removeObject:color.colorCode];
    }else{
        [self.selectedColorButtonArray addObject:button];
        button.layer.borderWidth = 1;
        [self.colorCodeArray addObject:color.colorCode];
    }
}

- (void)screenGesture:(UIPanGestureRecognizer *)pan
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    CGPoint point = [pan translationInView:pan.view];
    
    //移动的速度
    CGPoint verPoint =  [pan velocityInView:pan.view];
    
    NSLog(@"%@-----", NSStringFromCGPoint(verPoint));
    
    self.sizeAndColorBackView.left += point.x;
    
    if (self.sizeAndColorBackView.left < left_distance) {
        self.sizeAndColorBackView.left = left_distance;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (verPoint.x < -MAXSPEED) {
            
            [self showRightVc];
            
        }else{
            
            if (self.sizeAndColorBackView.left <= ScreenWidth / 2.0 + 25) {
                
                [self showRightVc];
                
            }else{
                
                [self hideLeftVc];
                
            }
        }
    }
    
    
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
}

- (void)showRightVc
{
    [UIView animateWithDuration:.2 animations:^{
        self.sizeAndColorBackView.left = left_distance;
    }];
}

- (void)hideLeftVc
{
    [UIView animateWithDuration:.3 animations:^{
        self.sizeAndColorBackView.left = ScreenWidth;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}



- (void)addSuperviewView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window addSubview:wSelf];
        [UIView animateWithDuration:.3 animations:^{
            wSelf.sizeAndColorBackView.left = left_distance;
        }];
    });
    
    
}

- (void)removeView
{
    WS(wSelf)
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            wSelf.sizeAndColorBackView.left = ScreenWidth;
        } completion:^(BOOL finished) {
            [wSelf removeFromSuperview];
        }];
    });
    

}

@end
