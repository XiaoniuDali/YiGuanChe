//
//  CustomTabBarController.m
//  YiGuanChe
//
//  Created by yihuan on 1/17/16.
//  Copyright © 2016 YiGuanChe. All rights reserved.
//

#import "CustomTabBarController.h"
#import "IHSettingViewController.h"
#import "IHNewsViewController.h"
#import "IanNavigationController.h"
#import "IanMainViewController.h"
#import <Masonry.h>
@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewConntrol];
}
- (void)setViewConntrol{
    IanMainViewController *mainVC =[[IanMainViewController alloc] init];
    [self addChildVCWithVC:mainVC image:@"tabbar_home" selectedImage:@"tabbar_home_selected" title:@"首页"];
    
    IHNewsViewController *newsVC =[[IHNewsViewController alloc] init];
    [self addChildVCWithVC:newsVC image:@"tabbar_news" selectedImage:@"tabbar_news_selected" title:@"资讯"];
    
    
    IHSettingViewController *settingVC =[[IHSettingViewController alloc] init];
    [self addChildVCWithVC:settingVC image:@"tabbar_setting" selectedImage:@"tabbar_setting_selected" title:@"设置"];
    
    self.tabBar.translucent = NO;
}
/**
 添加不同的功能模块控制器
 */
-(void)addChildVCWithVC:(UIViewController *)childVC image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    // 利用系统的tabBarItem,为每一个控制器设置title,image,选中状态。
    childVC.title =title;
    childVC.tabBarItem.image =[UIImage imageNamed:image];
    
    NSMutableDictionary *dictAttrNormal =[NSMutableDictionary dictionary];
    [childVC.tabBarItem setTitleTextAttributes:dictAttrNormal forState:UIControlStateNormal];
    
    NSMutableDictionary *dictSelctedAttr =[NSMutableDictionary dictionary];
    childVC.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dictSelctedAttr[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:dictSelctedAttr forState:UIControlStateHighlighted];

    // 导航控制器
    IanNavigationController *nav =[[IanNavigationController alloc] initWithRootViewController:childVC];
    
    // 放到导航控制器中。
    [self addChildViewController:nav];
    
}
@end
