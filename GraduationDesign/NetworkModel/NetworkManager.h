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


//// 3.2注册
//- (void)app_login_register:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle;



// 违章查询
- (void)app_search_fine:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle;
// 城市ID查询
- (void)app_get_all_config:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle;
// vin查询
- (void)app_search_VIN:(NSDictionary *)dic completeHandle:(CompleteHandle)completeHandle;
// DTC查询
- (void)app_search_DTC:(NSDictionary *)dic completeHandle:(CompleteHandle)completeHandle;
// 汽车加油站周边查询
- (void)app_Search_AddOil:(NSDictionary *)dic completeHandle:(CompleteHandle)completeHandle;
@end
