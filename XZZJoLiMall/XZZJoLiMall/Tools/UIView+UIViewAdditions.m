//
//  UIView+UIViewAdditions.m
//  HBBuyer
//
//  Created by user on 15/11/2.
//  Copyright © 2015年 QFC. All rights reserved.
//

#import "UIView+UIViewAdditions.h"

#import <objc/message.h>
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

@implementation UIView (UIViewAdditions)


- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}




//中心X点
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}
- (BOOL)visible{
    return !self.hidden;
}
- (void)setVisible:(BOOL)visible{
    self.hidden = !visible;
}
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}
- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}


- (CGFloat)ttScreenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}



- (CGFloat)ttScreenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (UIView *)breathingLampView
{
    return objc_getAssociatedObject(self, @"breathingLampView");
}

- (void)setBreathingLampView:(UIView *)breathingLampView
{
    objc_setAssociatedObject(self, @"breathingLampView", breathingLampView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
 
- (void)addBreathingLampView:(BOOL)isBackColor
{
    UIView * breathingLampView = [UIView allocInitWithFrame:self.bounds];
    [self addSubview:breathingLampView];
    WS(wSelf)
    [breathingLampView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf);
    }];
    if (isBackColor) {
        breathingLampView.backgroundColor = general_Color_CCCCCC;
    }
    
    //呼吸光动画
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.2];
    opacityAnimation.duration = 1.0;
    opacityAnimation.autoreverses = YES;
    opacityAnimation.repeatCount = FLT_MAX;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [breathingLampView.layer addAnimation:opacityAnimation forKey:@"opacity"];
    
    self.breathingLampView = breathingLampView;
}

+ (id)allocInitWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}
/**
 - (CGFloat)orientationWidth {
 return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
 ? self.height : self.width;
 }
 
 - (CGFloat)orientationHeight {
 return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
 ? self.width : self.height;
 }
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (void)addSubviews:(NSArray *)views
{
    for (UIView* v in views) {
        [self addSubview:v];
    }
}
+ (UILabel *)labelWithFrame:(CGRect)frame
                   fontSize:(CGFloat)fontSize
              textAlignment:(NSTextAlignment)alignment
                       text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    label.text = text;
    label.textColor = [UIColor blackColor];
    //    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}
+ (id)XibInitializationMethod
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
+ (id)XibInitializationMethodFrame:(CGRect)frame
{
    UIView * view = [self XibInitializationMethod];
    view.frame = frame;
    return view;
}

//通过响应者链条获取view所在的控制器
- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        NSLog(@"~~~%@", responder);
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


/**
 *  倒计时 视图信息
 */
- (UILabel *)createLabel:(CGRect)frame textColor:(UIColor *)textColor backColor:(UIColor *)backColor text:(NSString *)text fontSize:(CGFloat)fontSize
{
    UILabel * countdownLabel = [UILabel allocInitWithFrame:frame];
    countdownLabel.backgroundColor = backColor;
    countdownLabel.textColor = textColor;
    countdownLabel.font = textFont(fontSize);
    countdownLabel.textAlignment = NSTextAlignmentCenter;
    countdownLabel.text = text;
    
    return countdownLabel;
    
}

/**
 *  切圆角
 */
- (void)cutRounded:(CGFloat)size
{
    self.layer.cornerRadius = size;
    
    self.clipsToBounds=YES;
}

@end




@implementation UILabel (CreateMethodLabel)
+ (id)labelWithFrame:(CGRect)frame backColor:(UIColor *)backColor textAlignment:(NSTextAlignment)textAlignment tag:(NSInteger)tag
{
    UILabel * label = [[self alloc] initWithFrame:frame];
    label.backgroundColor = backColor;
    label.tag = tag;
    label.textAlignment = textAlignment;
    return label;
}

