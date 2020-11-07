//
//  XZZGoodsCommentsViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsCommentsViewController.h"


#import "XZZDisplayPictureInformationView.h"

#import "XZZStarRateView.h"

#import "XZZGoodsCanCommentSkuView.h"

@interface XZZGoodsCommentsViewController ()<UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;

/**
 * 评分
 */
@property (nonatomic, strong)XZZStarRateView * starRateView;
/**
 * 添加图片信息
 */
@property (nonatomic, strong)XZZDisplayPictureInformationView * displayPictureInforView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * skuScrollView;


/**
 * 选中按钮
 */
@property (nonatomic, strong)UIButton * selectedButton;

/**
 * 输入
 */
@property (nonatomic, strong)UITextView * textView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * placeholderLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * smallButton;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * trueSizeButton;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * largeButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * imageUrlArray;


/**
 * sku id
 */
@property (nonatomic, strong)NSString * skuId;
/**
 * 订单id
 */
@property (nonatomic, strong)NSString * orderId;


/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsComments * goodsComments;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * submitButton;

@end

@implementation XZZGoodsCommentsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (NSMutableArray *)imageUrlArray
{
    if (!_imageUrlArray) {
        self.imageUrlArray = @[].mutableCopy;
    }
    return _imageUrlArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Write A Review";
    self.nameVC = [NSString stringWithFormat:@"添加评论-%@", self.goodsId];

    self.view.clipsToBounds = YES;
    
    [self addView];
    
    self.starRateView.currentScore = 5;

    if (self.commentId) {
        [self dataDownload];
    }
}

- (void)dataDownload
{
    WS(wSelf)
    [XZZDataDownload goodsGetCommentsId:self.commentId httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.goodsComments = data;
        }else{
            
        }
    }];
}

- (void)setGoodsComments:(XZZGoodsComments *)goodsComments
{
    _goodsComments = goodsComments;
    if (goodsComments.isModified) {
        self.submitButton.hidden = YES;
        self.textView.editable = NO;
        self.largeButton.userInteractionEnabled = NO;
        self.smallButton.userInteractionEnabled = NO;
        self.trueSizeButton.userInteractionEnabled = NO;
        self.starRateView.userInteractionEnabled = NO;
        if (goodsComments.pictureList.count <= 0) {
            self.displayPictureInforView.hidden = YES;
        }
    }
    
    self.textView.text = goodsComments.content;
    [self textViewDidChange:self.textView];
    self.imageUrlArray = goodsComments.pictureList.mutableCopy;
    [self.displayPictureInforView addImageUrlList:goodsComments.pictureList isCanDeleteImage:goodsComments.isModified];
    
    
    if (goodsComments.suitability == 0) {
        [self clickOnDegreeFitButton:self.smallButton];
    }else if (goodsComments.suitability == 1) {
        [self clickOnDegreeFitButton:self.trueSizeButton];
    }else{
        [self clickOnDegreeFitButton:self.largeButton];
    }
    
    self.starRateView.currentScore = goodsComments.score;
}

