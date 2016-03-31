//
//  IanNavigationController.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/12.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import "IanNavigationController.h"
#import "appMarco.h"
#import "IanNavigationBar.h"

@interface IanNavigationController ()

@end

@implementation IanNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//   设置状态栏的颜色

    
//   使用自定义tabbar
    IanNavigationBar *tabbar =[[IanNavigationBar alloc] init];
    [self setValue:tabbar forKey:@"navigationBar"];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


@end
