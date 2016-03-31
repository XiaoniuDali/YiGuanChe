//
//  NewworkConfig.h
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#ifndef GSAPP_NewworkConfig_h
#define GSAPP_NewworkConfig_h

#define NETWORKE_CODE_SUCCESS  2000000


#define SERVER @"http://112.74.84.69:8082/"

#define ISINTEST  NO

#pragma mark - 网络接口回调类型
typedef void (^CompleteHandle)(NSDictionary*);
typedef void (^ErrorHandle)(NSError*);

#pragma mark - 网络相关url

//登陆注册部分

#define APP_LOGIN_REGISTER @"rubbish/app_login/register"

#endif