+ (id)labelWithFrame:(CGRect)frame backColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)textFont textAlignment:(NSTextAlignment)textAlignment tag:(NSInteger)tag
{
    UILabel * label = [UILabel allocInitWithFrame:frame];
    if (backColor) {
        label.backgroundColor = backColor;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    label.font = textFont(textFont);
    label.textAlignment = textAlignment;
    label.tag = tag;
    return label;
}

- (void)Text:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor
{
    self.text = text;
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = textColor;
}
- (void)changeTheHeightInputInformationText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor
{
    self.text = text;
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = textColor;
    self.numberOfLines = 0;
    self.height = [CalculateHeight getLabelHeightTitle:text font:font width:self.width];
}
- (void)changeTheWidthInputInformationText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor
{
    self.text = text;
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = textColor;
    self.width = [CalculateHeight getLabelWidthTitle:text font:font height:self.height];
}
- (void)changeTheHeightInputInformation
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.numberOfLines = 0;
    
    self.height = rect.size.height;
}
- (void)changeTheWidthInputInformation
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(0, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.width = rect.size.width;
}
@end
@implementation CalculateHeight
+ (CGFloat)getLabelHeightTitle:(NSString *)title font:(CGFloat)font width:(CGFloat)width
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}
+ (CGFloat)getLabelWidthTitle:(NSString *)title font:(CGFloat)font height:(CGFloat)height
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}
+ (CGFloat)getLabelHeightTitle:(NSAttributedString *)title size:(CGSize)size
{
    //NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    
    CGRect rect = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

    
    return rect.size.height;
    
    
}

+ (CGFloat)getLabelWidthTitle:(NSAttributedString *)title size:(CGSize)size
{
    CGRect rect = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    return rect.size.width;
}

@end

@implementation UIButton (Category)
#pragma mark ----*  g创建按钮
/**
 *  g创建按钮
 */
+ (id)allocInitWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    UIButton * button = [self allocInit];
    [button setImage:imageName(imageName) forState:(UIControlStateNormal)];
    [button setImage:imageName(selectedImageName) forState:(UIControlStateSelected)];
    return button;
}

- (void)imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    [self setImage:imageName(imageName) forState:(UIControlStateNormal)];
    [self setImage:imageName(selectedImageName) forState:(UIControlStateSelected)];
}

/**
 *  g创建按钮  文字
 */
+ (id)allocInitWithTitle:(NSString *)title color:(UIColor *)color selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor font:(CGFloat)font
{
    UIButton * button = [self allocInit];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitle:selectedTitle forState:(UIControlStateSelected)];
    [button setTitleColor:color forState:(UIControlStateNormal)];
    [button setTitleColor:selectedColor forState:(UIControlStateSelected)];
    button.titleLabel.font = textFont(font);
    return button;
}

/**
 *  g创建按钮  文字
 */
+ (id)allocInitWithTitle:(NSString *)title color:(UIColor *)color font:(CGFloat)font
{
    UIButton * button = [self allocInit];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitle:title forState:(UIControlStateSelected)];
    [button setTitleColor:color forState:(UIControlStateNormal)];
    [button setTitleColor:color forState:(UIControlStateSelected)];
    button.titleLabel.font = textFont(font);
    return button;
}

- (void)title:(NSString *)title color:(UIColor *)color selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor font:(CGFloat)font
{
    [self setTitle:title forState:(UIControlStateNormal)];
    [self setTitle:selectedTitle forState:(UIControlStateSelected)];
    [self setTitleColor:color forState:(UIControlStateNormal)];
    [self setTitleColor:selectedColor forState:(UIControlStateSelected)];
    self.titleLabel.font = textFont(font);
}

/**
 * 加载网络图片   固定占位图
 */
- (void)addImageFromUrlStr:(NSString *)urlStr
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:(UIControlStateNormal) placeholderImage:imageName(@"booth_figure_longitudinal")];
}
/**
 *  加载网络图片   固定占位图   完成回调
 */
- (void)addImageFromUrlStr:(NSString *)urlStr httpBlock:(HttpBlock)httpBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:imageName(@"booth_figure_longitudinal") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            !httpBlock?:httpBlock(image,YES, nil);
        }else{
            !httpBlock?:httpBlock(nil,NO, nil);
        }
    }];
}

