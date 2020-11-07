//
//  XZZSecondsKillModelView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecondsKillViewModel.h"

#import "XZZSecondsKillGodosListXIBTableViewCell.h"

#import "XZZSecKillCountdownTableViewCell.h"

#import "XZZSecondsKillView.h"

@interface XZZSecondsKillViewModel ()<XZZMyDelegate>
/**
 * <#expression#>
 */
@property (nonatomic, assign)XZZSecondsKillState state;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * goodsList;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int page;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZRequestSeckillGoods * secKillGoods;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * buttonBackView;



@end

@implementation XZZSecondsKillViewModel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)allocInit
{
    XZZSecondsKillViewModel * viewModel = [super allocInit];
    [[NSNotificationCenter defaultCenter] addObserver:viewModel selector:@selector(reloadData) name:@"PushRecord_getPushIds" object:nil];
    
    return viewModel;
}

- (UIView *)buttonBackView
{
    if (!_buttonBackView) {
        self.buttonBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
//        [_buttonBackView addSubview:self.secKillBackView];
    }
    return _buttonBackView;
}


- (UIImageView *)secKillBackView
{
    if (!_secKillBackView) {
        self.secKillBackView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 64) imageName:@"seconds_kill_sale_bg_2"];
        _secKillBackView.userInteractionEnabled = YES;
        _secKillBackView.backgroundColor = BACK_COLOR;

        CGFloat width = ScreenWidth / self.secondsKillList.count;
        CGFloat left = 0;
        NSInteger tag = 0;
        for (XZZSecondsKillSession * secondsKill in self.secondsKillList) {
                XZZSecondsKillView * secondsKillView = [XZZSecondsKillView allocInitWithFrame:CGRectMake(left, 0, width, 64)];
                [_secKillBackView addSubview:secondsKillView];
                secondsKillView.state = secondsKill.status == 2 ? XZZSecondsKillStateEnd : XZZSecondsKillStateNot;
                secondsKillView.secondsKill = secondsKill;
                left = secondsKillView.right;
            secondsKillView.indicatorcenterX = (self.index + 0.5) * width;
            
            UIButton * button = [UIButton allocInitWithFrame:secondsKillView.frame];
            [button addTarget:self action:@selector(clickOutSession:) forControlEvents:(UIControlEventTouchUpInside)];
            button.tag = tag;
            [self.buttonBackView addSubview:button];
            tag++;
            }

        
        UIImageView * arrowImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 64 - 8, 16, 8) imageName:@"seconds_kill_triangle"];
            [_secKillBackView addSubview:arrowImageView];
            arrowImageView.centerX = (self.index + 0.5) * width;
    }
    
    
    return _secKillBackView;
}

- (void)clickOutSession:(UIButton *)button
{
    !self.selectSession?:self.selectSession(button.tag);
}


- (void)reloadData
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [wSelf.tableView reloadData];
    });
    
}

- (XZZRequestSeckillGoods *)secKillGoods
{
    if (!_secKillGoods) {
        self.secKillGoods = [XZZRequestSeckillGoods allocInit];
        _secKillGoods.pageSize = 20;
    }
    return _secKillGoods;
}

- (NSMutableArray *)goodsList
{
    if (!_goodsList) {
        self.goodsList = @[].mutableCopy;
    }
    return _goodsList;
}

- (XZZAddCartAndBuyNewViewModel *)addCartAndBuyNewViewModel
{
    if (!_addCartAndBuyNewViewModel) {
        XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel = [XZZAddCartAndBuyNewViewModel allocInit];
        addCartAndBuyNewViewModel.VC = self.VC;
        self.addCartAndBuyNewViewModel = addCartAndBuyNewViewModel;
    }
    return _addCartAndBuyNewViewModel;
}

- (void)setSecondsKill:(XZZSecondsKillSession *)secondsKill
{
    _secondsKill = secondsKill;
    self.secKillGoods.seckillId = self.secondsKill.ID;
    if (secondsKill.status == 2) {
        self.state = XZZSecondsKillStateEnd;
    }else if (secondsKill.status == 3) {
        self.state = XZZSecondsKillStateOngoing;
    }else{
        self.state = XZZSecondsKillStateNot;
    }
    
    
    [self updateDataTwo];
}

- (void)updateData
{
    !self.refreshTwoBlock?:self.refreshTwoBlock(self.secondsKill);
}


/**
 *  更新数据
 */
- (void)updateDataTwo
{
    self.secKillGoods.pageNum = 0;
    
    [self dataDownload];
}
/**
 *  数据下载   用于下拉加载
 */
- (void)dataDownload
{
    self.secKillGoods.pageNum++;
    WS(wSelf)
    [XZZDataDownload activityGetSeckillGoods:self.secKillGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (wSelf.secKillGoods.pageNum == 1) {
            [wSelf.goodsList removeAllObjects];
        }
        if (successful) {
            [wSelf.goodsList addObjectsFromArray:data];
        }
        [wSelf.tableView reloadData];
        [wSelf.tableView endRefreshing];
        [wSelf scrollViewDidEndScroll];
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [self scrollViewDidEndScroll];
        }
    }
}

#pragma mark - scrollView 滚动停止
- (void)scrollViewDidEndScroll {
    NSLog(@"停止滚动了！！！");
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndScroll)]) {
        [self.delegate scrollViewDidEndScroll];
    }
}

