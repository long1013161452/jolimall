//
//  XZZDisplayPictureInformationView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/5/6.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^DeletePicture)(NSInteger index);

@interface XZZDisplayPictureInformationView : UIView


/**
 * <#expression#>
 */
@property (nonatomic, assign)int imageCount;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * imageArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock choosePicture;

/**
 * <#expression#>
 */
@property (nonatomic, strong)DeletePicture deletePicture;


- (void)addImages:(id)image;
/** 添加url  is  是否能删除*/
- (void)addImageUrlList:(NSArray *)list isCanDeleteImage:(BOOL)is;

- (void)deleteLastImage;

- (void)deleteAllImage;

@end

@class XZZDisplayPictureView;

typedef void(^ClickOnImageInformation)(XZZDisplayPictureView * view);
typedef void(^TurnOffPictureInformation)(XZZDisplayPictureView * view);

@interface XZZDisplayPictureView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)ClickOnImageInformation clickOnImageInformation;
/**
 * <#expression#>
 */
@property (nonatomic, strong)TurnOffPictureInformation turnOffPictureInformation;

- (void)addImages:(id)image;



/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * shutDownButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * imageView;

@end





NS_ASSUME_NONNULL_END
