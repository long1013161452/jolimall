//
//  XZZSetListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSetListViewController.h"
#import "XZZSetDetailsViewController.h"
#import "XZZSetUpInforModel.h"

#import "XZZSetUpListTableViewCell.h"

@interface XZZSetListViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 * 数据
 */
@property (nonatomic, strong)NSArray * setUpArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

@end

@implementation XZZSetListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Setting";
    self.nameVC = @"设置";
    
    
    self.tableView = [UITableView allocInit];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    WS(wSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    
    
    
    if (User_Infor.isLogin) {
        UIView * footView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        self.tableView.tableFooterView = footView;
        
        UIButton * logOutButton = [UIButton allocInitWithFrame:CGRectMake(30, 40, ScreenWidth - 30 * 2, 45)];
        logOutButton.backgroundColor = [UIColor whiteColor];
        logOutButton.layer.cornerRadius =5;
        logOutButton.layer.masksToBounds = YES;
        logOutButton.layer.borderColor = [UIColor blackColor].CGColor;
        logOutButton.layer.borderWidth = 1;
        [logOutButton setTitle:@"SIGN OUT" forState:(UIControlStateNormal)];
        [logOutButton setTitle:@"SIGN OUT" forState:(UIControlStateHighlighted)];
        [logOutButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [logOutButton setTitleColor:[UIColor blackColor] forState:(UIControlStateHighlighted)];
        logOutButton.titleLabel.font = textFont_bold(15);
        [logOutButton addTarget:self action:@selector(LogOut:) forControlEvents:(UIControlEventTouchUpInside)];
        [footView addSubview:logOutButton];
        
    }
    
    [self dataDownload];
    
}

- (void)dataDownload
{
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload userGetSetUpListInforHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.setUpArray = data;
            [XZZALLSetUpInfor shareAllSetUpInfor].setUpInforArray = data;
        }
        [wSelf.tableView reloadData];
        loadViewStop
    }];
}

- (void)LogOut:(UIButton *)button{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log out?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [User_Infor loggedOut];
        self.tableView.tableFooterView = nil;
        [self back];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


//- (NSArray *)setUpArray
//{
//    if (!_setUpArray) {
//
//        NSURL *URL = [[NSBundle mainBundle] URLForResource:@"SetUpInfor.plist" withExtension:nil];
//        NSArray *dictArr = [NSArray arrayWithContentsOfURL:URL];
//
//        self.setUpArray = [NSArray yy_modelArrayWithClass:[XZZSetUpInforModel class] json:dictArr];
//
//    }
//    return _setUpArray;
//}



#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.setUpArray.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZZSetUpListTableViewCell * cell = [XZZSetUpListTableViewCell codeCellWithTableView:tableView];
    cell.inforModel = self.setUpArray[indexPath.row];
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    XZZSetUpListTableViewCell * cell = (XZZSetUpListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    XZZSetDetailsViewController * setDetailsVC = [XZZSetDetailsViewController allocInit];
    setDetailsVC.setUpInfor = cell.inforModel;
    [self pushViewController:setDetailsVC animated:YES];
    
}
#pragma mark ----- tableView代理结束


@end
