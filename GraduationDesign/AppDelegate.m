//
//  AppDelegate.m
//  GraduationDesign
//
//  Created by shupengstar on 16/3/30.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchRoot.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 不用版本检测更新，苹果自动会检测
    self.window.rootViewController = [LaunchRoot new];
    // Override point for customization after application launch.
//http://yqall02.baidupcs.com/file/7d02e1857998cdedb6e07d79b5b285c6?bkt=p3-14007d02e1857998cdedb6e07d79b5b285c6807137f90000000af000&fid=3324609554-250528-1025660187472971&time=1462262563&sign=FDTAXGERLBH-DCb740ccc5511e5e8fedcff06b081203-3m4lkGZdO%2FAd13mktwaLhUdBu%2Bw%3D&to=qyac&fm=Yan,B,U,nc&sta_dx=1&sta_cs=0&sta_ft=sqlite&sta_ct=0&fm2=Yangquan,B,U,nc&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=14007d02e1857998cdedb6e07d79b5b285c6807137f90000000af000&sl=76480591&expires=8h&rt=pr&r=776002054&mlogid=2868223112067269884&vuk=3324609554&vbdid=2338314477&fin=appDb.sqlite&slt=pm&uta=0&rtype=1&iv=0&isw=0&dp-logid=2868223112067269884&dp-callid=0.1.1
    
    [self downFiles];
    return YES;
}
- (void)downFiles{
//    NSString *urlStr = @"http://yqall02.baidupcs.com/file/7d02e1857998cdedb6e07d79b5b285c6?bkt=p3-14007d02e1857998cdedb6e07d79b5b285c6807137f90000000af000&fid=3324609554-250528-1025660187472971&time=1462262563&sign=FDTAXGERLBH-DCb740ccc5511e5e8fedcff06b081203-3m4lkGZdO%2FAd13mktwaLhUdBu%2Bw%3D&to=qyac&fm=Yan,B,U,nc&sta_dx=1&sta_cs=0&sta_ft=sqlite&sta_ct=0&fm2=Yangquan,B,U,nc&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=14007d02e1857998cdedb6e07d79b5b285c6807137f90000000af000&sl=76480591&expires=8h&rt=pr&r=776002054&mlogid=2868223112067269884&vuk=3324609554&vbdid=2338314477&fin=appDb.sqlite&slt=pm&uta=0&rtype=1&iv=0&isw=0&dp-logid=2868223112067269884&dp-callid=0.1.1";
//
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!error) {
//            
//            NSError *saveError;
//            NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//            
//            NSString *fileName =[doc stringByAppendingPathComponent:@"appDb.sqlite"];
//            NSURL *saveUrl = [NSURL fileURLWithPath:fileName];
//            
////            [[NSFileManager defaultManager] removeItemAtURL:location error:&saveError];
////            
////            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
//            
//            if (!saveError) {
//                NSLog(@"成功");
//            }else {
//                NSLog(@"error");
//            }
//            
//        }else {
//            NSLog(@"错误");
//        }
//    }];
//    [downloadTask resume];
//    
//    
    
    NSString *urlAsString = @"http://yqall02.baidupcs.com/file/df4794ee0e852bbda535536dad1e728a?bkt=p3-1400df4794ee0e852bbda535536dad1e728a630285e30000000b8000&fid=3324609554-250528-761321753585071&time=1463215271&sign=FDTAXGERLBH-DCb740ccc5511e5e8fedcff06b081203-ffKhEGBqn%2FpVP7q9sQJ3psE78xU%3D&to=qyac&fm=Yan,B,U,nc&sta_dx=1&sta_cs=0&sta_ft=sqlite&sta_ct=0&fm2=Yangquan,B,U,nc&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=1400df4794ee0e852bbda535536dad1e728a630285e30000000b8000&sl=76480590&expires=8h&rt=pr&r=371452463&mlogid=3123963536427525852&vuk=3324609554&vbdid=960311854&fin=appDb.sqlite&slt=pm&uta=0&rtype=1&iv=0&isw=0&dp-logid=3123963536427525852&dp-callid=0.1.1";
    NSURL    *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData   *data = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:nil
                                                       error:&error];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        
//    }];
    
    NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *fileName =[doc stringByAppendingPathComponent:@"appDb.sqlite"];
    
    /* 下载的数据 */
    if (data != nil){
        NSLog(@"下载成功");
        if ([data writeToFile:fileName atomically:YES]) {
            NSLog(@"保存成功.");
        }
        else
        {
            NSLog(@"保存失败.");
        }
    } else {
        NSLog(@"%@", error);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
