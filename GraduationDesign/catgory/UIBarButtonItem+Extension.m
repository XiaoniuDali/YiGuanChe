//
//  UIBarButtonItem+Extension.m
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/11/30.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "appMarco.h"
@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image imageSelected:(NSString *)imageSelected
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageSelected] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}
@end
