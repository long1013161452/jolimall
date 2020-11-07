//
//  UIView+UIViewAdditions.h
//  HBBuyer
//
//  Created by user on 15/11/2.
//  Copyright © 2015年 QFC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLAnimatedImageView.h"

#import "XZZImageProcess.h"

@interface UIView (UIViewAdditions)


#pragma 给UIView创建一个 分类，遍历于设置 UIView的frame
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;
@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;
@property(nonatomic) BOOL visible;



@property (nonatomic, readonly) CGFloat ttScreenX;


@property (nonatomic, readonly) CGFloat ttScreenY;




/**
 * 呼吸灯  视图
 */
@property (nonatomic, strong)UIView * breathingLampView;

/**
 * 添加呼吸灯视图
 */
- (void)addBreathingLampView:(BOOL)isBackColor;

  /**
 *  快捷创建视图方法
 */
+ (id)allocInitWithFrame:(CGRect)frame;
  /**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;
  /**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;
  /**
 * Removes all subviews.
 */
- (void)removeAllSubviews;
  /**
 * Calculates the offset of this view from another view in screen coordinates.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;
  /**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;
- (void)addSubviews:(NSArray *)views;
#pragma mark - 快速创建label方法
  /**
 *  快速创建label方法
 *
 *  @param frame     位置
 *  @param fontSize  字体大小
 *  @param alignment 对其方式
 *  @param text      文字内容
 *
 *  @return 返回创建好的label
 */
+ (UILabel *)labelWithFrame:(CGRect)frame
                   fontSize:(CGFloat)fontSize
              textAlignment:(NSTextAlignment)alignment
                       text:(NSString *)text;
  /**
 *  xib 视图信息创建
 */
+ (id)XibInitializationMethod;
  /**
 *  xib 视图信息创建
 *
 *  @param frame 视图位置
 */
+ (id)XibInitializationMethodFrame:(CGRect)frame;


- (UIViewController *)parentController;

/**
 *  倒计时 视图信息
 */
- (UILabel *)createLabel:(CGRect)frame textColor:(UIColor *)textColor backColor:(UIColor *)backColor text:(NSString *)text fontSize:(CGFloat)fontSize;



/**
 *  切圆角
 */
- (void)cutRounded:(CGFloat)size;


@end


#pragma mark - UILabel的分类，快速计算label的高度、宽度
  /**
 *  Label
 */
@interface UILabel (CreateMethodLabel)
  /**
 *  初始化
 *
 *  @param frame         位置
 *  @param backColor     背景颜色
 *  @param textAlignment 对齐方式
 *  @param tag           tag
 *
 *  @return <#return value description#>
 */
+ (id)labelWithFrame:(CGRect)frame backColor:(UIColor *)backColor textAlignment:(NSTextAlignment)textAlignment tag:(NSInteger)tag;


/**
 *  初始化
 *
 *  @param frame         位置
 *  @param backColor     背景颜色
 *  @param textColor     字体颜色
 *  @param textFont      字体大小
 *  @param textAlignment 对齐方式
 *  @param tag           tag
 *
 *  @return <#return value description#>
 */
+ (id)labelWithFrame:(CGRect)frame backColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)textFont textAlignment:(NSTextAlignment)textAlignment tag:(NSInteger)tag;


  /**
 *  填写文字信息
 *
 *  @param text      文字
 *  @param font      大小
 *  @param textColor 颜色
 */
- (void)Text:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor;
  /**
 *  自适应高度
 *
 *  @param text      文字
 *  @param font      大小
 *  @param textColor 颜色
 */
- (void)changeTheHeightInputInformationText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor;
  /**
 *  自适应宽度
 *
 *  @param text      文字
 *  @param font      大小
 *  @param textColor 颜色
 */
- (void)changeTheWidthInputInformationText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor;
  /**
 *  自动修改label的高度
 */
- (void)changeTheHeightInputInformation;
  /**
 *  自动修改label的宽度
 */
- (void)changeTheWidthInputInformation;
@end
#pragma mark ---- 计算文字高度
  /**
 *  计算文字的宽高
 */
@interface CalculateHeight : NSObject
  /**
 *  计算高度
 *
 *  @param title 文字
 *  @param font  字体大小
 *  @param width 宽度
 *
 *  @return 返回高度
 */
+ (CGFloat)getLabelHeightTitle:(NSString *)title font:(CGFloat)font width:(CGFloat)width;
  /**
 *  计算宽度
 *
 *  @param title  文字
 *  @param font   字体大小
 *  @param height 高度
 *
 *  @return 返回宽度
 */
