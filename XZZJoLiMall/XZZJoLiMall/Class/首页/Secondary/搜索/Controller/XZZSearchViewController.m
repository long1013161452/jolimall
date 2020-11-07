//
//  XZZSearchViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSearchViewController.h"
#import "XZZSearchGoodsListViewController.h"
#import "XZZWordsSearch.h"

/***  存储位置 */
#define search_History @"my_search_History"

@interface XZZSearchViewController ()<UITextFieldDelegate, XZZMyDelegate>

/**
 * 输入框
 */
@property (nonatomic, strong)UITextField * textField;

/**
 * 滚动视图
 */
@property (nonatomic, strong)UIScrollView * scrollView;



/**
 * 热搜视图
 */
@property (nonatomic, strong)UIView * wordsView;
/**
 * 搜索历史信息
 */
@property (nonatomic, strong)NSMutableArray * wordsArray;
/**
 * 搜索历史  视图
 */
@property (nonatomic, strong)UIView * historyView;
/**
 * 搜索历史信息
 */
@property (nonatomic, strong)NSMutableArray * historyArray;

@end

@implementation XZZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameVC = @"搜索";
    
    [self setNavigationBar];
    [self downloadWord];
    
}
#pragma mark ----*  设置导航栏
/**
 *  设置导航栏
 */
- (void)setNavigationBar
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    UIButton * rightButton = [UIButton allocInitWithTitle:@"Cancel" color:kColor(0x000000) selectedTitle:@"Cancel" selectedColor:kColor(0x000000) font:14];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    if (ScreenWidth == 320) {
        rightButton.titleLabel.font = textFont(12);
    }
    [rightButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];

    UIView * backView = [UIView allocInit];
    backView.backgroundColor = kColor(0xf8f8f8);
    backView.frame = CGRectMake(0, 0, ScreenWidth - 40, 35);
    self.navigationItem.titleView = backView;
    
    FLAnimatedImageView * searchImageV = [FLAnimatedImageView allocInitWithFrame:CGRectMake(10, 0, 15, 15) imageName:@"home_search"];
    searchImageV.centerY = backView.height / 2.0;
    [backView addSubview:searchImageV];
    
    CGFloat left = searchImageV.right + 10;
    UITextField * textField = [UITextField allocInitWithFrame:CGRectMake(left, 0, backView.width - left - 40, 35)];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeySearch;//Next按钮
    textField.delegate = self;
    textField.placeholder = @"Type something";
    [backView addSubview:textField];
    self.textField = textField;
}
#pragma mark ---- *  下载热词
/**
 *  下载热词
 */
- (void)downloadWord
{
    loadView(nil)
    WS(wSelf)
    NSLog(@"%s %d 行", __func__, __LINE__);
    [XZZDataDownload searchGetHotSearchTermHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            NSArray * array = data;
            NSMutableArray * wordsArray = @[].mutableCopy;
            for (XZZWordsSearch * wordsSearch in array) {
                [wordsArray addObject:wordsSearch.hotWord];
            }
            wSelf.wordsArray = wordsArray;
        }
        loadViewStop
        [wSelf addView];
        [wSelf.textField becomeFirstResponder];
    }];
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) {
        self.historyArray = @[].mutableCopy;
        NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:search_History];
        if (array.count) {
            [_historyArray addObjectsFromArray:array];
        }
    }
    return _historyArray;
}


- (void)addView{
    WS(wSelf)
    UIScrollView * scrollView = [UIScrollView allocInit];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    
    if (self.wordsArray.count) {
        
        self.wordsView = [self title:@"Hot Search" searchInfor:self.wordsArray delete:NO];
        [self.scrollView addSubview:self.wordsView];
    }
    [self addHistoryInforView];
}

