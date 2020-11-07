//
//  XZZSecondsKillGoodsListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecondsKillGoodsListViewController.h"

#import "XZZLocalPushRecord.h"

#import "XZZSecondsKillGodosListTableViewCell.h"

#import "XZZSecondsKillHeaderView.h"

#import "XZZShareView.h"
#import "XZZSecKillHeaderView.h"

#import "XZZSecondsKillViewModel.h"

#import "XZZSecondsKillSession.h"

@interface XZZSecondsKillGoodsListViewController ()<XZZSecondsKillViewModelDelegate, UIScrollViewDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSecondsKillHeaderView * headerView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSecKillHeaderView * seckillView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZALLSecondsKillSession * allSecondsKillSession;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * tableViewList;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * tableModelList;
/**
 * <#expression#>
 */
@property (nonatomic, assign)CGFloat headerViewMinHeight;

/**
 * 当前展示的是第几个tableview   从0开始
 */
@property (nonatomic, assign)int count;

/**
 * 停留到某个页面
 */
@property (nonatomic, strong)XZZSecondsKillSession * secKillSession;

/**
 * <#expression#>
 */
@property (nonatomic, assign)CGPoint startImageCenter;

/**
 * <#expression#>
 */
@property (nonatomic, assign)CGPoint startGCenter;

@end

@implementation XZZSecondsKillGoodsListViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:kColor(0xF41C19)}];
    //    self.myTitle = @"Flash Deals";
    
    [self setNavRightButton];
    
    [self scrollViewDidEndScroll];
}

- (void)setNavRightButton
{
    /**  创建按钮   分享按钮 */
    UIButton * rightButton = [UIButton allocInitWithFrame:CGRectMake(0, 0, 50, 40)];
    [rightButton setImage:imageName(@"goods_details_share") forState:(UIControlStateNormal)];
    [rightButton setImage:imageName(@"goods_details_share") forState:(UIControlStateHighlighted)];
    [rightButton addTarget:self action:@selector(clickOutShare:) forControlEvents:(UIControlEventTouchUpInside)];
    [rightButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = textFont(14);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);//
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)clickOutShare:(UIButton *)button
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    XZZShareView * shareView = [XZZShareView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [shareView addView];
    [shareView addSuperviewView];
    shareView.VC = self;
    shareView.title = self.allSecondsKillSession.seoTitle;
    shareView.imageURL = self.allSecondsKillSession.bannerImage;
    shareView.url = [NSString stringWithFormat:@"%@/activity/seckill", h5_prefix];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BACK_COLOR;
    
    self.headerViewMinHeight = 120;
    WS(wSelf)
    self.headerView = [XZZSecondsKillHeaderView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [self.headerView setSelectSession:^(NSInteger index) {
        [wSelf.scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    }];
    [self.headerView setRefreshBlock:^{
        [wSelf modifyHeadHeight];
    }];
    [self.view addSubview:self.headerView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.headerView addGestureRecognizer:pan];
    
    
    self.scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.top.equalTo(wSelf.view);
    }];
    
    self.seckillView = [XZZSecKillHeaderView allocInitWithFrame:CGRectMake(0, self.headerView.imageView.bottom, ScreenWidth, 64)];
    [self.seckillView setSelectSession:^(NSInteger index) {
        [wSelf.scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    }];
    [self.seckillView setRefreshBlock:^{
        [wSelf modifyHeadHeight];
    }];
    self.seckillView.bottom = self.headerView.bottom;
    [self.view addSubview:self.seckillView];
    [self.seckillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.bottom.equalTo(wSelf.headerView);
        make.height.equalTo(@64);
    }];
    [self dataDownload];
}

- (void)dataDownload
{
    WS(wSelf)
    [XZZDataDownload activityGetSeckillInforHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.allSecondsKillSession = data;
            [wSelf addView];
        }else{
            [wSelf back];
        }
    }];
}


