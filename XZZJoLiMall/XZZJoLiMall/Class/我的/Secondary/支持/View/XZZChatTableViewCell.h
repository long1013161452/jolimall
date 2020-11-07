//
//  XZZChatTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZChatTableViewCell : UITableViewCell<UITextViewDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)ZDCChatEvent * event;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;



/**
 * <#expression#>
 */
@property (nonatomic, strong)NSIndexPath * indexPath;




/**
 * <#expression#>
 */
//@property (nonatomic, strong)UITextView * messageTextView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * messageLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * timeLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * messageImageView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * backView;

- (NSString *)getTime;

- (NSString *)getImageUrl;

- (BOOL)messageViewWithWideHigh;

@end



/**
 *  聊天消息  我的消息
 */
@interface XZZChatMyMessageTableViewCell : XZZChatTableViewCell


@end

/**
 *  聊天消息  我的图片消息
 */
@interface XZZChatMyImageMessageTableViewCell : XZZChatTableViewCell


@end

/**
 *  聊天消息  服务器消息
 */
@interface XZZChatServerMessageTableViewCell : XZZChatTableViewCell


@end
/**
 *  聊天消息  服务器图片
 */
@interface XZZChatServerImageMessageTableViewCell : XZZChatTableViewCell


@end


/**
 *  聊天消息  评价
 */
@interface XZZChatRatingMessageTableViewCell : XZZChatTableViewCell


/**
 * 好的
 */
@property (nonatomic, strong)UIButton * goodsButton;
/**
 * 坏的
 */
@property (nonatomic, strong)UIButton * badButton;


@end


/**
 *  聊天消息
 */
@interface XZZChatMessageTableViewCell : XZZChatTableViewCell


@end


















NS_ASSUME_NONNULL_END
