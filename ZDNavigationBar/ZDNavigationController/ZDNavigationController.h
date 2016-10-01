//
//  ZDNavigationController.h
//  ZDNavigationBar
//
//  Created by 赵丹 on 2016/10/1.
//  Copyright © 2016年 赵丹. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    navigationBarClearWithNothing = 0,
    navigationBarClearWithBlackBackButton,
    navigationBarWhiteWithBlackBackButton,
    navigationBarClearWithImageBackButton,
    navigationBarCustomStyle
}navigationBarStyle;


@interface ZDNavigationController : UINavigationController

@property (nonatomic, strong) CALayer *customLayer;

//修改导航条样式, 在push之前调用.
@property (nonatomic, assign) navigationBarStyle navigationBarStyle;

//修改导航栏中最底层的controller的导航条样式
- (void)changeBaseBarStyle:(navigationBarStyle)style;

@end
