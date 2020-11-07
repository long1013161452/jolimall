//
//  XZZRepairOrderDetailsViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZRepairOrderDetailsViewController.h"

#import "XZZImageBigImageView.h"

#import "XZZCreateCellInfor.h"

@interface XZZRepairOrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, XZZMyDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * tokenArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITextField * textField;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * commentsWithUsers;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * numLabel;

@end

@implementation XZZRepairOrderDetailsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)tokenArray
{
    if (!_tokenArray) {
        self.tokenArray = @[].mutableCopy;
    }
    return _tokenArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"My Tickets";
    self.nameVC = @"工单详情";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:User_Infor.email email:User_Infor.email];
//    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCJwt alloc] initWithToken:User_Infor.email];

    [[ZDKZendesk instance] setIdentity:userIdentity];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    WS(wSelf)
    self.tableView = [UITableView allocInit];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 10;
    self.tableView.backgroundColor = kColor(0xf2f2f2);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
    }];
    [self dataDownload];
    CGFloat buttonHeight = 60;
    CGFloat height = StatusRect.size.height > 20 ? (bottomHeight + buttonHeight) : buttonHeight;
    
    UIView * backView = [UIView allocInit];
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
        make.width.height.equalTo(@(buttonHeight));
    }];
    
    weakView(weak_pictureButton, pictureButton)
    UILabel * numLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:button_back_color textColor:kColor(0xffffff) textFont:8 textAlignment:(NSTextAlignmentCenter) tag:1];
    numLabel.layer.cornerRadius = 8;
    numLabel.layer.masksToBounds = YES;
    [backView addSubview:numLabel];
    self.numLabel = numLabel;
    numLabel.hidden = YES;
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_pictureButton).offset(-8);
        make.top.equalTo(@8);
        make.width.height.equalTo(@16);
    }];
    
    /***  <#macro#> */
    UIView * textBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0)];
    textBackView.backgroundColor = BACK_COLOR;
    textBackView.layer.cornerRadius = 20;
    textBackView.layer.masksToBounds = YES;
    [backView addSubview:textBackView];
    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(weak_pictureButton.mas_right).offset(5);
        make.height.equalTo(@40);
        make.top.equalTo(@10);
    }];

    weakView(weak_textBackView, textBackView)
    self.textField = [UITextField allocInit];
    [textBackView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.center.equalTo(weak_textBackView);
    }];
    
    UIButton * sendButton = [UIButton allocInitWithImageName:@"chat_send" selectedImageName:@"chat_send"];//[UIButton allocInitWithTitle:@"Send" color:button_back_color selectedTitle:@"Send" selectedColor:button_back_color font:14];
    [sendButton addTarget:self action:@selector(addRepairOrder) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:sendButton];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(weak_backView);
        make.centerY.equalTo(wSelf.textField);
        make.width.equalTo(@(buttonHeight));
        make.left.equalTo(weak_textBackView.mas_right).offset(5);
    }];
    
    
    
    
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification*)note{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableView.contentInset= UIEdgeInsetsMake(keyBoardRect.size.height, 0, 0, 0);

}

#pragma mark 键盘消失

-(void)keyboardWillHide:(NSNotification*)note{
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
        [self sendImageMessage:image ];
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

    NSData * data = UIImageJPEGRepresentation(image, .5);
    WS(wSelf)
    loadView(self.view)
    ZDKUploadProvider * upload = [[ZDKUploadProvider alloc] init];
    [upload uploadAttachment:data withFilename:@"image.jpg" andContentType:@"image/png" callback:^(ZDKUploadResponse *uploadResponse, NSError *error) {
        loadViewStop;
        if (!error) {
            [wSelf.tokenArray addObject:uploadResponse];
            if (wSelf.tokenArray.count > 0) {
                wSelf.numLabel.text = [NSString stringWithFormat:@"%d", wSelf.tokenArray.count];
                wSelf.numLabel.hidden = NO;
            }
        }else{
            
        }
    }];
   
    
}


- (void)addRepairOrder
{
    
    if (self.textField.text.length <= 0) {
        return;
    }
    NSString * str = self.textField.text;
    self.textField.text = @"";
    WS(wSelf)
    ZDKRequestProvider *provider = [ZDKRequestProvider new];
    
    if (self.tokenArray.count) {
        [provider addComment:str forRequestId:self.requestId attachments:self.tokenArray withCallback:^(ZDKComment *comment, NSError *error) {
            if (!error) {
                [wSelf processWorkOrderInforComment:comment];
                [wSelf.tokenArray removeAllObjects];
                wSelf.numLabel.hidden = YES;
            }
        }];
        return;
    }
    
    [provider addComment:str forRequestId:self.requestId withCallback:^(ZDKComment *comment, NSError *error) {//补充工单
        if (!error) {
            [wSelf processWorkOrderInforComment:comment];
        }
    }];
}
#pragma mark ----*  处理新新增的工单信息
/**
 *  处理新新增的工单信息
 */
- (void)processWorkOrderInforComment:(ZDKComment *)comment
{
    ZDKCommentWithUser * user = [self.commentsWithUsers lastObject];
    if (comment && user) {
        ZDKCommentWithUser * twoUser = [ZDKCommentWithUser buildCommentWithUser:comment withUsers:@[user.user]];
        [self.commentsWithUsers insertObject:twoUser atIndex:0];
        [self.tableView reloadData];
        if (self.commentsWithUsers.count) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.commentsWithUsers.count - 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
    
}

- (void)dataDownload
{
    WS(wSelf)
    loadView(self.view)
     ZDKRequestProvider *provider = [ZDKRequestProvider new];
    [provider getCommentsWithRequestId:self.requestId withCallback:^(NSArray<ZDKCommentWithUser *> *commentsWithUsers, NSError *error) {
        loadViewStop
        wSelf.commentsWithUsers = commentsWithUsers.mutableCopy;
        [wSelf.tableView reloadData];
        if (commentsWithUsers.count) {
            [wSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:wSelf.commentsWithUsers.count - 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        }
    }];
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



#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsWithUsers.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int count = self.commentsWithUsers.count - 1 - indexPath.row;
    return [XZZCreateCellInfor createRepairOrderDetailsCell:self.commentsWithUsers[count] tableView:tableView indexPath:indexPath delegate:self];
}
#pragma mark ----- tableView代理结束





@end
