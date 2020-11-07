//
//  XZZAddressListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddressListViewController.h"
#import "XZZAddAddressViewController.h"
#import "XZZAddressTableViewCell.h"

@interface XZZAddressListViewController ()<UITableViewDataSource, UITableViewDelegate, XZZMyDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

@end

@implementation XZZAddressListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self dataDownload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameVC = @"地址列表";
    self.myTitle = @"Address";
    
    WS(wSelf)
    self.tableView = [UITableView allocInit];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 160;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(wSelf.view);
    }];
    
    UIButton * addAddressButton = [UIButton allocInitWithTitle:@"+Add New Address" color:kColor(0xffffff) selectedTitle:@"+Add New Address" selectedColor:kColor(0xffffff) font:18];
    addAddressButton.backgroundColor = button_back_color;
    [addAddressButton addTarget:self action:@selector(clickOnAddAddressButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addAddressButton];
    CGFloat buttonBottom = StatusRect.size.height > 20 ? -bottomHeight : 0;
    [addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.tableView.mas_bottom);
        make.height.equalTo(@50);
        make.bottom.equalTo(wSelf.view).offset(buttonBottom);
    }];
     [self dataDownload];
}

- (void)dataDownload
{
    WS(wSelf)
    [User_Infor getAddressListHttpBlock:^(id data, BOOL successful, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successful) {
                [wSelf.tableView reloadData];
            }
        });        
    }];
}


- (void)clickOnAddAddressButton
{
    XZZAddAddressViewController * addAddressVC = [XZZAddAddressViewController allocInit];
    [self pushViewController:addAddressVC animated:YES];
}

- (void)deleteAddress:(XZZAddressInfor *)address
{
    WS(wSelf)
    [User_Infor deleteAddress:address httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            SVProgressSuccess(data)
            [wSelf dataDownload];
        }else{
            SVProgressError(data)
        }
    }];
}

#pragma mark ----自定义代理
#pragma mark ----*  删除地址
/**
 *  删除地址
 */
- (void)deleteAddressInfor:(XZZAddressInfor *)address
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    WS(wSelf)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete the address?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"NO" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [User_Infor deleteAddress:address httpBlock:^(id data, BOOL successful, NSError *error) {
            if (successful) {
                SVProgressSuccess(data);
                [User_Infor.addressArray removeObject:address];
                [wSelf.tableView reloadData];
                [wSelf dataDownload];
            }else{
                SVProgressError(data);
            }
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ----*  编辑地址信息
/**
 *  编辑地址信息
 */
- (void)editorAddressInfor:(XZZAddressInfor *)address 
{
    XZZAddAddressViewController * addAddressVC = [XZZAddAddressViewController allocInit];
    addAddressVC.addressInfor = address;
    addAddressVC.delegate = self;
    [self pushViewController:addAddressVC animated:YES];
}

#pragma mark ----*  设置默认地址
/**
 *  设置默认地址
 */
- (void)setAddressDefault:(XZZAddressInfor *)address
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    WS(wSelf)
    address.status = !address.status;
    [User_Infor setDefaultAddress:address httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [wSelf dataDownload];
            SVProgressSuccess(@"Default set successfully")
        }else{
            SVProgressError(@"Default set failed")
        }
    }];
}
#pragma mark ----*  添加地址或者修改地址成功回调
/**
 *  添加地址或者修改地址成功回调
 */
- (void)addOrEditorAddressInforSuccessfully:(XZZAddressInfor *)address newAddressInfor:(XZZAddressInfor *)newAddress
{
    if ([address.ID isEqualToString:self.address.ID]) {
        if ([newAddress isKindOfClass:[XZZAddressInfor class]]) {
            if (newAddress.ID.length > 0) {
                self.address = newAddress;
                !self.selectedAddress?:self.selectedAddress(newAddress);
            }
        }
    }
    
    [self dataDownload];
}



#pragma mark ----自定义代理结束

#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return User_Infor.addressArray.count;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZZAddressTableViewCell * cell = [XZZAddressTableViewCell codeCellWithTableView:tableView];
    cell.addressInfor = User_Infor.addressArray[indexPath.section];
    cell.delegate = self;
    if (self.address) {
        cell.isSelected = NO;
        cell.isSelected = [cell.addressInfor isEqual:self.address] || [cell.addressInfor.ID isEqualToString:self.address.ID];
    }
    return cell;
}

#pragma mark ---- 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark ---- 设置区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = BACK_COLOR;
    return view;
}
#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    XZZAddressTableViewCell * cell = (XZZAddressTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (self.isSelectAddress) {
        !self.selectedAddress?:self.selectedAddress(cell.addressInfor);
        [self back];
        return;
    }
    
    [self editorAddressInfor:cell.addressInfor];
    
}
#pragma mark ----- tableView代理结束





@end
