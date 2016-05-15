//
//  NetworkManager.m
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import "SBJsonParser.h"

@interface NetworkManager ()

@property BOOL isTestMode;

@end

@implementation NetworkManager
// 线程安全单例
+ (NetworkManager*)shareMgr
{
    static NetworkManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[NetworkManager alloc] init];
        
        instance.isTestMode = ISINTEST;

    });
    
    return instance;
}



//#pragma mark --- 注册
//- (void)app_login_register:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString* strInterface;
//    
//    strInterface = APP_LOGIN_REGISTER;
//    
//    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if (completeHandle) {
//            
//            
//            completeHandle(responseObject);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (completeHandle) {
//            
//            
//            completeHandle(nil);
//        }
//        
//        NSLog(@"错误: %@", error);
//        
//    }];
//}


- (void)app_search_fine:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 这里服务器接口写死    
    [manager POST:[NSString stringWithFormat:@"%@",@"http://www.cheshouye.com/api/weizhang/query_task?"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (completeHandle) {
            
            
            completeHandle(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (completeHandle) {
            
            
            completeHandle(nil);
        }
        
        NSLog(@"错误: %@", error);
        
    }];
}

- (void)app_get_all_config:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 这里服务器接口写死

    [manager POST:[NSString stringWithFormat:@"%@",@"http://www.cheshouye.com/api/weizhang/get_all_config"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (completeHandle) {
            
            
            completeHandle(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (completeHandle) {
            
            
            completeHandle(nil);
        }
        
        NSLog(@"错误: %@", error);
        
    }];
}

- (void)app_search_VIN:(NSDictionary *)dic completeHandle:(CompleteHandle)completeHandle{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 这里服务器接口写死
    
//     http://apis.haoservice.com/efficient/vinservice?vin=LSGPC52U6AF102554&key=您申请的APPKEY
    
    [manager POST:[NSString stringWithFormat:@"%@",@"http://apis.haoservice.com/efficient/vinservice"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (completeHandle) {
            
            
            completeHandle(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (completeHandle) {
            
            
            completeHandle(nil);
        }
        
        NSLog(@"错误: %@", error);
        
    }];
    
}
- (void)app_search_DTC:(NSDictionary *)dic completeHandle:(CompleteHandle)completeHandle{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 这里服务器接口写死
    
    [manager POST:[NSString stringWithFormat:@"%@",@"http://getDTC.api.juhe.cn/CarManagerServer/getDTC"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (completeHandle) {
            
            
            completeHandle(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (completeHandle) {
            
            
            completeHandle(nil);
        }
        
        NSLog(@"错误: %@", error);
        
    }];
}
- (void)app_Search_AddOil:(NSDictionary *)dic completeHandle:(CompleteHandle)completeHandle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 这里服务器接口写死
    
    [manager POST:[NSString stringWithFormat:@"%@",@"http://apis.haoservice.com/oil/region"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (completeHandle) {
            
            
            completeHandle(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (completeHandle) {
            
            
            completeHandle(nil);
        }
        
        NSLog(@"错误: %@", error);
        
    }];
}
@end