+ (CGFloat)getLabelWidthTitle:(NSString *)title font:(CGFloat)font height:(CGFloat)height;

+ (CGFloat)getLabelHeightTitle:(NSAttributedString *)title size:(CGSize)size;

+ (CGFloat)getLabelWidthTitle:(NSAttributedString *)title size:(CGSize)size;



@end



/**
 *  按钮
 */
@interface UIButton (Category)

/**
 *  g创建按钮
 */
+ (id)allocInitWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

/**
 *  设置按钮图片
 */
- (void)imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

/**
 *  g创建按钮  文字
 */
+ (id)allocInitWithTitle:(NSString *)title color:(UIColor *)color selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor font:(CGFloat)font;

/**
 *  g创建按钮  文字
 */
+ (id)allocInitWithTitle:(NSString *)title color:(UIColor *)color font:(CGFloat)font;

/**
 *  设置a按钮  文字
 */
- (void)title:(NSString *)title color:(UIColor *)color selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor font:(CGFloat)font;

/**
 * 加载网络图片   固定占位图
 */
- (void)addImageFromUrlStr:(NSString *)urlStr;
/**
 *  加载网络图片   固定占位图   完成回调
 */
- (void)addImageFromUrlStr:(NSString *)urlStr httpBlock:(HttpBlock)httpBlock;

/**
 * 加载网络图片    指定占位图
 */
- (void)addImageFromUrlStr:(NSString *)urlStr
          placeholderImage:(id)imageName;

@end



/**
 *  图片视图
 */
@interface UIImageView (Category)

/**
 * 加载网络图片   固定占位图
 */
- (void)addImageFromUrlStr:(NSString *)urlStr;
/**
 *  加载网络图片   固定占位图   完成回调
 */
- (void)addImageFromUrlStr:(NSString *)urlStr httpBlock:(HttpBlock)httpBlock;

/**
 * 加载网络图片    指定占位图
 */
- (void)addImageFromUrlStr:(NSString *)urlStr
          placeholderImage:(id)imageName;

/**
 * 加载网络图片   不缓存的
 */
- (void)addImageFromUrlStrNoStore:(NSString *)urlStr
                 placeholderImage:(NSString *)imageName;

/**
 *  加载图片  自定义缓存
 */
- (void)setImageFromUrl:(NSString *)imageUrl ;
/**
 *  加载图片  自定义缓存
 */
- (void)setImageFromUrl:(NSString *)imageUrl placeholderImage:(id)imageName;


+ (id)allocInitWithFrame:(CGRect)frame imageName:(NSString *)imageName;

@end


@interface FLAnimatedImageView (Category)

/**
 *  加载图片  自定义缓存
 */
- (void)setImageFromUrl:(NSString *)imageUrl ;
/**
 *  加载图片  自定义缓存
 */
- (void)setImageFromUrl:(NSString *)imageUrl placeholderImage:(id)imageName;

@end




@interface UIScrollView (Category)
  /**
 *  主动进入刷新状态
 */
- (void)beginRefreshing;
  /**
 *  结束刷新加载状态
 */
- (void)endRefreshing;

  /**
 *  添加刷新方法
 */
- (void)addRefresh:(id)target refreshingAction:(SEL)action;

  /**
 *  添加加载方法
 */
- (void)addLoading:(id)target refreshingAction:(SEL)action;






@end

@interface NSObject (Category)

+ (instancetype)allocInit;




  /**
 *清除空对象
 */
- (id)removeEmptyObject:(id)data;


+ (BOOL)hft_hookClass:(Class)class OrigMenthod:(SEL)origSel NewMethod:(SEL)altSel;


/**
 * 时间格式转换     conversionDate 1970的
 */
- (NSString *)timeFormat:(NSString *)timeFormat conversionDate:(NSString *)conversionDate;

/**
 * 时间格式转换     conversionDate 1970的或2018-03-30T16:24:42.000-0700
 */
- (NSDate *)conversionDate:(NSString *)conversionDate;

/**
 * 时间格式转换     timeInformation  时间信息  2018-03-30 16:24:42 -0700
 */
- (NSString *)timeFormat:(NSString *)timeFormat timeInformation:(NSString *)timeInformation;

/**
 *  下划线  text 全部内容  fontSize 字体大小  color 字体颜色
 *         underlineText 下划线e内容  underlineFontSize 下滑线文字大小 underlineColor下划线字体颜色
 */
