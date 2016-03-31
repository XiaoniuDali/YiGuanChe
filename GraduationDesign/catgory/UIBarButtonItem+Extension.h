//
//  UIBarButtonItem+Extension.h
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/11/30.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image imageSelected:(NSString *)imageSelected;
@end
