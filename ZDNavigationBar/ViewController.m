//
//  ViewController.m
//  ZDNavigationBar
//
//  Created by 赵丹 on 2016/10/1.
//  Copyright © 2016年 赵丹. All rights reserved.
//

#import "ViewController.h"
#import "ZDNavigationController.h"

@interface ViewController ()

@property (nonatomic, strong) UIViewController *ctrl1;

@property (nonatomic, strong) UIViewController *ctrl2;

@property (nonatomic, strong) UIViewController *ctrl3;

@property (nonatomic, strong) UIViewController *ctrl4;

@property (nonatomic, strong) UIViewController *ctrl5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}


- (void)beginAnimate
{
    ZDNavigationController *nav = (ZDNavigationController *)self.navigationController;
    nav.customLayer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (IBAction)sliderAction:(id)sender {
    UISlider *slider = sender;
    ZDNavigationController *nav = (ZDNavigationController *)self.navigationController;
    nav.customLayer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:slider.value].CGColor;
}


- (IBAction)action1:(id)sender {
    
    ((ZDNavigationController *)self.navigationController).navigationBarStyle = navigationBarClearWithBlackBackButton;
    self.ctrl1.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:self.ctrl1 animated:YES];
}


- (IBAction)action2:(id)sender {
    ((ZDNavigationController *)self.navigationController).navigationBarStyle = navigationBarClearWithBlackBackButton;
    self.ctrl2.view.backgroundColor = [UIColor brownColor];
    [self.navigationController pushViewController:self.ctrl2 animated:YES];
}

- (IBAction)action3:(id)sender {
    ((ZDNavigationController *)self.navigationController).navigationBarStyle = navigationBarWhiteWithBlackBackButton;
    self.ctrl3.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:self.ctrl3 animated:YES];
}

- (IBAction)action4:(id)sender {
    ((ZDNavigationController *)self.navigationController).navigationBarStyle = navigationBarClearWithImageBackButton;
    self.ctrl4.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:self.ctrl4 animated:YES];
}
- (IBAction)action5:(id)sender {
    ((ZDNavigationController *)self.navigationController).navigationBarStyle = navigationBarCustomStyle;
    self.ctrl5.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:self.ctrl5 animated:YES];
}

//下面这些是 使用我编写的插件创建的..
- (UIViewController *)ctrl5
{
    if (!_ctrl5) {
        _ctrl5 = [[UIViewController alloc] init];
    }
    return _ctrl5;
}

- (UIViewController *)ctrl4
{
    if (!_ctrl4) {
        _ctrl4 = [[UIViewController alloc] init];
    }
    return _ctrl4;
}

- (UIViewController *)ctrl3
{
    if (!_ctrl3) {
        _ctrl3 = [[UIViewController alloc] init];
    }
    return _ctrl3;
}

- (UIViewController *)ctrl2
{
    if (!_ctrl2) {
        _ctrl2 = [[UIViewController alloc] init];
    }
    return _ctrl2;
}

- (UIViewController *)ctrl1
{
    if (!_ctrl1) {
        _ctrl1 = [[UIViewController alloc] init];
    }
    return _ctrl1;
}


@end








































