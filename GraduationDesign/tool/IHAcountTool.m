//
//  IHAcountTool.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/11.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import "IHAcountTool.h"
#import "IHAcount.h"
#import <CommonCrypto/CommonDigest.h>

@implementation IHAcountTool

-(IHAcount *)acount
{
    IHAcount *acount =[[IHAcount alloc] init];
    return acount;
}
#pragma mark --- MBProgressHUD单例
+(MBProgressHUD * )share
{
    static dispatch_once_t pred;
    static MBProgressHUD *current;
    dispatch_once(&pred, ^{
        current = [[MBProgressHUD alloc] init];
    });
    return current;
}
#pragma mark --- md5加密
+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    
    NSLog(@"Encryption Result = %@",mdfiveString);
    return mdfiveString;
}
#pragma mark --- 显示hud
+ (void)showHUD:(NSString *)text andView:(UIView *)view
{
    
    [view addSubview:[self share]];
    [self share].labelText = text;//显示提示
    [self share].dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    [self share].square = YES;//设置显示框的高度和宽度一样
    [[self share] show:YES];
}
+ (void)hideHUD{
    [[self share] hide:YES];
}
#pragma mark --- 延迟消失hud
+ (void)showDelyHUD:(NSString *)text andView:(UIView *)view{
    
    [self showHUD:text andView:view];
    // 几秒后消失,当然，这里可以改为网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 移除HUD
        [self hideHUD];
        
    });
}
@end
