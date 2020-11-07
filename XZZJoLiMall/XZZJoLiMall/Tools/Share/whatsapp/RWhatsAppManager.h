//
//  RWhatsAppManager.h
//  sharekit
//
//  Created by valenti on 2018/6/25.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"

/**
 * WhatsApp iOS 分享和 Android 不同, iOS 只能对单一的媒体类型分享, 不能同时图文共存, 并且分享图片需要借助 UIDocumentInteractionController.
 */
@interface RWhatsAppManager : RShare

+ (instancetype)shared;

/***  判断是否安装 */
- (BOOL)whetherInstall;

- (void)connect:(RConfiguration)c;

- (void)shareText:(NSString*)text;

- (void)shareImage:(UIImage*)image from:(UIViewController*)from;


@end