- (void)addView
{
    
    self.tableViewList = @[].mutableCopy;
    self.tableModelList = @[].mutableCopy;
    [self.scrollView removeAllSubviews];
    
    self.headerView.top = 0;
    self.seckillView.bottom = self.headerView.bottom;
    
    NSArray * list = self.allSecondsKillSession.seckillDetailVoList;
    self.headerView.imageUrl = self.allSecondsKillSession.bannerImage;
    self.headerView.secondsKillList = list;
    self.seckillView.secondsKillList = list;
    
    CGFloat width = ScreenWidth;
    CGFloat left = 0;
    UIView * leftView = nil;
    WS(wSelf)
    
    BOOL ongoing = NO;
    int index = 0;
    int count = 0;
    int adjustPage = -1;
    for (int i = 0; i < list.count; i++) {
        XZZSecondsKillSession * secondsKill = list[i];
        if (secondsKill.status == 3 || secondsKill.status == 4) {
            ongoing = YES;
        }
        if (!ongoing) {
            index++;
        }
        if ([secondsKill.ID isEqualToString:self.secKillSession.ID]) {
            adjustPage = i;
        }
        
        left += width;
        weakView(weak_leftView, leftView)
        XZZSecondsKillViewModel * viewModel = [XZZSecondsKillViewModel allocInit];
        viewModel.delegate = self;
        viewModel.secondsKillList = list;
        viewModel.index = count;
        viewModel.buttonCount = list.count;
        [viewModel setRefreshBlock:^{
            wSelf.secKillSession = nil;
            [wSelf dataDownload];
        }];
        [viewModel setRefreshTwoBlock:^(XZZSecondsKillSession * _Nonnull secKillSession) {
            wSelf.secKillSession = secKillSession;
            [wSelf dataDownload];
        }];
        [viewModel setSelectSession:^(NSInteger index) {
            [wSelf.scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
        }];
        [self.tableModelList addObject:viewModel];
        count++;
        
        UIView * tableHeaderView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, self.headerView.imageView.height)];
        tableHeaderView.backgroundColor = [UIColor clearColor];
        viewModel.tableHeaderView = tableHeaderView;
        
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
        tableView.delegate = viewModel;
        tableView.dataSource = viewModel;
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.estimatedRowHeight =0;
        tableView.estimatedSectionHeaderHeight =0;
        tableView.estimatedSectionFooterHeight =0;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.tableHeaderView = tableHeaderView;
        [self.scrollView addSubview:tableView];
        [self.tableViewList addObject:tableView];
        [tableView addRefresh:viewModel refreshingAction:@selector(updateData)];
        [tableView addLoading:viewModel refreshingAction:@selector(dataDownload)];
        
        leftView = tableView;
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (weak_leftView) {
                make.left.equalTo(weak_leftView.mas_right);
            }else{
                make.left.equalTo(@0);
            }
            make.top.equalTo(@0);
            make.width.equalTo(@(width));
            make.bottom.equalTo(wSelf.view);
        }];
        
        viewModel.VC = self;
        viewModel.tableView = tableView;
        viewModel.secondsKill = secondsKill;
    }
    index = index >= list.count ? (list.count - 1) : index;
    self.scrollView.contentSize = CGSizeMake(left, 0);
    if (adjustPage >= 0) {
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth * adjustPage, 0) animated:NO];
        self.headerView.scrollViewX = ScreenWidth * adjustPage;
        self.seckillView.scrollViewX = ScreenWidth * adjustPage;
    }else{
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:NO];
        self.headerView.scrollViewX = ScreenWidth * index;
        self.seckillView.scrollViewX = ScreenWidth * index;
    }
}

- (void)modifyHeadHeight
{
    for (XZZSecondsKillViewModel * viewModel in self.tableModelList) {
        viewModel.tableHeaderView.height = self.headerView.imageView.height;
    }
    self.seckillView.bottom = self.headerView.bottom;
}


