//
//  NSString+Extension.m
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/12/15.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[NSFontAttributeName]=font;
    CGSize maxSize =CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

-(CGSize)sizeWithFont:(UIFont *)font
{
    CGSize size =[self sizeWithFont:font maxW:MAXFLOAT];
    return size;
}

@end
