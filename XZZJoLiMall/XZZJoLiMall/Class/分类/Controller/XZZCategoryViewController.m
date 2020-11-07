//
//  XZZCategoryViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCategoryViewController.h"
#import "XZZGoodsListViewController.h"

#import "XZZMainCategoryView.h"

#import "XZZSubclassCategoryView.h"

@interface XZZCategoryViewController ()<XZZMyDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong) XZZMainCategoryView * mainCategoryView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSubclassCategoryView * subclassCategoryView;

@end

@implementation XZZCategoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self dataDownload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Category";
    
    
    CGFloat mainCategoryViewWidth = ScreenWidth / 4.0;
    WS(wSelf)
    XZZMainCategoryView * mainCategoryView = [XZZMainCategoryView allocInit];
    self.mainCategoryView = mainCategoryView;
    self.mainCategoryView.delegate = self;
    [self.view addSubview:mainCategoryView];
    [mainCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(wSelf.view);
        make.width.equalTo(@(mainCategoryViewWidth));
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self.view addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(wSelf.view);
        make.width.equalTo(@.5);
        make.left.equalTo(wSelf.mainCategoryView.mas_right);
    }];
    weakView(weak_dividerView, dividerView)
    XZZSubclassCategoryView * subclassCategoryView = [XZZSubclassCategoryView allocInit];
    self.subclassCategoryView = subclassCategoryView;
    subclassCategoryView.delegate = self;
    [self.view addSubview:subclassCategoryView];
    [subclassCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(wSelf.view);
        make.left.equalTo(weak_dividerView.mas_right);
    }];
    
    [self addChatAndActivityFloatWindow];
}
#pragma mark ----*  数据下载
/**
 *  数据下载
 */
- (void)dataDownload
{
    WS(wSelf)
    if (self.mainCategoryView.categoryArray.count <= 0) {
        loadView(self.view);
    }
    [XZZDataDownload categoryGetAllInforHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.mainCategoryView.categoryArray = data;
        }
        loadViewStop;
    }];
}
#pragma mark ----选中主分类  category 分类信息  source 来源视图或者控制器
/**
 *  选中主分类  category 分类信息  source 来源视图或者控制器
 */
- (void)selectiveClassificationInfor:(XZZCategory *)category source:(id)source
{

    if ([source isEqual:self.mainCategoryView]) {
        self.subclassCategoryView.category = category;
    }else{
        NSLog(@"%s %d 行", __func__, __LINE__);
        NSLog(@"二级   三级分类");
        
        XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
            categoryGoods.categoryId = category.ID;        
        
        XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
        goodsListVC.myTitle = category.name;
        goodsListVC.categoryGoods = categoryGoods;
        [self pushViewController:goodsListVC animated:YES];
    }
}

@end
