//
//  XZZFilteringAndSortingView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/14.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZFilteringAndSortingView.h"


@interface XZZFilteringAndSortingView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * titleLabel;


/**
 * 背景
 */
@property (nonatomic, strong)UIView * backView;

/**
 * 展示所有的排序
 */
@property (nonatomic, strong)UIView * allSortView;

/**
 * 选择的排序试图
 */
@property (nonatomic, strong)XZZSortingView * selectionSortView;


@end

@implementation XZZFilteringAndSortingView


- (void)addView
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    WS(wSelf)
    self.backgroundColor = [UIColor whiteColor];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnSortSelectionBox)]];
    
    UILabel * titleLabel = [UILabel allocInit];
    titleLabel.textColor = kColor(0x000000);
    titleLabel.font = textFont(14);
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.bottom.equalTo(wSelf);
    }];
    
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    imageView.image = imageName(@"list_Sorting_an");
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(5);
        make.centerY.equalTo(titleLabel);
    }];
    
    if (!self.hiddenFilter) {
        FLAnimatedImageView * filterImageView = [FLAnimatedImageView allocInit];
        filterImageView.image = imageName(@"list_screening");
        [self addSubview:filterImageView];
        [filterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf).offset(-10);
            make.centerY.equalTo(titleLabel);
        }];
        
        UILabel * filterLabel = [UILabel allocInit];
        filterLabel.textColor = kColor(0x000000);
        filterLabel.font = textFont(14);
        filterLabel.text = @"Filter";
        [self addSubview:filterLabel];
        [filterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(filterImageView.mas_left).offset(-5);
            make.top.bottom.equalTo(wSelf);
        }];
        
        UIButton * button = [UIButton allocInit];
        [button addTarget:self action:@selector(clickOnFilterSelectionBox) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(filterLabel);
            make.right.top.bottom.right.equalTo(wSelf);
        }];
    }
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    
}


- (void)setSelectedSorting:(NSString *)selectedSorting
{
    _selectedSorting = selectedSorting;
    self.titleLabel.text = selectedSorting;
}
#pragma mark ----点击弹出筛选选择框
- (void)clickOnFilterSelectionBox
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    !self.selectionFilter?:self.selectionFilter();
    [self hiddenSortView];
}

#pragma mark ----点击弹出排序选择框
- (void)clickOnSortSelectionBox
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if (self.backView.superview) {
        [self hiddenSortView];
    }else{
        [self showSortView];
    }
}

- (UIView *)backView
{
    if (!_backView) {
        CGFloat navHeight = StatusRect.size.height > 20 ? 88 : 64;
        UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, navHeight + self.height, ScreenWidth, ScreenHeight)];
        backView.backgroundColor = kColorWithRGB(0, 0, 0, .5);
        backView.layer.masksToBounds = YES;
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSortView)]];
        
        self.allSortView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        self.allSortView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:self.allSortView];
        CGFloat top = 0;
        CGFloat height = 45;
        int tag = 0;
        for (NSString * str in self.sortingArray) {
            XZZSortingView * sotingView = [XZZSortingView allocInitWithFrame:CGRectMake(0, top, ScreenWidth, height) title:str];
            sotingView.selected = [str isEqualToString:self.selectedSorting];
            sotingView.tag = tag;
            [self.allSortView addSubview:sotingView];
            [sotingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnSelectionSortTap:)]];
            if ([str isEqualToString:self.selectedSorting]) {
                self.selectionSortView = sotingView;
            }
            top = sotingView.bottom;
            tag++;
        }
        self.allSortView.height = top;
        self.allSortView.top = -self.allSortView.height;
        
        self.backView = backView;
    }
    return _backView;
}

- (void)clickOnSelectionSortTap:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    !self.selectionSort?:self.selectionSort(index);
    self.selectedSorting = self.sortingArray[index];
    self.selectionSortView.selected = NO;
    XZZSortingView * view = (XZZSortingView *)tap.view;
    view.selected = YES;
    self.selectionSortView = view;
    [self hiddenSortView];
}



- (void)showSortView
{
    WS(wSelf)
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow * window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
        [window addSubview:self.backView];
        [self.backView bringSubviewToFront:window];

        
        [UIView animateWithDuration:.3 animations:^{
            wSelf.allSortView.top = 0;
        } completion:^(BOOL finished) {
            
        }];
    });
    
    
}

- (void)hiddenSortView
{
    WS(wSelf)
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            wSelf.allSortView.bottom = 0;
        } completion:^(BOOL finished) {
            [wSelf.backView removeFromSuperview];
        }];
    });
    

}




@end



@implementation XZZSortingView

+ (id)allocInitWithFrame:(CGRect)frame title:(NSString *)title
{
    XZZSortingView * view = [self allocInitWithFrame:frame];
    view.backgroundColor = kColor(0xffffff);
    [view addView];
    view.sortingTitleLabel.text = title;
    return view;
}

- (void)addView
{
    WS(wSelf)
    
    self.sortingTitleLabel = [UILabel allocInit];
    self.sortingTitleLabel.font = textFont(14);
    [self addSubview:self.sortingTitleLabel];
    [self.sortingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(wSelf);
        make.left.equalTo(@15);
    }];
    
    self.selectedImageView = [FLAnimatedImageView allocInit];
    self.selectedImageView.image = imageName(@"list_Sorting_selected");
    [self addSubview:self.selectedImageView];
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf);
        make.right.equalTo(wSelf).offset(-15);
    }];
}


- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.selectedImageView.hidden = NO;
        self.sortingTitleLabel.textColor = kColor(0x000000);
    }else{
        self.selectedImageView.hidden = YES;
        self.sortingTitleLabel.textColor = kColor(0x555555);
    }
}

@end