/**
 * 加载网络图片    指定占位图
 */
- (void)addImageFromUrlStr:(NSString *)urlStr
          placeholderImage:(id)imageName
{
    UIImage * image;
    if ([imageName isKindOfClass:[NSString class]]) {
        image = imageName(imageName);
    }else if ([imageName isKindOfClass:[UIImage class]]){
        image = imageName;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:(UIControlStateNormal) placeholderImage:image];
    
}

@end



@implementation UIImageView (Category)

- (void)addImageFromUrlStr:(NSString *)urlStr
{
    
//    XZZImageProcess * imageProcess = [XZZImageProcess allocInitUrl:urlStr width:(ScreenWidth / 2 * 3) height:(ScreenWidth / 2 * 4)];
//    
//    urlStr = [NSString stringWithFormat:@"https://img.greatmola.com/%@", [RSA encryptionBase64:[imageProcess yy_modelToJSONString]]];
    
//    if ([urlStr hasPrefix:@"https://img.chellysun.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
//    if ([urlStr hasPrefix:@"https://img.greatmola.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
    
    
    NSLog(@"----=====----%@", urlStr);
    UIImage * image = nil;
    static UIImage * wideImage = nil;
    static UIImage * heightImage = nil;
    static UIImage * a_squareImage = nil;
    if (!wideImage) {
        wideImage = imageName(@"booth_figure_transverse");
    }
    if (!heightImage) {
        heightImage = imageName(@"booth_figure_longitudinal");
    }
    if (!a_squareImage) {
        a_squareImage = imageName(@"booth_figure_a_square");

    }
    NSLog(@"%@", urlStr);
    if (self.width > self.height) {
        image = wideImage;
    }else if(self.width == self.height){
        image = a_squareImage;
        }else{
        image = heightImage;
    }
    
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:image
                     options:(SDWebImageAllowInvalidSSLCertificates)
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (error) {
                           NSLog(@"错误信息:%@  %@",error, imageURL);
                       }
                   }];
    
    
}

- (void)addImageFromUrlStr:(NSString *)urlStr httpBlock:(HttpBlock)httpBlock
{
//    XZZImageProcess * imageProcess = [XZZImageProcess allocInitUrl:urlStr width:(ScreenWidth / 2 * 3) height:(ScreenWidth / 2 * 4)];
//
//    urlStr = [NSString stringWithFormat:@"https://img.greatmola.com/%@", [RSA encryptionBase64:[imageProcess yy_modelToJSONString]]];
//
//    if ([urlStr hasPrefix:@"https://img.chellysun.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
//    if ([urlStr hasPrefix:@"https://img.greatmola.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
    
    
    NSLog(@"----=====----%@", urlStr);
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:imageName(@"booth_figure_longitudinal")
                     options:(SDWebImageAllowInvalidSSLCertificates)
                   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                       if (image) {
                           !httpBlock?:httpBlock(image,YES, nil);
                       }else{
                           !httpBlock?:httpBlock(nil,NO, nil);
                       }
                       if (error) {
                           NSLog(@"错误信息:%@  %@",error, imageURL);
                       }
                   }];
}


- (void)addImageFromUrlStr:(NSString *)urlStr placeholderImage:(id)imageName
{
//    XZZImageProcess * imageProcess = [XZZImageProcess allocInitUrl:urlStr width:(ScreenWidth / 2 * 3) height:(ScreenWidth / 2 * 4)];
//
//    urlStr = [NSString stringWithFormat:@"https://img.greatmola.com/%@", [RSA encryptionBase64:[imageProcess yy_modelToJSONString]]];
//
//    if ([urlStr hasPrefix:@"https://img.chellysun.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
//    if ([urlStr hasPrefix:@"https://img.greatmola.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
    
    NSLog(@"----=====----%@", urlStr);
    UIImage * image;
    if ([imageName isKindOfClass:[NSString class]]) {
        image = imageName(imageName);
    }else if ([imageName isKindOfClass:[UIImage class]]){
        image = imageName;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:image      options:(SDWebImageAllowInvalidSSLCertificates)];
}

