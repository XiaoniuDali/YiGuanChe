//
//  UITextView+Extension.h
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/12/25.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
/**将带有属性的string插入到self.attributedstring中*/
-(void)insertAttributedString:(NSAttributedString *)attributedString settingBlock:(void(^)(NSMutableAttributedString * attributedString))settingBlock;

/**将nstextAttributedstring转换为文字*/
+(NSString *)fullTextFromAttachment:(NSTextAttachment *)attachment;

@end
