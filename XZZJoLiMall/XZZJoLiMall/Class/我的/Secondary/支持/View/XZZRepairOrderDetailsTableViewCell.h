//
//  XZZRepairOrderDetailsTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/13.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZRepairOrderDetailsTableViewCell : UITableViewCell<UITextViewDelegate>



/**
 * <#expression#>
 */
@property (nonatomic, strong)ZDKCommentWithUser * commentWithUser;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITextView * contenttextView;
@property (nonatomic, strong)UILabel * contentLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * timeLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * backView;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * imageBackView;

- (NSString *)getTime;



@end

@interface XZZServerRepairOrderDetailsTableViewCell : XZZRepairOrderDetailsTableViewCell

@end

@interface XZZMyRepairOrderDetailsTableViewCell : XZZRepairOrderDetailsTableViewCell


@end



NS_ASSUME_NONNULL_END
