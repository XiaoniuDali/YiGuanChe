//
//  LaunchRoot.m
//  YiGuanChe
//
//  Created by yihuan on 2/21/16.
//  Copyright © 2016 YiGuanChe. All rights reserved.
//

#import "LaunchRoot.h"
#import "CustomTabBarController.h"
#import "IanLoginViewController.h"
#import "IanNavigationController.h"
#import "IHAcountTool.h"
#define PageNumberOfScrollView 3
@interface LaunchRoot ()<UIScrollViewDelegate,NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSMutableArray *arrayImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *btnStart;
@property (nonatomic, strong) NSURLSession *sessons;
@property (nonatomic, strong) NSURLSessionDownloadTask *downLoadTask;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation LaunchRoot
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    }
    return _scrollView;
}
- (NSMutableArray *)arrayImageView{
    if (!_arrayImageView) {
        _arrayImageView = [NSMutableArray array];
    }
    return _arrayImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 一个唯一标示 strFlag
    NSString* strFlag = [NSString stringWithFormat:@"isFirstStartWithVersion_%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    
    // 第一次strFlage不等于YES进入else。以后都进入if
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:strFlag] isEqualToString:@"YES"]) {
        
        [self performSelector:@selector(goToMainUI) withObject:nil afterDelay:0.1];
        
    }else{
        // 第一次使用
        NSLog(@"test");
        [self downFiles];
        
        [self addImages];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:strFlag];
    }
}
- (void)downFiles{
    
//    [IHAcountTool showHUD:@"" andView:self.view];
    
    
    NSString *urlAsString = @"http://sz.ctfs.ftn.qq.com/ftn_handler/aa55bbe77e1a7cc840504c80570c3ef2e8ff45ddfee2da262e8ad3563e60c0547a12c1c42f8e130a21709233b383708cdbea7a320594db4665bd12f7c4fe5ef5/?fname=appDb.sqlite&k=7436363464e1c39a7e0d2f674261054a560603565559045218030f51544c035d06071b565c0556480c0007500155065007550403646d3704454672564a1246095c42533459&fr=00&&txf_fid=54715fa3e9600fabc1c8e23e321b8da3164725b6&xffz=753664";
//    NSString *urlAsString = nil;
    
    NSURL    *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //初始sesson化配置对象
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //初始化sesson
    self.sessons = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //创建下载任务
    self.downLoadTask = [self.sessons downloadTaskWithRequest:request];
    [self.downLoadTask resume];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
   
    NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName =[doc stringByAppendingPathComponent:@"appDb.sqlite"];
    
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager moveItemAtPath:location.path toPath:fileName error:nil];

    [IHAcountTool showDelyHUD:@"正在初始化数据" andView:self.view];
    
}
- (void)goToMainUI
{
    // 如果获取不到用户信息，则跳到登录界面
    
    NSArray *allModel = [vinModel findAll];
    
    if (allModel.count == 0) {
        
//        [self gotoLogin];
        
        CustomTabBarController *tab =[[CustomTabBarController alloc ] init];
        
        [tab.view setFrame:self.view.bounds];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        window.rootViewController =tab;
        
        [window makeKeyAndVisible];
    } else {
        
        for (int i = 0; i<allModel.count; i++) {
            vinModel *haveModel =allModel[i];
            if (haveModel.telephone.length != 0 || haveModel.password.length != 0) {
                
                CustomTabBarController *tab =[[CustomTabBarController alloc ] init];
                
                [tab.view setFrame:self.view.bounds];
                
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                
                window.rootViewController =tab;
                
                [window makeKeyAndVisible];
                
            } else {
                
                [self gotoLogin];
            }
        }
        
    }
}
#pragma mark --- 跳转到登陆界面
- (void)gotoLogin{
    
    UIWindow *window =     [UIApplication sharedApplication].keyWindow;
    
    IanNavigationController *nav=[[IanNavigationController alloc]init];
    
    IanLoginViewController *login =[[IanLoginViewController alloc ] init];
    
    [nav addChildViewController:login];
    
    window.rootViewController =nav;
    
    [window makeKeyAndVisible];
    
    [self.navigationController pushViewController:login animated:YES];
}
- (void)addImages
{
    // 滚动图片
    self.arrayImageView = [[NSMutableArray alloc] init];
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    CGSize scrollSize;
    
    scrollSize.height = self.view.frame.size.height;
    scrollSize.width  = PageNumberOfScrollView*self.view.frame.size.width;
    
    self.scrollView.contentSize =  scrollSize;
    self.scrollView.bounces = NO;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.5*(self.view.frame.size.width -120),self.view.frame.size.height - 60, 120, 30)];
    self.pageControl.numberOfPages = PageNumberOfScrollView;
    [self.pageControl addTarget:self action:@selector(goPage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.pageControl];
    
    self.pageControl.hidden = YES;
    
    for (int i = 0; i < PageNumberOfScrollView; i++) {
        
        NSLog(@"11");
        
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"ecar%d.jpg",i + 1]];
        
        UIImageView*  imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width,0,self.view.frame.size.width,self.view.frame.size.height)];
        
        imageView.image = image;
        
        NSLog(@"imageView = %@",NSStringFromCGRect(imageView.frame));
        
        [self.scrollView addSubview:imageView];
        
        [self.arrayImageView addObject:imageView];
        
        
        //        if (i == PageNumberOfScrollView - 1) {
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //            btn.backgroundColor = [UIColor redColor];
        //            [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        //            [btn setTitle:@"点击进入" forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(self.view.frame.size.width*0.5 - 80, self.view.frame.size.height*0.8 - 10 , 160, 50);
        
        
        btn.userInteractionEnabled = YES;
        [btn addTarget:self action:@selector(goMain:) forControlEvents:UIControlEventTouchUpInside ]; // 上面的按钮是直接写上去的。
        
        [imageView addSubview:btn];
        
        //            self.btnStart = btn;
        
        [imageView addSubview:btn];
        
        imageView.userInteractionEnabled = YES;
        //        }
        
    }
}

- (void)goMain:(UIButton*)btn
{
    NSLog(@"2sda");
    
    [UIView animateWithDuration:1  delay:0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         //                         self.scrollView.hidden = YES;
                         //                         [self.scrollView removeFromSuperview];
                         self.scrollView.alpha = 0.0;
                         [self.pageControl removeFromSuperview];
                         
                         [self performSelector:@selector(goToMainUI) withObject:nil afterDelay:0.1];
                         
                         //                         GCLoginViewController* vc = [[GCLoginViewController alloc] initWithNibName:@"GCLoginViewController" bundle:nil];
                         //
                         //                         [self presentViewController:vc animated:YES completion:nil];
                         
                         //                         [self.view addSubview:tab.view];
                         
                     } completion:^(BOOL finished){}];
    
}

#pragma scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        
        self.pageControl.currentPage = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
    }
}

- (void)goPage:(UIPageControl*)pageCtrl
{
    [self.scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width*pageCtrl.currentPage, 0, self.scrollView.frame.size.height, self.scrollView.frame.size.height) animated:YES];
    
}

@end
