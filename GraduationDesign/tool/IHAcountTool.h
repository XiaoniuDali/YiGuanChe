//
//  IHAcountTool.h
//  IHGP
//
//  Created by 谢伟成 on 16/1/11.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@class IHAcount;
@interface IHAcountTool : NSObject
-(IHAcount *)acount;
+ (NSString *)md5HexDigest:(NSString*)password;
+ (void)showHUD:(NSString *)text andView:(UIView *)view;
+ (void)hideHUD;
+ (void)showDelyHUD:(NSString *)text andView:(UIView *)view;
@end