- (void)addImageFromUrlStrNoStore:(NSString *)urlStr placeholderImage:(NSString *)imageName
{
//    XZZImageProcess * imageProcess = [XZZImageProcess allocInitUrl:urlStr width:(ScreenWidth / 2 * 3) height:(ScreenWidth / 2 * 4)];
//
//    urlStr = [NSString stringWithFormat:@"https://img.greatmola.com/%@", [RSA encryptionBase64:[imageProcess yy_modelToJSONString]]];
    
//    if ([urlStr hasPrefix:@"https://img.chellysun.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
//    if ([urlStr hasPrefix:@"https://img.greatmola.com/"]) {
//        NSArray * array = [urlStr componentsSeparatedByString:@"/"];
//        urlStr = [NSString stringWithFormat:@"https://s3.amazonaws.com/s3.chellysun.com/image/%@", [array lastObject]];
//    }
    
    NSLog(@"----=====----%@", urlStr);
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:imageName(imageName) options:SDWebImageAllowInvalidSSLCertificates];
}


- (void)setImageFromUrl:(NSString *)imageUrl
{
    
    [self setImageFromUrl:imageUrl placeholderImage:@"booth_figure_longitudinal"];
}

- (void)setImageFromUrl:(NSString *)imageUrl placeholderImage:(id)imageName
{
    
    
    
    if ([imageName isKindOfClass:[UIImage class]]) {
        self.image = imageName;
    }else if ([imageName isKindOfClass:[NSString class]]){
        self.image = [UIImage imageNamed:imageName];
    }
    
    
    NSString * md5 = [self md5:imageUrl];
    NSString * path = [self getPathInforName:md5];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    
    if (result) {
        self.image = [[UIImage alloc] initWithContentsOfFile:path];
    }else{
        
        //1、获取一个全局串行队列
        dispatch_queue_t queueorder = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2、把任务添加到队列中执行
        dispatch_async(queueorder, ^{
            
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            [data writeToFile:path atomically:YES];
            
            UIImage * image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
            
        });
        
    }
    
    
}

- (NSString *)getPathInforName:(NSString *)name
{
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:@"/Documents/image/"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:newPath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        // 在Document目录下创建一个archiver目录
        [fileManager createDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    newPath = [newPath stringByAppendingPathComponent:name];
    return newPath;
}

- (NSString *) md5:(NSString *) str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




+ (id)allocInitWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView * imageView = [[UIImageView alloc] initWithImage:imageName(imageName)];
    imageView.frame = frame;
    return imageView;
}

@end



@implementation FLAnimatedImageView (Category)

/**
 *  加载图片  自定义缓存
 */
- (void)setImageFromUrl:(NSString *)imageUrl
{
    [self setImageFromUrl:imageUrl placeholderImage:@"booth_figure_longitudinal"];
}
/**
 *  加载图片  自定义缓存
 */
- (void)setImageFromUrl:(NSString *)imageUrl placeholderImage:(id)imageName
{
    if ([imageName isKindOfClass:[UIImage class]]) {
        self.image = imageName;
    }else if ([imageName isKindOfClass:[NSString class]]){
        self.image = [UIImage imageNamed:imageName];
    }
    
    
    NSString * md5 = [self md5:imageUrl];
    NSString * path = [self getPathInforName:md5];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    
    if (result) {
        NSData * data = [NSData dataWithContentsOfFile:path];
        FLAnimatedImage * animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
        if (animatedImage) {
            self.animatedImage = animatedImage;
        }else{
            UIImage * image = [UIImage imageWithData:data];
            self.image = image;
        }
    }else{
        WS(wSelf)
        //1、获取一个全局串行队列
        dispatch_queue_t queueorder = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2、把任务添加到队列中执行
        dispatch_async(queueorder, ^{
            
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            [data writeToFile:path atomically:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                FLAnimatedImage * animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
                if (animatedImage) {
                    wSelf.animatedImage = animatedImage;
                }else{
                    UIImage * image = [UIImage imageWithData:data];
                    wSelf.image = image;
                }
            });
        });
    }
}


