//
//  IanTabBar.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/14.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import "IanTabBar.h"
#import "UIView+Extersion.h"

@implementation IanTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    /**设置输出的tab按钮的位置*/
    CGFloat tabBarBtnW =100;
    CGFloat margin =37;
    int i =0;
    for (UIView *view in self.subviews) {  /**获得父类中的所有的view对象*/
        Class class =NSClassFromString(@"UITabBarButton");
        if ([view class] == class) {      /**判断是不是uitabbarbutton*/
//            [view setBackgroundColor:[UIColor redColor]];
            view.x =i *(margin +tabBarBtnW);
            view.y =0;
            view.width =tabBarBtnW;
            view.height =48;
            i ++;
        }
    }
    
}


@end