- (UIView *)title:(NSString *)title searchInfor:(NSArray *)array delete:(BOOL)delete
{
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    
    UILabel * titleLabel = [UILabel allocInitWithFrame:CGRectMake(10, 0, 300, 40)];
    titleLabel.text = title;
    titleLabel.font = textFont(13);
    [view addSubview:titleLabel];
    
    
    if (delete) {
        /**
         *  删除按钮
         */
        UIButton * button = [UIButton allocInit];
        [button setImage:imageName(@"home_search_delete") forState:(UIControlStateNormal)];
        [button setImage:imageName(@"home_search_delete") forState:(UIControlStateHighlighted)];
        button.frame = CGRectMake(ScreenWidth - 80, titleLabel.top, 80, 40);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);//
        [button addTarget:self action:@selector(deleteHistoryInfor) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
    }

    CGFloat top = titleLabel.bottom + 10;
    CGFloat left = 10;
    CGFloat height = 25;
    CGFloat interval = 10;
    
    for (NSString * searchInfor in array) {
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(left, top, 10, height)];
        [button setTitle:searchInfor forState:(UIControlStateNormal)];
        [button setTitle:searchInfor forState:(UIControlStateHighlighted)];
        [button setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
        [button setTitleColor:kColor(0x000000) forState:(UIControlStateHighlighted)];
        button.titleLabel.font = textFont(13);
        [button addTarget:self action:@selector(clickOnSearch:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        [button sizeToFit];
        button.width += 20;
        button.layer.cornerRadius = button.height / 2.0;
        button.layer.borderWidth = .5;
        button.layer.borderColor = kColor(0xaaaaaa).CGColor;
        
        if (button.right > ScreenWidth - interval) {
            button.left = 10;
            button.top = button.bottom + interval;
        }
        top = button.top;
        left = button.right + interval;
    }
    view.height = top + height + 50;
    
    return view;
}

- (void)clickOnSearch:(UIButton *)button{
    [self searchItems:button.titleLabel.text];
}

- (void)deleteHistoryInfor
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:search_History];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.historyArray removeAllObjects];
    [self addHistoryInforView];
}
#pragma mark ----*  创建搜索历史视图
/**
 *  创建搜索历史视图
 */
- (void)addHistoryInforView
{
    [self.historyView removeFromSuperview];
    self.historyView = [self title:@"Recent Search" searchInfor:self.historyArray delete:YES];
    self.historyView.top = self.wordsView.bottom;
    [self.scrollView addSubview:self.historyView];
    self.scrollView.contentSize = CGSizeMake(0, self.historyView.bottom);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * searchContent = [textField.text removeForeAndAftSpaces];
    if (searchContent.length) {
        [textField resignFirstResponder];//取消第一响应者
        [self searchItems:textField.text];
    }else{
        self.textField.text = @"";
        SVProgressError(@"Please enter search content!")
    }
    return YES;
}

#pragma mark ----*  搜索商品信息
/**
 *  搜索商品信息
 */
- (void)searchItems:(NSString *)searchContent
{
    WS(wSelf)
    XZZSearchGoodsListViewController * searchGoodsListVC = [XZZSearchGoodsListViewController allocInit];
    searchGoodsListVC.searchContent = searchContent;
    searchGoodsListVC.delegate = self;
    [searchGoodsListVC setSelectionSearchContent:^(NSString * _Nonnull searchContent) {
        [wSelf searchStoreSearchContent:searchContent];
    }];
    [self pushViewController:searchGoodsListVC animated:YES];
}
#pragma mark ---- *   搜索 存储搜索内容
/**
 *   *   搜索 存储搜索内容
 */
- (void)searchStoreSearchContent:(NSString *)content
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    content = [content removeForeAndAftSpaces];
    self.textField.text = content;
    if (content.length) {
        [self.historyArray removeObject:content];
        [self.historyArray insertObject:content atIndex:0];
        if (self.historyArray.count > 10) {
            [self.historyArray removeLastObject];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.historyArray forKey:search_History];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self addHistoryInforView];
}



@end