- (NSString *)getPathInforName:(NSString *)name
{
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:@"/Documents/image/"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:newPath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        // 在Document目录下创建一个archiver目录
        [fileManager createDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    newPath = [newPath stringByAppendingPathComponent:name];
    return newPath;
}

- (NSString *) md5:(NSString *) str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end




@implementation UIScrollView (Category)












/**
 *  进入刷新状态
 */
- (void)beginRefreshing
{
    [self.mj_header beginRefreshing];
}
/**
 *  结束刷新加载
 */
- (void)endRefreshing
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}


- (void)addRefresh:(id)target refreshingAction:(SEL)action
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    
}

- (void)addLoading:(id)target refreshingAction:(SEL)action
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    
}

@end


@implementation NSObject (Category)


+ (instancetype)allocInit
{
    return [[self alloc] init];
}

/**
 *清除空对象
 */
- (id)removeEmptyObject:(id)data
{
    if ([data isKindOfClass:[NSArray class]]) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:data];
        
        for (int i = 0; i < array.count; i++) {
            
            id obj = array[i];
            
            if ([obj isKindOfClass:[NSNull class]]) {
                [array removeObject:obj];
                i--;
            }else{
                obj = [obj removeEmptyObject:obj];
                
                [array replaceObjectAtIndex:i withObject:obj];
            }
            
        }
        return array;
    }
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:data];
        NSArray * keys = dic.allKeys;
        
        for (id key in keys) {
            
            id obj = dic[key];
            
            if ([obj isKindOfClass:[NSNull class]]) {
                [dic removeObjectForKey:key];
            }else{
                [dic setValue:[obj removeEmptyObject:obj] forKey:key];
            }
            
            
        }
        return dic;
        
    }
    
    
    return data;
    
}

