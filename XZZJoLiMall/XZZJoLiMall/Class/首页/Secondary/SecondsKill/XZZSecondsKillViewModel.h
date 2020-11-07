//
//  XZZSecondsKillModelView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZSecondsKillSession.h"

NS_ASSUME_NONNULL_BEGIN


@protocol XZZSecondsKillViewModelDelegate <NSObject>

@optional
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScroll;

@end

typedef void(^ManuallyRefreshData)(XZZSecondsKillSession * secKillSession);


@interface XZZSecondsKillViewModel : NSObject<UITableViewDelegate, UITableViewDataSource>

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock refreshBlock;

/**
 * <#expression#>
 */
@property (nonatomic, strong)ManuallyRefreshData refreshTwoBlock;

/**
 * 控制器
 */
@property (nonatomic, weak)UIViewController * VC;

/**
 * <#expression#>
 */
@property (nonatomic, weak)UITableView * tableView;
/**
 * <#expression#>
 */
@property (nonatomic, weak)UIView * tableHeaderView;
/**
 * <#expression#>
 */
@property (nonatomic, assign)NSInteger buttonCount;
/**
 * <#expression#>
 */
@property (nonatomic, assign)NSInteger index;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * secondsKillList;
/**
 * 秒杀场次
 */
@property (nonatomic, strong)XZZSecondsKillSession * secondsKill;

/**
 * <#expression#>
 */
@property (nonatomic, strong)SelectSession selectSession;


/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * secKillBackView;

/**
 * <#expression#>
 */
@property (nonatomic, weak)id<XZZSecondsKillViewModelDelegate> delegate;

/**
 *  更新数据
 */
- (void)updateData;
/**
 *  数据下载   用于下拉加载
 */
- (void)dataDownload;

@end

NS_ASSUME_NONNULL_END