#pragma mark ---- *  点击商品购物车  根据商品id
/**
 *  点击商品购物车  根据商品id
 */
- (void)goodsViewShopCartAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    self.addCartAndBuyNewViewModel.goodsId = goodsId;
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
    if (self.state == XZZSecondsKillStateEnd) {
        return self.goodsList.count;
    }
    return self.goodsList.count + 1;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(wSelf)
    NSInteger index = indexPath.row;
    if (self.state != XZZSecondsKillStateEnd) {
        if (indexPath.row == 0) {
            XZZSecKillCountdownTableViewCell * cell = [XZZSecKillCountdownTableViewCell XIBCellWithTableView:tableView];
            if (self.state == XZZSecondsKillStateNot) {
                cell.state = @"Starts In";
                cell.time = self.secondsKill.startTime;
            }else{
                cell.state = @"End In";
                cell.time = self.secondsKill.endTime;
            }
            
            [cell setRefreshBlock:^{
                !wSelf.refreshBlock?:wSelf.refreshBlock();
            }];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        index--;
    }
    
    XZZSecondsKillGodosListXIBTableViewCell * cell = [XZZSecondsKillGodosListXIBTableViewCell XIBCellWithTableView:tableView];
    cell.delegate = self;
    
    cell.state = self.state;
    if (index == 0) {
        cell.goodsLocation = XZZSecondsKillGoodsFirst;
    }else if (index == self.goodsList.count - 1){
        cell.goodsLocation = XZZSecondsKillGoodsLast;
    }else{
        cell.goodsLocation = XZZSecondsKillGoodsMiddle;
    }
    cell.secKillId = self.secondsKill.ID;
    cell.goods = self.goodsList[index];
    [cell setRemindMe:^(NSString * _Nonnull goodsId, UIImage * image) {
        [wSelf isOpenPush:goodsId image:image];
    }];
    [cell setCancleReminder:^(NSString * _Nonnull goodsId, UIImage * image) {
        [wSelf deleteLocalPush:goodsId];
    }];
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.state != XZZSecondsKillStateEnd && indexPath.row == 0) {
        return 78;
    }
    if (ScreenWidth > 320) {
        return 144;
    }
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.buttonBackView.height;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.buttonBackView;
}
#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    XZZSecondsKillGodosListXIBTableViewCell * cell = (XZZSecondsKillGodosListXIBTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[XZZSecondsKillGodosListXIBTableViewCell class]]) {
        GoodsDetails(cell.goods.ID, self.VC);
    }
    
    
}
#pragma mark ----- tableView代理结束



- (void)isOpenPush:(NSString *)goodsId image:(UIImage *)image
{
    WS(wSelf)
    weakObjc(weak_image, image);
    weakObjc(weak_goodsId, goodsId)
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
            NSLog(@"打开了通知");
            [wSelf addLocalPush:weak_goodsId image:weak_image];
        }else {
            NSLog(@"关闭了通知");
            [wSelf showAlertView];
        }
    }];
}
#pragma mark ---- 添加推送通知
/**
 * #pragma mark ---- 添加推送通知
 */
- (void)addLocalPush:(NSString *)goodsId image:(UIImage *)image
{

    
    NSString * noticeId = PushRecord_keyPush(self.secondsKill.ID, goodsId);
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
    content.body = @"The flash deals you ❤ is starting in 5min. Hurry up!";
        content.userInfo = @{@"goods" : goodsId};
        content.badge = @1;
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    //3.2图片保存到沙盒
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *localPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", noticeId]];
    [imageData writeToFile:localPath atomically:YES];
    
    //3.3设置通知的attachment(附件)
     if (localPath && ![localPath isEqualToString:@""]) {
         UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:@"photo" URL:[NSURL URLWithString:[@"file://" stringByAppendingString:localPath]] options:nil error:nil];
         if (attachment) {
             content.attachments = @[attachment];
         }
     }
    
    NSDate * data = [self conversionDate:self.secondsKill.startTime];
    
        // 多少秒后发送,可以将固定的日期转化为时间
        NSTimeInterval time = [data timeIntervalSinceNow];
        time  = time > (60 * 5) ? (time - 60 * 5) : time;
        //        NSTimeInterval time = 10;
        // repeats，是否重复，如果重复的话时间必须大于60s，要不会报错
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
        
        // 添加通知的标识符，可以用于移除，更新等操作
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:noticeId content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
    
    PushRecord_addPush(self.secondsKill.ID, goodsId);
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [wSelf.tableView reloadData];
    });
    
    
}
#pragma mark ---- 删除推送通知
/**
 * #pragma mark ---- 删除推送通知
 */
- (void)deleteLocalPush:(NSString *)goodsId
{
    NSString * noticeId = PushRecord_keyPush(self.secondsKill.ID, goodsId);
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:@[noticeId]];
    
    PushRecord_deletePush(self.secondsKill.ID, goodsId);
    WS(wSelf)
     dispatch_async(dispatch_get_main_queue(), ^{
         [wSelf.tableView reloadData];
     });
}

- (void)showAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please turn on Jolimall notifications to be reminded." message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToAppSystemSetting];
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.VC presentViewController:alert animated:YES completion:nil];
    });
    
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改
- (void)goToAppSystemSetting {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                }
            }else {
                [application openURL:url];
            }
        }
    });
}



@end
