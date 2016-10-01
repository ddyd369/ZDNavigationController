//
//  TabBarViewController.m
//  ZDNavigationBar
//
//  Created by 赵丹 on 2016/10/1.
//  Copyright © 2016年 赵丹. All rights reserved.
//

#import "TabBarViewController.h"
#import "ZDNavigationController.h"
#import "ViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//给tabbar添加子控制器
- (void)addChildViewControllers{
    
    [self addMine];
}

- (void)addMine
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    
    ZDNavigationController *mineNav = (ZDNavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"ZDNavigationController"];
//    ZDNavigationController *mineNav = [ZDNavigationController alloc];
    
    
    [mineNav changeBaseBarStyle:navigationBarClearWithNothing];
    
    [mineNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, [UIColor blackColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [mineNav.tabBarItem setTitle:@"我的"];
    mineNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar-mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar-mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    [self addChildViewController:mineNav];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
