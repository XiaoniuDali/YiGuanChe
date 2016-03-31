//
//  NSString+Extension.h
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/12/15.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
-(CGSize)sizeWithFont:(UIFont *)font;
@end