- (void)addView
{
    WS(wSelf);
    
    UIView * topView = nil;
    if (self.skuOrderList.count > 1) {
        
        UIScrollView * scrollView = [UIScrollView allocInit];
        scrollView.delegate = self;
        scrollView.clipsToBounds = NO;
        scrollView.pagingEnabled = YES;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.view);
            make.centerX.equalTo(wSelf.view);
            make.left.equalTo(@25);
            make.height.equalTo(@140);
        }];
        self.skuScrollView = scrollView;
        topView = scrollView;

        [self addSkuViewInformation];
        [scrollView setContentOffset:CGPointMake((ScreenWidth - 40) * self.index, 0) animated:NO];
    }else if(self.skuOrderList.count){
        XZZCanCommentSku * canCommentSku = self.skuOrderList[0];
        XZZGoodsCanCommentSkuView * goodsView = [XZZGoodsCanCommentSkuView allocInit];
        goodsView.canCommentSku = canCommentSku;
        [self.view addSubview:goodsView];
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            make.height.equalTo(@140);
            make.top.equalTo(wSelf.view);
        }];
        topView = goodsView;
    }
    
    NSString * buttonTitle = self.commentId.length ? @"Edit review" : @"Submit";

    CGFloat buttonBottom = StatusRect.size.height > 20 ? bottomHeight : 0;
    UIButton * submitButton = [UIButton allocInitWithTitle:buttonTitle color:kColor(0xffffff) selectedTitle:buttonTitle selectedColor:kColor(0xffffff) font:18];
    submitButton.backgroundColor = button_back_color;
    [submitButton addTarget:self action:@selector(clickOnSubmitComments) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitButton];
    self.submitButton = submitButton;
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.left.equalTo(@0);
        make.centerX.equalTo(wSelf.view);
        make.bottom.equalTo(wSelf.view).offset(-buttonBottom);
    }];
    weakView(weak_topView, topView);
    weakView(weak_submitButton, submitButton)
    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (weak_topView) {
            make.top.equalTo(weak_topView.mas_bottom);
        }else{
            make.top.equalTo(wSelf.view);
        }
        make.left.right.equalTo(wSelf.view);
        make.bottom.equalTo(weak_submitButton.mas_top);
    }];
    
    self.starRateView = [[XZZStarRateView alloc] initWithFrame:CGRectMake((ScreenWidth - 200) / 2.0, 30, 200, 25)];
    [self.scrollView addSubview:self.starRateView];
    [self.starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(@30);
        make.width.equalTo(@200);
        make.height.equalTo(@25);
    }];
    
    CGFloat width = 100;
    CGFloat height = 30;
    if (ScreenWidth == 320) {
        width = 80;
        height = 25;
    }
    
    UIButton * smallButton = [UIButton allocInitWithTitle:@"Small" color:kColor(0x000000) selectedTitle:@"Small" selectedColor:kColor(0xffffff) font:12];
    smallButton.layer.borderColor = DIVIDER_COLOR.CGColor;
    smallButton.layer.borderWidth = .5;
    smallButton.tag = 0;
    smallButton.backgroundColor = [UIColor whiteColor];
    [smallButton addTarget:self action:@selector(clickOnDegreeFitButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:smallButton];
    self.smallButton = smallButton;
    [smallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@22);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
        make.top.equalTo(wSelf.starRateView.mas_bottom).offset(20);
    }];
    
    weakView(weak_smallButton, smallButton)
    UIButton * trueSizeButton = [UIButton allocInitWithTitle:@"True to Size" color:kColor(0x000000) selectedTitle:@"True to Size" selectedColor:kColor(0xffffff) font:12];
    trueSizeButton.layer.borderColor = DIVIDER_COLOR.CGColor;
    trueSizeButton.layer.borderWidth = .5;
    trueSizeButton.tag = 1;
    [trueSizeButton addTarget:self action:@selector(clickOnDegreeFitButton:) forControlEvents:(UIControlEventTouchUpInside)];
    if (!self.commentId) {
        [self clickOnDegreeFitButton:trueSizeButton];
    }
    [self.scrollView addSubview:trueSizeButton];
    self.trueSizeButton = trueSizeButton;
    [trueSizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.height.top.equalTo(weak_smallButton);
    }];
    
    UIButton * largeButton = [UIButton allocInitWithTitle:@"Large" color:kColor(0x000000) selectedTitle:@"Large" selectedColor:kColor(0xffffff) font:12];
    largeButton.layer.borderColor = DIVIDER_COLOR.CGColor;
    largeButton.layer.borderWidth = .5;
    largeButton.tag = 2;
    largeButton.backgroundColor = [UIColor whiteColor];
    [largeButton addTarget:self action:@selector(clickOnDegreeFitButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:largeButton];
    self.largeButton = largeButton;
    [largeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view).offset(-22);
        make.width.height.top.equalTo(weak_smallButton);
    }];
    
    
    UIView * textBackView = [UIView allocInit];
    textBackView.backgroundColor = [UIColor whiteColor];
    textBackView.layer.borderColor = DIVIDER_COLOR.CGColor;
    textBackView.layer.borderWidth = .5;
    [self.scrollView addSubview:textBackView];
    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_smallButton);
        make.top.equalTo(weak_smallButton.mas_bottom).offset(20);
        make.centerX.equalTo(wSelf.view);
        make.height.equalTo(@200);
    }];
    
    weakView(weak_textBackView, textBackView)
    self.textView = [UITextView allocInit];
    self.textView.font = textFont(14);
    self.textView.delegate = self;
    [textBackView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@5);
        make.center.equalTo(weak_textBackView);
    }];
    
    self.placeholderLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x919191) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.placeholderLabel.text = @"Write a review here...";
    [textBackView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.textView).offset(8);
        make.left.equalTo(wSelf.textView).offset(3);
    }];
    
    UILabel * remindLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    remindLabel.text = @"Add pictures(up to 3)";
    [self.scrollView addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_textBackView);
        make.top.equalTo(weak_textBackView.mas_bottom).offset(20);
    }];
    
    weakView(weak_remindLabel, remindLabel)
    self.displayPictureInforView = [XZZDisplayPictureInformationView allocInit];
    self.displayPictureInforView.imageCount = 3;
    [self.displayPictureInforView setChoosePicture:^{
        [wSelf useAlbumOrCamera];
    }];
    [self.displayPictureInforView setDeletePicture:^(NSInteger index) {
        if (wSelf.imageUrlArray.count > index) {
            [wSelf.imageUrlArray removeObjectAtIndex:index];
        }
    }];
    [self.scrollView addSubview:self.displayPictureInforView];
    [self.displayPictureInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_textBackView);
        make.top.equalTo(weak_remindLabel.mas_bottom).offset(5);
    }];
    [self dynamicChangesRefreshView];
}

#pragma mark ---- 添加sku视图信息
/**
 * #pragma mark ---- 添加sku视图信息
 */
