//
//  XZZCommentsListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCommentsListViewController.h"

#import "XZZCommentsTableViewCell.h"
#import "XZZGoodsScoreView.h"

@interface XZZCommentsListViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;
/**
 * 导航栏
 */
@property (nonatomic, strong)UIView * myNavView;
/**
 * 返回按钮
 */
@property (nonatomic, strong)UIButton * backButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * dataSource;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int page;

@end

@implementation XZZCommentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = YES;

    self.myTitle = @"COMMENTS";
    
    self.nameVC = [NSString stringWithFormat:@"评论-%@", self.goodsId];

    
    self.page = 0;
    WS(wSelf)

    //获取导航栏的rect
    CGRect navRect = self.navigationController.navigationBar.frame;
    
    self.myNavView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, StatusRect.size.height+navRect.size.height)];
    self.myNavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myNavView];
    [self.myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
        make.height.equalTo(@(StatusRect.size.height+navRect.size.height));
    }];
    
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:17 textAlignment:(NSTextAlignmentCenter) tag:1];
    titleLabel.text = self.myTitle;
    [self.myNavView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@40);
        make.bottom.equalTo(wSelf.myNavView).offset(-2);
        make.centerX.equalTo(wSelf.myNavView);
    }];
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.myNavView.height - .5, ScreenWidth, .5)];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self.myNavView addSubview:dividerView];
    
    weakView(weak_titleLabel, titleLabel)
    self.backButton = [UIButton allocInit];
    [self.backButton setImage:imageName(@"nav_back") forState:(UIControlStateNormal)];
    [self.backButton setImage:imageName(@"nav_back") forState:(UIControlStateHighlighted)];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);//
    //    self.backButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_titleLabel);
        make.left.equalTo(@15);
        make.width.equalTo(@50);
        make.height.equalTo(@40);
    }];
    
    XZZGoodsScoreView * goodsScoreView = [XZZGoodsScoreView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    goodsScoreView.hiddenViewAll = YES;
    goodsScoreView.score = self.goodsScore;
    [self.view addSubview:goodsScoreView];
    CGFloat height = goodsScoreView.height;
    [goodsScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.myNavView.mas_bottom);
        make.height.equalTo(@(height));
    }];
    
    weakView(weak_goodsScoreView, goodsScoreView)
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf.view);
        make.top.equalTo(weak_goodsScoreView.mas_bottom);
    }];
    
    [self.tableView addLoading:self refreshingAction:@selector(dataDownload)];
    
    self.dataSource = @[].mutableCopy;
    [self dataDownload];
    
}

- (void)dataDownload
{
    self.page++;
    WS(wSelf)
    [XZZDataDownload goodsGetGoodsComments:self.goodsId page:self.page httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [wSelf.dataSource addObjectsFromArray:data];
            [wSelf.tableView reloadData];
        }
        [wSelf.tableView endRefreshing];
    }];
}

#pragma mark ----*  查看大图
/**
 *  查看大图
 */
- (void)viewLargerVersionImages:(NSArray *)imageArray imageView:(UIImageView *)imageView index:(int)index
{
    
    
    HUPhotoBrowser * tuPianView = [HUPhotoBrowser showFromImageView:imageView withURLStrings:imageArray placeholderImage:imageName(@"booth_figure_longitudinal") atIndex:index dismiss:^(UIImage * _Nullable image, NSInteger index) {
        
    }];
    [self.view addSubview:tuPianView];
}

#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZZCommentsTableViewCell * cell = [XZZCommentsTableViewCell codeCellWithTableView:tableView];
    cell.goodsComments = self.dataSource[indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XZZCommentsTableViewCell calculateHeightCell:self.dataSource[indexPath.row]];
}
#pragma mark ----- tableView代理结束






@end