#pragma mark - scrollView 滚动停止
- (void)scrollViewDidEndScroll {
    NSLog(@"停止滚动了！！！");
    self.seckillView.hidden = NO;
    if (self.tableViewList.count <= 0) {
        return;
    }
    if (self.count >= self.tableViewList.count) {
        self.count = 0;
    }
    
    UIScrollView * scrollView = self.tableViewList[self.count];
    
    
    
    CGFloat height = self.headerView.imageView.height;
    CGFloat y = scrollView.contentOffset.y;
    self.seckillView.hidden = NO;
    for (UITableView * tableView in self.tableViewList) {
        if (![scrollView isEqual:tableView]) {
            if (y < height) {
                [tableView setContentOffset:scrollView.contentOffset animated:NO];
            }else{
                if (tableView.contentOffset.y < height) {
                    [tableView setContentOffset:CGPointMake(0, height) animated:NO];
                }
            }
        }
    }
    
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wSelf.seckillView.hidden = NO;
    });
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]) {
        CGFloat x = scrollView.contentOffset.x;
        self.headerView.scrollViewX = scrollView.contentOffset.x;
        self.seckillView.scrollViewX = scrollView.contentOffset.x;
        self.count = x / ScreenWidth;
        return;
    }
    CGFloat y = scrollView.contentOffset.y;
    if (y < 0) {
        self.headerView.top = -0;
        self.seckillView.bottom = self.headerView.bottom;
        [self moveTableviewZeroExcludeInemIndex:self.count];
        self.seckillView.hidden = YES;
    }else{
        CGFloat height = self.headerView.imageView.height;
        if (y > height) {
            self.seckillView.hidden = NO;
        }
        y = y > height ? height : y;
        NSLog(@"%.2f-----", y);
        self.headerView.top = -y;
        self.seckillView.bottom = self.headerView.bottom;
    }
}

#pragma mark ---- p将tableview移动至0位置   将index排除不移动
/**
 * #pragma mark ---- p将tableview移动至0位置   将index排除不移动
 */
- (void)moveTableviewZeroExcludeInemIndex:(int)index
{
    for (int i = 0; i < self.tableViewList.count; i++) {
        if (i != index) {
            UITableView * tableView = self.tableViewList[i];
            [tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    CGPoint nowGCenter = [pan locationInView:self.view];
    CGFloat height = self.headerView.frame.size.height;
    CGFloat maxCenterY = height / 2.0;
    CGFloat minCenterY = ((self.headerViewMinHeight - height) + self.headerViewMinHeight) / 2.0;
    UITableView * tableView = self.tableViewList[self.count];
    CGFloat y = nowGCenter.y - self.startGCenter.y;
    CGFloat centerY = self.headerView.center.y;
    CGFloat centerX = self.headerView.center.x;
    if (pan.state == UIGestureRecognizerStateBegan) {
        //记录中心位置
        self.startGCenter = nowGCenter;
        return;
    }else if (pan.state == UIGestureRecognizerStateEnded){
        
        if (centerY < maxCenterY && centerY > minCenterY) {
            [self moveTableviewZeroExcludeInemIndex:-1];
        }else{
            if (tableView.contentOffset.y > 0) {
                
            }else{
                if (tableView.contentOffset.y < -70) {
                    [tableView beginRefreshing];
                    [self moveTableviewZeroExcludeInemIndex:self.count];
                }else{
                    [self moveTableviewZeroExcludeInemIndex:-1];
                }
            }
        }
        return;
    }
    
    if (centerY < maxCenterY && centerY > minCenterY) {
        self.headerView.center = CGPointMake(centerX, centerY + y);
    }else{
        CGFloat contentY = tableView.contentOffset.y;
        CGFloat mobileDistance = contentY - y;
        if (y > 0) {//手指向下移动
            mobileDistance = contentY < 0 ? (contentY - y / 3.0) : mobileDistance;
            [self moveTableviewZeroExcludeInemIndex:self.count];
        }else{//手指向上移动
            
        }
        [tableView setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
    }
    self.startGCenter = nowGCenter;
}





@end
