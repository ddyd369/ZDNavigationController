//
//  ZDNavigationController.m
//  ZDNavigationBar
//
//  Created by 赵丹 on 2016/10/1.
//  Copyright © 2016年 赵丹. All rights reserved.
//

#import "ZDNavigationController.h"

@interface ZDNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    NSInteger _controllersNum;
    BOOL _popAction;
    BOOL _popToTootAction;
}

@property (nonatomic, strong) NSMutableArray *barStyleArray;

@end

@implementation ZDNavigationController

+ (void)initialize
{
    //设置默认值.
    [[UINavigationBar appearanceWhenContainedIn:self, nil] setTranslucent:YES];
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    navigationBar.tintColor = [UIColor blackColor];
    
    CGRect rect = CGRectMake(0, 0, screenWidth, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [navigationBar setShadowImage:image];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.barStyleArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:self.navigationBarStyle], nil];
    [self changeNavigationBarStyleWith:self.navigationBarStyle];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.delegate = self;
    //    self.interactivePopGestureRecognizer.delegate = self;
    
    //导航条 现在发现有 四种情况
    //1.透明, 没有返回按钮.
    //2.透明,  带黑色返回按钮图片.
    //3.不透明 白色, 带黑色返回按钮图片.
    //4.透明, 带 定制的 返回按钮图片.
    //上面四项对应  .h文件中的枚举.
    
    //下面这几行, 是向navigationBar
    //最底层的View(这个View高只有40, 所以layer高需要是64) 添加一个CALayer
    //并且不能设置 maskToBounds 之类的属性.
    //通过操作这个customLayer 控制导航栏的透明, 或者不透明, 或者颜色.
    //独创哦.  网上没有发现用我这种方法滴.
    
    self.customLayer = [[CALayer alloc] init];
    self.customLayer.frame = CGRectMake(0, 0, screenWidth, 64);
    self.customLayer.backgroundColor = [UIColor clearColor].CGColor;
    UIView *view = [self.navigationBar.subviews firstObject];
    view.backgroundColor = [UIColor clearColor];
    view.layer.backgroundColor = [UIColor clearColor].CGColor;
    [view.layer addSublayer:self.customLayer];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

#pragma mark - private
- (void)makeNavigationBarIntoWhiteStyle
{
    [self.navigationBar setBackgroundImage:[self getNavigationBarImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.customLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.navigationBar.tintColor = [UIColor blackColor];
}

- (void)makeNavigationBarIntoClearStyle
{
    [self.navigationBar setBackgroundImage:[self getNavigationBarImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.customLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.navigationBar.tintColor = [UIColor blackColor];
}

- (void)makeNavigationBarIntoCostomStyle:(UIColor *)color
{
    [self.navigationBar setBackgroundImage:[self getNavigationBarImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.customLayer.backgroundColor = color.CGColor;
    self.navigationBar.tintColor = [UIColor blackColor];
}

- (UIImage *)getNavigationBarImageWithColor:(UIColor *)color
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect rect = CGRectMake(0, -64, screenWidth, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    CGContextRelease(context);
    return image;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSRange range = NSMakeRange(self.viewControllers.count, self.barStyleArray.count - self.viewControllers.count);
    [self.barStyleArray removeObjectsInRange:range];
    [self.barStyleArray addObject:[NSNumber numberWithInteger:self.navigationBarStyle]];
    navigationBarStyle style = (navigationBarStyle)[[self.barStyleArray lastObject] integerValue];
    [self changeNavigationBarStyleWith:style];
    switch (style) {
        case navigationBarClearWithNothing:
        {
            [viewController.navigationItem setHidesBackButton:YES];
            viewController.navigationItem.hidesBackButton = YES;
        }
            break;
        case navigationBarClearWithBlackBackButton:
        {
            [viewController.navigationItem setHidesBackButton:NO];
            viewController.navigationItem.hidesBackButton = NO;
        }
            break;
        case navigationBarWhiteWithBlackBackButton:
        {
            [viewController.navigationItem setHidesBackButton:NO];
            viewController.navigationItem.hidesBackButton = NO;
        }
            break;
        case navigationBarClearWithImageBackButton:
        {
            [viewController.navigationItem setHidesBackButton:NO];
            viewController.navigationItem.hidesBackButton = NO;
        }
            break;
        case navigationBarCustomStyle:
        {
            [viewController.navigationItem setHidesBackButton:NO];
            viewController.navigationItem.hidesBackButton = NO;
        }
            break;    break;
        default:
            break;
    }
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    _controllersNum = self.viewControllers.count;
    [super pushViewController:viewController animated:animated];
    
    
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    _popAction = YES;
    _controllersNum = self.viewControllers.count;
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    _popToTootAction = YES;
    
    return [super popToRootViewControllerAnimated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSInteger count = navigationController.viewControllers.count;
    if (count < _controllersNum && !_popToTootAction) {
        //pop
        NSRange range = NSMakeRange(count, self.barStyleArray.count - navigationController.viewControllers.count);
        [self.barStyleArray removeObjectsInRange:range];
        
        navigationBarStyle style = (navigationBarStyle)[self.barStyleArray[count - 1] integerValue];
        self.navigationBarStyle = style;
        [self changeNavigationBarStyleWith:style];
        
        _popAction = NO;
    }else if (count < _controllersNum && _popToTootAction)
    {
        //popToRootAction;
        navigationBarStyle style = (navigationBarStyle) [[self.barStyleArray firstObject] integerValue];
        [self.barStyleArray removeAllObjects];
        [self.barStyleArray addObject:[NSNumber numberWithInteger:style]];
        self.navigationBarStyle = style;
        [self changeNavigationBarStyleWith:style];
        
        _popToTootAction = NO;
    }else if (count > _controllersNum)
    {
        //push
    }
}

#pragma mark - setter
- (void)setNavigationBarStyle:(navigationBarStyle)navigationBarStyle
{
    if (_navigationBarStyle != navigationBarStyle) {
        _navigationBarStyle = navigationBarStyle;
    }
}

- (void)changeBaseBarStyle:(navigationBarStyle)style
{
    self.barStyleArray[0] = [NSNumber numberWithInteger:style];
    [self changeNavigationBarStyleWith:style];
}

- (void)changeNavigationBarStyleWith:(navigationBarStyle)navigationBarStyle
{
    
    self.navigationBarStyle = navigationBarStyle;
    switch (navigationBarStyle) {
        case navigationBarClearWithNothing:
        {
            [self makeNavigationBarIntoClearStyle];
            self.navigationBar.hidden = NO;
        }
            break;
        case navigationBarWhiteWithBlackBackButton:
        {
            [self makeNavigationBarIntoWhiteStyle];
            self.navigationBar.hidden = NO;
            
            self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigation-back"];
            self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigation-back"];
        }
            break;
        case navigationBarClearWithBlackBackButton:
        {
            [self makeNavigationBarIntoClearStyle];
            self.navigationBar.hidden = NO;
            
            self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigation-back"];
            self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigation-back"];
        }
            break;
        case navigationBarClearWithImageBackButton:
        {
            [self makeNavigationBarIntoClearStyle];
            
            self.navigationBar.hidden = NO;
            self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigation-translateimage"];
            self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigation-translateimage"];
        }
            break;
        case navigationBarCustomStyle:
        {
            [self makeNavigationBarIntoCostomStyle:[[UIColor blackColor] colorWithAlphaComponent:0.4]];

            self.navigationBar.hidden = NO;
            self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigation-back"];
            self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigation-back"];
        }
            break;
            
        default:
            break;
    }
    
}

@end
