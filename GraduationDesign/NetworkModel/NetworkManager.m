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



#pragma mark --- 注册
- (void)app_login_register:(NSDictionary *)dic CompleteHandle:(CompleteHandle)completeHandle {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString* strInterface;
    
    strInterface = APP_LOGIN_REGISTER;
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,strInterface] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