- (void)addSkuViewInformation
{
    [self.skuScrollView removeAllSubviews];
    UIView * leftView = nil;
    WS(wSelf)
    UIScrollView * scrollView = self.skuScrollView;
    weakView(weak_scrollView, scrollView)
    for (XZZCanCommentSku * canCommentSku in self.skuOrderList) {
        weakView(weak_leftView, leftView)
        XZZGoodsCanCommentSkuView * goodsView = [XZZGoodsCanCommentSkuView allocInit];
        goodsView.canCommentSku = canCommentSku;
        [scrollView addSubview:goodsView];
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (weak_leftView) {
                make.left.equalTo(weak_leftView.mas_right).offset(6);
            }else{
                make.left.equalTo(@3);
            }
            make.width.equalTo(weak_scrollView).offset(-6);
            make.height.equalTo(@130);
            make.top.equalTo(@10);
        }];
        leftView = goodsView;
    }
    scrollView.contentSize = CGSizeMake((ScreenWidth - 50) * self.skuOrderList.count, 0);
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.placeholderLabel.hidden = textView.text.length;
}

#pragma mark ----*  合身程度按钮
/**
 *  合身程度按钮
 */
- (void)clickOnDegreeFitButton:(UIButton *)button
{
    if (![button isEqual:self.selectedButton]) {
        button.backgroundColor = button_back_color;
        button.selected = YES;
        self.selectedButton.backgroundColor = [UIColor whiteColor];
        self.selectedButton.selected = NO;
        self.selectedButton = button;
    }
}
#pragma mark ----提交评论
/**
 *  提交评论
 */
- (void)clickOnSubmitComments
{
    if (self.textView.text.length <= 0) {
        SVProgressError(@"Please enter the comments")
        return;
    }
    XZZCanCommentSku * canCommentSku = nil;
    if (self.skuOrderList.count > 1) {
        int count = self.skuScrollView.contentOffset.x / self.skuScrollView.width;
        canCommentSku = self.skuOrderList[count];
    }else if(self.skuOrderList.count){
        canCommentSku = self.skuOrderList[0];
    }else{
        return;
    }
    
    self.goodsId = self.goodsId ? self.goodsId : canCommentSku.goodsId;
    self.orderId = canCommentSku.orderId;
    self.skuId = canCommentSku.skuId;
    
    
    WS(wSelf)
    NSMutableDictionary * dic = @{@"content" : self.textView.text, @"goodsId" : self.goodsId, @"orderId" : self.orderId, @"score" : @(self.starRateView.currentScore), @"skuId" : self.skuId, @"suitability" : @(self.selectedButton.tag), @"pictureList" : self.imageUrlArray}.mutableCopy;
    NSArray * array = [NSArray arrayWithObjects:dic, nil];
    loadView(self.view)
    if (self.commentId) {
        [dic setValue:self.commentId forKey:@"commentId"];
        [XZZDataDownload goodsGetModifyComments:array httpBlock:^(id data, BOOL successful, NSError *error) {
                   loadViewStop
                   if (successful) {
                       SVProgressSuccess(@"Your review will be published soon. Thank you for sharing and helping others.");
                       [wSelf delayBack];
                   }else if (error){
                       SVProgressError(@"Try again later");
                   }else{
                       SVProgressError(@"Review failed");
                   }
               }];
    }else{
        [XZZDataDownload goodsGetAddComments:array httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                SVProgressSuccess(@"Your review will be published soon. Thank you for sharing and helping others.");
                [wSelf delayBack];
            }else if (error){
                SVProgressError(@"Try again later");
            }else{
                SVProgressError(@"Review failed");
            }
        }];
    }
}
#pragma mark ----*  延迟返回
/**
 *  延迟返回
 */
- (void)delayBack
{
    
    self.textView.text = @"";
    
    [self.imageUrlArray removeAllObjects];
    [self.displayPictureInforView deleteAllImage];
    
    WS(wSelf)
    
    if (self.skuOrderList.count > 1) {
        
        NSMutableArray * array = self.skuOrderList.mutableCopy;
        
        int count = self.skuScrollView.contentOffset.x / self.skuScrollView.width;
        XZZCanCommentSku * canCommentSku = self.skuOrderList[count];
        [array removeObject:canCommentSku];
        self.skuOrderList = array.copy;
        !self.removeCanCommentSku?:self.removeCanCommentSku(canCommentSku);
        
        [self addSkuViewInformation];
        
        return;
    }
    XZZCanCommentSku * canCommentSku = [self.skuOrderList firstObject];
    !self.removeCanCommentSku?:self.removeCanCommentSku(canCommentSku);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf back];
    });
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
        self.picker.modalPresentationStyle = UIModalPresentationFullScreen;
        
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
    [self.displayPictureInforView addImages:image];
    
    [self uploadPictures:image];

    
    [self dynamicChangesRefreshView];
}

- (void)uploadPictures:(UIImage *)image
{
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload uploadPictureInformation:image httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf.imageUrlArray addObject:data];
        }else{
//            [wSelf uploadPictures:image];
            [wSelf.displayPictureInforView deleteLastImage];
            SVProgressError(@"Image upload failed");
        }
    }];
}



#pragma mark ----*  动态延时刷新视图
/**
 *  动态延时刷新视图
 */
- (void)dynamicChangesRefreshView
{
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wSelf.scrollView.contentSize = CGSizeMake(0, wSelf.displayPictureInforView.bottom + 20);
    });
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


@end
