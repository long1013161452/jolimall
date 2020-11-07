//
//  XZZChatViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZChatViewController.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>

#import "XZZImageBigImageView.h"

#import "XZZCreateCellInfor.h"

#import "XZZLeePhotoOrAlbumImagePicker.h"

#import "ZDCChatEvent+XZZChatEvent.h"

@interface XZZChatViewController ()<UITableViewDelegate, UITableViewDataSource, XZZMyDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImagePickerController *picker;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * eventArray;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UITextField * textField;

@property(nonatomic,strong)dispatch_source_t timer;


@end

@implementation XZZChatViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[ZDCChatAPI instance] removeObserverForTimeoutEvents:self];
    [[ZDCChatAPI instance] removeObserverForChatLogEvents:self];
    [[ZDCChatAPI instance] removeObserverForConnectionEvents:self];
    [[ZDCChatAPI instance] removeObserverForUploadEvents:self];
    [[ZDCChatAPI instance] removeObserverForAgentEvents:self];
    [[ZDCChatAPI instance] removeObserverForAccountEvents:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    dispatch_source_cancel(self.timer);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self chatEvent];
    [self RegularlySend];
    ZDCAPIConfig * config = [ZDCAPIConfig allocInit];
    config.department = @"Jolimall";
    config.tags = @[@"Jolimall", @"iOS"];
    [[ZDCChatAPI instance] startChatWithAccountKey:@"7mystxxrnxaJHXsq0wMAQ2apchPXxW0S" config:config];
}

- (NSMutableArray *)eventArray
{
    if (!_eventArray) {
        self.eventArray = [NSMutableArray array];
    }
    return _eventArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTitle = @"My Chat";
    self.nameVC = @"聊天";
    
    self.view.backgroundColor = kColor(0xffffff);
    
    [XZZBuriedPoint SupportPerson:4];
    
    [ZDKCoreLogger setEnabled:YES];
    [ZDKCoreLogger setLogLevel:ZDKLogLevelDebug];
    
    ZDCVisitorInfo * infor = [ZDCVisitorInfo allocInit];
    infor.email = self.email;
    infor.name = self.email;
    
    
    
    [ZDCChatAPI instance].visitorInfo = infor;
    

    
    
    [[ZDCChatAPI instance] addObserver:self forTimeoutEvents:@selector(chatEvent)];//连接h超时
    
    [[ZDCChatAPI instance] addObserver:self forChatLogEvents:@selector(chatEvent)];//更新聊天消息
    [[ZDCChatAPI instance] addObserver:self forAgentEvents:@selector(chatEvent)];//代理变化
    
    [[ZDCChatAPI instance] addObserver:self forUploadEvents:@selector(chatEvent)];//上传文件
    [[ZDCChatAPI instance] addObserver:self forAccountEvents:@selector(chatEvent)];//离线
    [[ZDCChatAPI instance] addObserver:self forConnectionEvents:@selector(forConnectionEvents)];//链接状态变化

    
    [self addView];
}


#pragma mark ---- 定时拉去信息
/***  定时拉去信息 */
- (void)RegularlySend{
    
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建一个定时器（dispatch_source_t本质上还是一个OC对象）
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(2 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf chatEvent];
        });
    });
    //启动定时器（默认是暂停）
    dispatch_resume(self.timer);
    NSLog(@"%s %d 行", __func__, __LINE__);
}



- (void)addView{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


    CGFloat buttonHight = 60;
    CGFloat height = StatusRect.size.height > 20 ? (bottomHeight + buttonHight) : buttonHight;
    CGFloat navHight = StatusRect.size.height > 20 ? 88 : 64;
    
    WS(wSelf)
    self.tableView = [UITableView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - navHight - height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 400;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = kColor(0xf2f2f2);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(@0);
    }];
    

    
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, self.tableView.bottom, ScreenWidth, height)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.top.equalTo(wSelf.tableView.mas_bottom);
        make.height.equalTo(@(height));
    }];
    
    weakView(weak_backView, backView)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weak_backView);
        make.height.equalTo(@.5);
    }];
    
    
    UIButton * pictureButton = [UIButton allocInitWithImageName:@"chat_Choose_picture" selectedImageName:@"chat_Choose_picture"];
    [pictureButton addTarget:self action:@selector(useAlbumOrCamera) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:pictureButton];
    [pictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weak_backView);
        make.width.height.equalTo(@(buttonHight));
    }];
    
    weakView(weak_pictureButton, pictureButton)
    UIView * textBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0)];
    textBackView.backgroundColor = BACK_COLOR;
    textBackView.layer.cornerRadius = 20;
    textBackView.layer.masksToBounds = YES;
    [backView addSubview:textBackView];
    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weak_pictureButton.mas_right).offset(5);
//        make.left.equalTo(@10);
        make.height.equalTo(@40);
        //        make.centerY.equalTo(weak_pictureButton);
        //        make.centerY.equalTo(weak_backView);
        make.top.equalTo(@10);
    }];
    
    weakView(weak_textBackView, textBackView)
    self.textField = [UITextField allocInit];
//    self.textField.borderStyle = UITextBorderStyleLine;
    [textBackView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weak_pictureButton.mas_right).offset(5);
        make.left.equalTo(@10);