- (NSMutableAttributedString *)text:(NSString *)text font:(CGFloat)fontSize color:(UIColor *)color underlineText:(NSString *)underlineText underlineFont:(CGFloat)underlineFontSize underlineColor:(UIColor *)underlineColor;

/**
 *  改变颜色  text 全部内容  fontSize 字体大小  color 字体颜色
 *         discolorationText 变色内容  discolorationFontSize 变色文字大小 discolorationColor变色字体颜色
 */
- (NSAttributedString *)text:(NSString *)text font:(CGFloat)fontSize color:(UIColor *)color discolorationText:(NSString *)discolorationText discolorationFont:(CGFloat)discolorationFontSize discolorationColor:(UIColor *)discolorationColor;

/**
 *  下划线  text 全部内容  fontSize 字体大小  color 字体颜色
 *         underlineText 下划线e内容  underlineFontSize 下滑线文字大小 underlineColor下划线字体颜色
 */
- (NSAttributedString *)allText:(NSString *)text font:(CGFloat)fontSize color:(UIColor *)color allUnderlineText:(NSString *)underlineText underlineFont:(CGFloat)underlineFontSize underlineColor:(UIColor *)underlineColor;


@end

@interface UITableView (Category)

- (void)cellWithXib:(NSString *)cellName identifier:(NSString *)identifier;

- (void)registrationCellWithClass:(Class)myClass identifier:(NSString *)identifier;



@end

@interface UITableViewCell (Category)

	  /**
	 *  快速创建取值cell信息    xib创建的cell
	 */
+ (id)XIBCellWithTableView:(UITableView *)tableView;

  /**
 *  快速创建取值cell信息    纯代码创建的cell
 */
+ (id)codeCellWithTableView:(UITableView *)tableView;


@end


@interface UICollectionView (Category)

- (void)registrationCellWithXib:(NSString *)cellName identifier:(NSString *)identifier;

- (void)registrationCellWithClass:(Class)myClass identifier:(NSString *)identifier;

- (void)registrationHeadWithXib:(NSString *)headName identifier:(NSString *)identifier;

- (void)registrationHeadWithClass:(Class)myClass identifier:(NSString *)identifier;

- (void)registrationFoorWithXib:(NSString *)foorName identifier:(NSString *)identifier;

- (void)registrationFootWithClass:(Class)myClass identifier:(NSString *)identifier;

@end

@interface UICollectionViewCell (Category)

  /**
 *  快速创建取值cell信息    xib创建的cell
 */
+ (id)registeredXIBCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

  /**
 *  快速创建取值cell信息    春代码创建的cell
 */
+ (id)registeredCodeCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;


@end


@interface UICollectionReusableView (Category)

	  /**
	 * 快速使用hear   xib创建的hear
	 */
+ (id)registeredXIBHearWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

	  /**
	 * 快速使用hear  纯代码创建的hear
	 */
+ (id)registeredCodeHearWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

	  /**
	 * 快速使用foot  xib创建的foot
	 */
+ (id)registeredXIBFooterWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

	  /**
	 * 快速使用foot   纯代码创建的foot
	 */
+ (id)registeredCodeFooterWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;


@end



@interface UIViewController (Category)

///**
// * <#expression#>
// */
//@property (nonatomic, strong)NSString * name;
//
///**
// *  埋点
// */
//- (void)my_viewWillAppear:(BOOL)animated;

- (void)back;


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;

@end








@interface UITextField (Category)


/**
 * UITextField Category 用于控制光标位置
 */

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end


@interface UIAlertController (Category)


  /**
 * 创建弹出框   自动弹出
 */
+ (void)createWithTitle:(NSString *)title content:(NSString *)content controller:(UIViewController *)VC andActionTitle:(NSString *)actionTitle  actionBlock:(void(^)(void))actionBlock cancleActionTitle:(NSString *)cancleActionTitle cancleBlock:(void(^)(void))cancleBlock;


@end


@interface NSNull (Category)

- (NSInteger)length;
@end

@interface NSString (Category)


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  移除前后空格
 */
- (NSString *)removeForeAndAftSpaces;

  /**
 *数字逗号分割   num  数据源   unit 单位   
 */
+ (NSString *)addComma:(double)num unit:(NSString *)unit;

  /**
 *数字逗号分割   num  数据源   unit 单位    integer  是否取整  yes取整   no保留两位（小于一千的时候默认为保留两位小数）
 */
+ (NSString *)addComma:(double)num unit:(NSString *)unit integer:(BOOL)integer;

@end


@interface CALayer (Category)

@end

@interface UIColor (Category)

+ (UIColor *)colorFromHexCode:(NSString *)hexString;

@end








