//
//  DDYTabBarController.m
//  DDYLanguageTool
//
//  Created by SmartMesh on 2018/6/28.
//  Copyright © 2018年 com.smartmesh. All rights reserved.
//

#import "DDYTabBarController.h"
#import "DDYNavigationController.h"

@interface DDYTabBarController ()

@end

@implementation DDYTabBarController

DDYNavigationController * myNavigation(NSString *classKey, NSString *title, NSString *imageName, NSString *selectedImageName) {
    UIViewController *vc = [NSClassFromString(classKey) new];
    vc.tabBarItem.title = NSLocalizedString(title, nil);
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return [[DDYNavigationController alloc] initWithRootViewController:vc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:myNavigation(@"ViewController", @"TabBarHome", @"ddyTest", @"ddyTest")];
    [self addChildViewController:myNavigation(@"UIViewController", @"TabBarContacts", @"ddyTest", @"ddyTest")];
    [self addChildViewController:myNavigation(@"UIViewController", @"TabBarFind", @"ddyTest", @"ddyTest")];
    [self addChildViewController:myNavigation(@"TestViewController", @"TabBarCenter", @"ddyTest", @"ddyTest")];
}

#pragma mark 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}
#pragma mark 是否支持自动旋转
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
#pragma mark 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.selectedViewController preferredStatusBarStyle];
}

@end
