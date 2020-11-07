//
//  XZZCommonLogicalInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/18.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCommonLogicalInfor.h"

#import "XZZGoodsCommentsViewController.h"

@implementation XZZCommonLogicalInfor


#pragma mark ----*  处理商品收藏
/**
*  处理商品收藏
*/
+ (void)goodsCollectionAccordingId:(NSString *)goodsId source:(int)source VC:(nonnull UIViewController *)vc reloadData:(nonnull GeneralBlock)reloadData
{
    if (!User_Infor.isLogin) {
        logInVC(vc)
    }else{
        if (goodsId.length <= 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                SVProgressError(@"Collection to cancel failed")
                !reloadData?:reloadData();
            });            
            return;
        }
        [User_Infor collectionGoodsId:goodsId source:source httpBlock:^(id data, BOOL successful, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successful) {
                    SVProgressSuccess(data)
                }else{
                    SVProgressError(data)
                }
                !reloadData?:reloadData();
            });
        }];
    }
}

/**
 *  登陆
 */
+ (void)logInVC:(UIViewController *)VC
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (User_Infor.isLogin) {
            [User_Infor loggedOut];
        }
        XZZLoginViewController * logInVC = [XZZLoginViewController allocInit];
        XZZMyNavViewController * navVC = [[XZZMyNavViewController alloc] initWithRootViewController:logInVC];
        navVC.modalPresentationStyle = UIModalPresentationFullScreen;
        if (VC) {
            [VC presentViewController:navVC animated:YES completion:nil];
        }else{
            UIViewController * vc = [UIApplication sharedApplication].delegate.window.rootViewController;
            [vc presentViewController:navVC animated:YES completion:nil];
        }
    });
}

/**
 *  进入商品详情
 */
+ (void)goGoodsDetailsAccordingId:(NSString *)goodsId VC:(UIViewController *)vc
{
    
    
    if (goodsId.length) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            XZZGoodsDetailsViewController * goodsDetailsVC = [XZZGoodsDetailsViewController allocInit];
            goodsDetailsVC.goodsId = goodsId;
            [vc pushViewController:goodsDetailsVC animated:YES];
        });
    }
}

@end
