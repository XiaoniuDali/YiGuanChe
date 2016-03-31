//
//  UITextView+Extension.m
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/12/25.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributedString:(NSAttributedString *)attributedString settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedStr =[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [attributedStr insertAttributedString:attributedString atIndex:self.selectedRange.location];
    
   
    [attributedStr replaceCharactersInRange:self.selectedRange withString:@""];
    
    if (settingBlock) {
        settingBlock(attributedStr);
    }
    NSRange range =self.selectedRange;
    self.attributedText =attributedStr;
    /*    设置在插入图片后将光标设置在图片之后    */
    self.selectedRange =(NSRange){range.location+1,0};
}


+(NSString *)fullTextFromAttachment:(NSTextAttachment *)attachment
{
    
    return @"[hdhdhd]";
}
@end
