//
//  appMarco.h
//  IHGP
//
//  Created by 谢伟成 on 16/1/11.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#ifndef IHGP_appMarco_h
#define IHGP_appMarco_h

/**部分常用的类扩展*/
#import "UIView+Extersion.h"
#import "NSString+Extension.h"
#import "UIWindow+Extension.h"

/**统一设置状态栏颜色为  [UIColor colorWithRed:59/256.0 green:86/256.0 blue:129/256.0 alpha:1.0]  */
/**调用了 setstatusBar这个方法*/
#define  SetStatusBarColor(viewController) [[UIApplication sharedApplication].keyWindow setStatusBar:viewController]



/**通知中心*/
#define IanDefaultNotificationCenter   [NSNotificationCenter defaultCenter]


/** 导航栏颜色*/
#define navigationBarColor ianRGBColor(89, 116, 178)


/**颜色*/
#define ianRGBColor(r,g,b) [UIColor colorWithRed:(r)/256.0 green:(g)/256.0 blue:(b)/256.0 alpha:1.0]

/**随机色*/
#define ianRandomColor ianRGBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))

#define  IanMainScreen [UIScreen mainScreen]
#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height
/**编译的时候时输出，运行在设备上的时候是nothing*/
#ifdef DEBUG
#define IanLog(...) NSLog(__VA_ARGS__)
#else
#define IanLog(...)
#endif

#endif
