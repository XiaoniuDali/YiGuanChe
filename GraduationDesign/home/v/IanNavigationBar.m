//
//  IanNavigationBar.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/12.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import "IanNavigationBar.h"
#import "appMarco.h"
@implementation IanNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
   self =[super initWithFrame:frame];
    if (self) {
//      设置导航栏背景颜色
            self.barTintColor =ianRGBColor(89, 116, 178);
        
//      字体颜色
            NSMutableDictionary *dict =[NSMutableDictionary dictionary];
            dict[NSForegroundColorAttributeName] =[UIColor whiteColor];
            [self setTitleTextAttributes:dict];
//        使用view来显示状态栏的颜色
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, -20, 375, 20)];
        [view setBackgroundColor:ianRGBColor(59, 86, 129)];
        [self addSubview:view];
    
        
    }
    return self;
}

 
@end
