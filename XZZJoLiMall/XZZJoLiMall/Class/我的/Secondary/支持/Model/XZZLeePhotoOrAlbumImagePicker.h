//
//  XZZLeePhotoOrAlbumImagePicker.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/12.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LeePhotoOrAlbumImagePickerBlock)(UIImage *image);

@interface XZZLeePhotoOrAlbumImagePicker : NSObject

/**
 公共方法 选择图片后的图片回掉
 
 @param controller 使用这个工具的控制器
 @param photoBlock 选择图片后的回掉
 */
- (void)getPhotoAlbumOrTakeAPhotoWithController:(UIViewController *)controller photoBlock:(LeePhotoOrAlbumImagePickerBlock)photoBlock;


@end

NS_ASSUME_NONNULL_END