+ (BOOL)hft_hookClass:(Class)class OrigMenthod:(SEL)origSel NewMethod:(SEL)altSel {
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method altMethod = class_getInstanceMethod(class, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    BOOL didAddMethod = class_addMethod(class,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }
    
    return YES;
}


/**
 * 时间格式转换     conversionDate 1970的
 */
- (NSString *)timeFormat:(NSString *)timeFormat conversionDate:(NSString *)conversionDate
{
    //    timeFormat = @"MM/dd/yyyy HH:mm:ss";
    static NSDateFormatter * formatter = nil;
    if (!formatter) {
        formatter = [NSDateFormatter allocInit];
    }
    [formatter setDateFormat:timeFormat];
    
    //    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-7*60*60]];
    
    NSTimeInterval time = conversionDate.integerValue / 1000.0;
    
    if (time <= 30000) {
        
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SZ"];
        
        NSDate * date = [formatter dateFromString:conversionDate];
        
        if (!date) {
            [formatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
            date = [formatter dateFromString:conversionDate];
        }
        
        if (!date) {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            date = [formatter dateFromString:conversionDate];
        }
        
        [formatter setDateFormat:timeFormat];
        
        return [formatter stringFromDate:date];
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [formatter stringFromDate:date];
}
- (NSDate *)conversionDate:(NSString *)conversionDate
{
    NSString * timeFormat = @"MM/dd/yyyy HH:mm:ss";
    static NSDateFormatter * formatter = nil;
    if (!formatter) {
        formatter = [NSDateFormatter allocInit];
    }
    [formatter setDateFormat:timeFormat];
    
    //    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-7*60*60]];
    
    NSTimeInterval time = conversionDate.integerValue / 1000.0;
    
    if (time <= 30000) {
        
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SZ"];
        conversionDate = [NSString stringWithFormat:@"%@", conversionDate];
        NSDate * date = [formatter dateFromString:conversionDate];
        
        if (!date) {
            [formatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
            date = [formatter dateFromString:conversionDate];
        }
        
        if (!date) {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            date = [formatter dateFromString:conversionDate];
        }
        
        return date;
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    return date;
}

/**
 * 时间格式转换     timeInformation  时间信息  2018-03-30 16:24:42 -0700
 */
- (NSString *)timeFormat:(NSString *)timeFormat timeInformation:(NSString *)timeInformation
{
    timeFormat = @"MM/dd/yyyy HH:mm:ss";
    static NSDateFormatter * formatter = nil;
    if (!formatter) {
        formatter = [NSDateFormatter allocInit];
    }
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSDate * date = [formatter dateFromString:timeInformation];
    
    //    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-7*60*60]];
    
    [formatter setDateFormat:timeFormat];
    //    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString * time = [formatter stringFromDate:date];
    
    return time;
}


- (NSMutableAttributedString *)text:(NSString *)text font:(CGFloat)fontSize color:(UIColor *)color underlineText:(NSString *)underlineText underlineFont:(CGFloat)underlineFontSize underlineColor:(UIColor *)underlineColor
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: textFont(fontSize),NSForegroundColorAttributeName: color, NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
    [string addAttributes:@{NSForegroundColorAttributeName: underlineColor, NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSFontAttributeName : textFont(underlineFontSize)} range:[text rangeOfString:underlineText]];
    return string;
}

/**
 *  改变颜色  text 全部内容  fontSize 字体大小  color 字体颜色
 *         discolorationText 变色内容  discolorationFontSize 变色文字大小 discolorationColor变色字体颜色
 */
- (NSAttributedString *)text:(NSString *)text font:(CGFloat)fontSize color:(UIColor *)color discolorationText:(NSString *)discolorationText discolorationFont:(CGFloat)discolorationFontSize discolorationColor:(UIColor *)discolorationColor
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: textFont(fontSize),NSForegroundColorAttributeName: color, NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
    [string addAttributes:@{NSForegroundColorAttributeName: discolorationColor,  NSFontAttributeName : textFont(discolorationFontSize)} range:[text rangeOfString:discolorationText]];
    return string;
}


/**
 *  下划线  text 全部内容  fontSize 字体大小  color 字体颜色
 *         underlineText 下划线e内容  underlineFontSize 下滑线文字大小 underlineColor下划线字体颜色
 */
- (NSAttributedString *)allText:(NSString *)text font:(CGFloat)fontSize color:(UIColor *)color allUnderlineText:(NSString *)underlineText underlineFont:(CGFloat)underlineFontSize underlineColor:(UIColor *)underlineColor
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: textFont(fontSize),NSForegroundColorAttributeName: color, NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
    NSArray * array = [text componentsSeparatedByString:underlineText];
    NSMutableString * str = [NSMutableString string];
    NSRange range;
    
    for (int i = 0; i < array.count; i++) {
        NSString * string = array[i];
        if ((str.length && [text hasSuffix:string]) || (string.length == 0 && i == array.count - 1)) {
            break;
        }
        [str appendString:string];
        NSLog(@"%@", str);
        range = NSMakeRange(str.length, underlineText.length);
        [attributedString addAttributes:@{
                                          NSForegroundColorAttributeName: underlineColor,
                                          //                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                          NSFontAttributeName : textFont(underlineFontSize)
                                          
                                          } range:range];
        [str appendString:underlineText];
        NSLog(@"%@", str);
    }
    
    return attributedString;
}


@end


@implementation UITableView (Category)

- (void)cellWithXib:(NSString *)cellName identifier:(NSString *)identifier
{
    [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)registrationCellWithClass:(Class)myClass identifier:(NSString *)identifier
{
    [self registerClass:myClass forCellReuseIdentifier:identifier];
}



@end

@implementation UITableViewCell (Category)

+ (id)XIBCellWithTableView:(UITableView *)tableView
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    
    if (!cell) {
        
        [tableView cellWithXib:NSStringFromClass(self) identifier:NSStringFromClass(self)];
        
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


+ (id)codeCellWithTableView:(UITableView *)tableView
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    
    if (!cell) {
        
        [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass(self)];
        
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.userInteractionEnabled = NO;
    
    return cell;
    
}


@end

@implementation UICollectionView (Category)


- (void)registrationCellWithXib:(NSString *)cellName identifier:(NSString *)identifier
{
    [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:identifier];
    
}

- (void)registrationCellWithClass:(Class)myClass identifier:(NSString *)identifier
{
    [self registerClass:myClass forCellWithReuseIdentifier:identifier];
}

- (void)registrationHeadWithXib:(NSString *)headName identifier:(NSString *)identifier
{
    [self registerNib:[UINib nibWithNibName:headName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registrationHeadWithClass:(Class)myClass identifier:(NSString *)identifier
{
    [self registerClass:myClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registrationFoorWithXib:(NSString *)foorName identifier:(NSString *)identifier
{
    [self registerNib:[UINib nibWithNibName:foorName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
    
}

- (void)registrationFootWithClass:(Class)myClass identifier:(NSString *)identifier
{
    [self registerClass:myClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}



@end

@implementation UICollectionViewCell (Category)

+ (id)registeredXIBCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    
    if (!cell) {
        
        [collectionView registrationCellWithXib:NSStringFromClass(self) identifier:NSStringFromClass(self)];
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    }
    
    
    return cell;
    
}


+ (id)registeredCodeCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    
    if (!cell) {
        
        [collectionView registrationCellWithClass:[self class] identifier:NSStringFromClass(self)];
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    }
    return cell;
    
}


@end

@implementation UICollectionReusableView (Category)


+ (id)registeredXIBHearWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * hear = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    
    if (!hear) {
        
        [collectionView registrationHeadWithXib:NSStringFromClass(self) identifier:NSStringFromClass(self)];
        
        hear = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    }
    return hear;
    
}

+ (id)registeredCodeHearWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * hear = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    
    if (!hear) {
        
        [collectionView registrationCellWithClass:[self class] identifier:NSStringFromClass(self)];
        
        hear = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    }
    return hear;
}

+ (id)registeredXIBFooterWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    
    if (!foot) {
        
        [collectionView registrationFoorWithXib:NSStringFromClass(self) identifier:NSStringFromClass(self)];
        
        
        foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    }
    return foot;
}

+ (id)registeredCodeFooterWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    
    if (!foot) {
        
        [collectionView registrationFootWithClass:[self class] identifier:NSStringFromClass(self)];
        
        foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(self) forIndexPath:indexPath];
    }
    return foot;
}


@end

static char *my_name = "myName";

@implementation UIViewController (Category)


//- (void)setName:(NSString *)name
//{
//    objc_setAssociatedObject(self, my_name, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    
//}
//
//- (NSString *)name
//{
//    return objc_getAssociatedObject(self, my_name);
//}
//
//- (void)my_viewWillAppear:(BOOL)animated
//{
//    
//    
//    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
//    [tracker set:kGAIScreenName value:self.name];
//    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
////    return [self my_viewWillAppear:animated];
//}



//+ (void)load
//{
////    static dispatch_once_t onceToken;
////    dispatch_once(&onceToken, ^{
//        [object_getClass((id)self) hft_hookClass:self OrigMenthod:@selector(viewWillAppear:) NewMethod:@selector(my_viewWillAppear:)];
////    });
//}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popViewControllerAnimated:animated];
}
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController popToViewController:viewController animated:animated];
}
- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([viewController isKindOfClass:NSClassFromString(@"XZZGoodsDetailsViewController")]) {
        [viewController setHidesBottomBarWhenPushed:NO];
    }else{
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    CATransition *animation = [CATransition animation];
    animation.duration = 0.4f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.view.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end




@implementation UITextField (Category)

- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end


@implementation UIAlertController (Category)


+ (void)createWithTitle:(NSString *)title content:(NSString *)content controller:(UIViewController *)VC andActionTitle:(NSString *)actionTitle  actionBlock:(void(^)())actionBlock cancleActionTitle:(NSString *)cancleActionTitle cancleBlock:(void(^)())cancleBlock
{
    
    if (![title isKindOfClass:[NSString class]]) {
        title = @"";
    }
    if (![content isKindOfClass:[NSString class]]) {
        content = @"";
    }
    if (![actionTitle isKindOfClass:[NSString class]]) {
        actionTitle = @"";
    }
    if (![cancleActionTitle isKindOfClass:[NSString class]]) {
        cancleActionTitle = @"";
    }
    
    
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:actionBlock];
    [alertController addAction:cancelAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleActionTitle style:UIAlertActionStyleDefault handler:cancleBlock];
    [alertController addAction:cancleAction];
    [VC presentViewController:alertController animated:YES completion:nil];
    
}



+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origMethod = class_getInstanceMethod([self class], @selector(alertControllerWithTitle:message:preferredStyle:));
        Method swizMethod = class_getInstanceMethod([self class], @selector(myAlertControllerWithTitle:message:preferredStyle:));
        //        BOOL addMehtod = class_addMethod([self class], origsel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
        //        if (addMehtod)
        //        {
        //            class_replaceMethod([self class], swizsel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        //        }else
        //        {
        method_exchangeImplementations(origMethod, swizMethod);
        //        }
    });
}

