//
//  DDYNavigationController.m
//  DDYLanguageTool
//
//  Created by SmartMesh on 2018/6/28.
//  Copyright © 2018年 com.smartmesh. All rights reserved.
//

#import "DDYNavigationController.h"

@interface DDYNavigationController ()

@end

@implementation DDYNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}
#pragma mark 是否支持自动旋转
- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}
#pragma mark 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

@end
