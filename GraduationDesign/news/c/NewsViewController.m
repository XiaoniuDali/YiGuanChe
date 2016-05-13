//
//  NewsViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/5/13.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "NewsViewController.h"
#import "appMarco.h"

@interface NewsViewController ()<UIWebViewDelegate>

@property(nonatomic,weak) UIWebView * webView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:IanMainScreen.bounds];
    
    
    UIWebView *viewWeb =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 48)];
    viewWeb.delegate =self;

    NSString *filePath = [[NSBundle mainBundle]pathForResource:_htmlName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    IanLog(@"%@",filePath);
    
    [viewWeb loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    self.webView =viewWeb;
    [self.view addSubview:self.webView];
    
  
}

@end
