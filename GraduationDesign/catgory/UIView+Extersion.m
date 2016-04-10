//
//  UIView+Extersion.m
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/11/29.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import "UIView+Extersion.h"

@implementation UIView (Extersion)

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame =frame;
}
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame =frame;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center =center;
}
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center =center;
}


-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame =frame;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame =frame;
}

//-(CGFloat)centerX
//{
//    return self.centerX;
//}

//-(CGFloat)centerY
//{
//    return self.centerY;
//}


-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame =frame;
}



-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(CGSize)size
{
    return self.frame.size;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)height
{
    return self.frame.size.height;
}





@end