+ (instancetype)myAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    if (![title isKindOfClass:[NSString class]]) {
        title = @" ";
    }
    
    if (![message isKindOfClass:[NSString class]]) {
        message = @" ";
    }
    return [UIAlertController myAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
}


@end


@implementation NSNull (Category)

- (NSInteger)length
{
    return 0;
}
@end


@implementation NSString (Category)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attribute = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
}


/**
 *  移除前后空格
 */
- (NSString *)removeForeAndAftSpaces
{
    
    if ([self containsString:@"  "]) {
        NSString * str = [self stringByReplacingOccurrencesOfString:@"  " withString:@" "];
        return [str removeForeAndAftSpaces];
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+ (NSString *)addComma:(double)num unit:(NSString *)unit
{
    NSString *newAmount;
    if (num < 1000) {
        if (unit.length == 0) {
            unit = @"";
        }
        return  [NSString stringWithFormat:@"%.2f%@",num, unit];
    }else{
        static NSNumberFormatter *formatter ;
        
        if (!formatter) {
            formatter = [[NSNumberFormatter alloc] init];
        }
        
        formatter.numberStyle =NSNumberFormatterDecimalStyle;
        
        [formatter setPositiveFormat:@",###.00;"];
        
        
        newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:num]];
    }
    if (unit.length <= 0) {
        return newAmount;
    }
    
    return [NSString stringWithFormat:@"%@%@", newAmount, unit];
}

