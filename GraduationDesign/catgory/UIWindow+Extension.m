//
//  UIWindow+Extension.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/13.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "appMarco.h"


@implementation UIWindow (Extension)

-(void)setStatusBar:(UIViewController *)controller
{
    UIView *statusBarView =[[UIView alloc] init];
    statusBarView.frame =CGRectMake(0, 0, 375, 20);
    [statusBarView setBackgroundColor:[UIColor colorWithRed:59/256.0 green:86/256.0 blue:129/256.0 alpha:1.0]];
    [controller.view addSubview:statusBarView];
}

@end
