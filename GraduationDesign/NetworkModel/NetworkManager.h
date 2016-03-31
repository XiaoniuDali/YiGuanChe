//
//  NetworkManager.h
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
// http://12,..

#import <Foundation/Foundation.h>
#import "NewworkConfig.h"
#import <MJExtension.h>
#import "MJRefresh.h"
#import <UIImageView+WebCache.h>
#import "MBProgressHUD.h"

@interface NetworkManager : NSObject

+ (NetworkManager*)shareMgr;


// 3.2注册
- (void)app_login_register:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle;

@end