+ (NSString *)addComma:(double)num unit:(NSString *)unit integer:(BOOL)integer
{
    NSString *newAmount;
    if (num < 1000) {
        if (unit.length == 0) {
            unit = @"";
        }
        return  [NSString stringWithFormat:@"%.2f%@",num, unit];
    }else{
        static NSNumberFormatter *formatter ;
        
        if (!formatter) {
            formatter = [[NSNumberFormatter alloc] init];
        }
        
        formatter.numberStyle =NSNumberFormatterDecimalStyle;
        if (integer) {
            [formatter setPositiveFormat:@",###;"];
        }else{
            [formatter setPositiveFormat:@",###.00;"];
        }
        
        
        
        newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:num]];
    }
    if (unit.length <= 0) {
        return newAmount;
    }
    
    return [NSString stringWithFormat:@"%@%@", newAmount, unit];
}


@end


@implementation CALayer (Category)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
}

@end


@implementation UIColor (Category)

+ (UIColor *)colorFromHexCode:(NSString *)hexString
{
    long colorLong ;

    if ([hexString hasPrefix:@"#"]) {
        NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        colorLong = strtoul([cleanString cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    }else if ([hexString hasPrefix:@"0x"]){
        colorLong = strtoul([hexString cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);

    }else if ([hexString hasPrefix:@"0X"]){
        colorLong = strtoul([hexString cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    }else{
        colorLong = strtoul([hexString cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    }
    
    return kColor(colorLong);
    
}

@end
