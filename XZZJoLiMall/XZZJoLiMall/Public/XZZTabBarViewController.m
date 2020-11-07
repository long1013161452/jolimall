//
//  XZZTabBarViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZTabBarViewController.h"
#import "XZZHomeViewController.h"

@interface XZZTabBarViewController ()
/**
 * 购物车
 */
@property (nonatomic, strong)UIViewController * cartVC;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZHomeViewController * homeVC;

@end

@implementation XZZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartQuantity) name:@"numberShoppingCartsHasChanged" object:nil];

    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:kColorWithRGB(252, 32, 0, 1) } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(0x8D8D8D)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    
    
    UIViewController * homeVC = [self loadVCClass:@"XZZHomeViewController" title:@"shop" imageName:@"tabbar_home"];
    
    UIViewController * categoryVC = [self loadVCClass:@"XZZCategoryViewController" title:@"category" imageName:@"tabbar_category"];
    
     self.cartVC = [self loadVCClass:@"XZZCartViewController" title:@"cart" imageName:@"tabbar_cart"];
    
    UIViewController * userVC = [self loadVCClass:@"XZZUserViewController" title:@"me" imageName:@"tabbar_me"];
    
    self.viewControllers = @[homeVC, categoryVC, self.cartVC, userVC];
    
    self.tabBar.translucent = NO;
    
}

- (void)shoppingCartQuantity
{
    if (all_cart.allCartArray.count == 0) {
        self.cartVC.tabBarItem.badgeValue = nil;
        return;
    }
    self.cartVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)all_cart.allCartArray.count];
    
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    NSLog(@"---------=========---------%s %d 行", __func__, __LINE__);
    if (selectedIndex == 0) {
        [self.homeVC BackTop];
    }
}

- (UIViewController *)loadVCClass:(NSString *)class title:(NSString *)title imageName:(NSString *)imageName {
    
    UIViewController * VC = [[NSClassFromString(class) alloc] init];
    if ([VC isKindOfClass:[XZZHomeViewController class]]) {
        self.homeVC = VC;
    }
    XZZMyNavViewController *navVC = [[XZZMyNavViewController alloc] initWithRootViewController:VC];
    navVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSString *selectedImageName = [imageName stringByAppendingString:@"_selected"];
    navVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVC.tabBarItem.title = title;
    
    if (@available(iOS 10.0, *)) {
    self.tabBar.unselectedItemTintColor = [UIColor blackColor];
    } else {
    // Fallback on earlier versions
    }
    
    return navVC;
}




- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    [viewController popToRootViewControllerAnimated:YES];
    return YES;
}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//}
//- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//}
//- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed __TVOS_PROHIBITED
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//}
//
//- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//    return 1;
//}
//- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//    return 1;
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0)
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//    return nil;
//}
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
//                                                       toViewController:(UIViewController *)toVC
//{
//    NSLog(@"%s %d 行", __func__, __LINE__);
//    return nil;
//}



@end