//        make.height.equalTo(@35);
//        make.centerY.equalTo(weak_pictureButton);
//        make.centerY.equalTo(weak_backView);
        make.top.equalTo(@0);
        make.center.equalTo(weak_textBackView);
    }];
    
    UIButton * sendButton = [UIButton allocInitWithImageName:@"chat_send" selectedImageName:@"chat_send"];//[UIButton allocInitWithTitle:@"Send" color:button_back_color selectedTitle:@"Send" selectedColor:button_back_color font:14];
    [sendButton addTarget:self action:@selector(sendMessage) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:sendButton];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_backView);
//        make.top.bottom.equalTo(weak_pictureButton);
//        make.top.bottom.equalTo(weak_backView);
        make.centerY.equalTo(wSelf.textField);
        make.width.equalTo(@50);
        make.left.equalTo(weak_textBackView.mas_right).offset(5);
    }];
    
    
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification*)note{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableView.contentInset= UIEdgeInsetsMake(keyBoardRect.size.height, 0, 0, 0);
    return;
    if (self.tableView.contentSize.height < self.tableView.height - keyBoardRect.size.height) {
        [self.tableView setContentOffset:CGPointMake(0, -keyBoardRect.size.height) animated:YES];
    }
}

#pragma mark 键盘消失

-(void)keyboardWillHide:(NSNotification*)note{
    CGFloat buttonHight = 50;
    CGFloat height = StatusRect.size.height > 20 ? (bottomHeight + buttonHight) : buttonHight;
    CGFloat navHight = StatusRect.size.height > 20 ? 88 : 64;
    self.tableView.contentInset= UIEdgeInsetsZero;

    //    return;
}

#pragma mark ----使用相册或相机
/**
 *  使用相册或相机
 */
- (void)useAlbumOrCamera
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Use an album or camera" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseAction:1];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseAction:2];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)chooseAction:(int)sender {
    
    BOOL isPicker = NO;
    
    switch (sender) {
        case 2:
            //            打开相机
            //            判断相机是否可用
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                isPicker = true;
            }
            break;
            
        case 1:
            //            打开相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //            打开相册
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            isPicker = true;
            }
            break;
            
        default:
            break;
    }
    
    if (isPicker) {
        [self presentViewController:self.picker animated:YES completion:nil];
    }else {
        NSString * message = sender == 1 ? @"Camera not available" : @"Photo album not available";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"determine" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        _picker.delegate = self;
        _picker.allowsEditing = NO;
    }
    return _picker;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (image) {
        [self sendImageMessage:image];
    } else {
        // Fallback on earlier versions
    }
    //    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)sendImageMessage:(UIImage *)image
{

    NSData * data = UIImageJPEGRepresentation(image, .1);
    
    [[ZDCChatAPI instance] uploadFileWithData:data name:@"attachment.jpg"];
}

#pragma mark ----*  刷新tableview
/**
 *  刷新tableview
 */
- (void)tableViewReload
{
    [self.tableView reloadData];
    if (self.eventArray.count) {
//        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.eventArray.count - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.eventArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.eventArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        });

    }
}


#pragma mark ----*  发送消息
/**
 *  发送消息
 */
- (void)sendMessage
{
    if (self.textField.text.length) {
        [[ZDCChatAPI instance] sendChatMessage:self.textField.text];//发送消息
        self.textField.text = @"";
    }
}

- (void)chatEvent
{
    NSArray * array = [[ZDCChatAPI instance] livechatLog];
    if (array.count > self.eventArray.count) {
        [self.eventArray removeAllObjects];
        [self.eventArray addObjectsFromArray:array];
        [self tableViewReload];
    }else if(array.count == self.eventArray.count){
        [self.eventArray removeAllObjects];
        [self.eventArray addObjectsFromArray:array];
//        [self.tableView reloadData];
    }
    
}

- (void)forConnectionEvents
{
    [self chatEvent];
}
#pragma mark ----*  进入网页
/**
 *  进入网页
 */
- (void)enterPageWebViewUrl:(id)url title:(NSString *)title
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    XZZWebViewController * webVC = [XZZWebViewController allocInit];
    webVC.webUrl = url;
    [self pushViewController:webVC animated:YES];
}
#pragma mark ----*  查看大图
/**
 *  查看大图
 */
- (void)viewLargerVersionImage:(id)image
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    XZZImageBigImageView * imageBigImageView = [XZZImageBigImageView shareImageBigImageView];
    imageBigImageView.imageInfor = image;
    [imageBigImageView addSubView];
    
}

#pragma mark ----*  刷新cell信息
/**
 *  刷新cell信息
 */
- (void)refreshTableViewCell:(id)cell
{
    XZZChatTableViewCell * cellTwo = cell;
    [self.tableView reloadRowsAtIndexPaths:@[cellTwo.indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}
#pragma mark ----*  对聊天进行评价
/**
 *  对聊天进行评价
 */
- (void)commentOnChatRating:(ZDCChatRating)rating
{
    [[ZDCChatAPI instance] sendChatRating:rating];
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
    NSLog(@"%@", self.eventArray);
    return self.eventArray.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    return [XZZCreateCellInfor createChatCellInfor:self.eventArray[indexPath.row] tableView:tableView indexPath:indexPath delegate:self];
}
#pragma mark ----- tableView代理结束


@end
