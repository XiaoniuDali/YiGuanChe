//
//  IanCarCheckInfoViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/5/8.
//  Copyright © 2016年 YJH. All rights reserved.
//
 
#import "IanCarCheckInfoViewController.h"
#import "appMarco.h"
#import "FMDatabase.h"

@interface IanCarCheckInfoViewController () <UIWebViewDelegate>
@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,strong) UIWebView * webView;

@end

@implementation IanCarCheckInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =IanMainScreen.bounds;
 
    self.title =@"汽车年检知识";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self setSubviews];
}


-(void)viewWillDisappear:(BOOL)animated
{
    
    
}

-(void)setSubviews
{
    _webView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, IanMainScreen.bounds.size.width, IanMainScreen.bounds.size.height)];
    [self.view addSubview:_webView];
    [_webView setBackgroundColor:[UIColor whiteColor]];
    
    UIScrollView *temScrollView = [_webView.subviews objectAtIndex:0];
    
    temScrollView.bounces=NO;
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"nianjian" ofType:@"html"];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
 
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    _webView.delegate =self;
    
    
    
    

    
}

-(void)setData
{
    
    
    
}
-(void)openDatabase
{
    NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName =[doc stringByAppendingPathComponent:@"appDb.sqlite"];
    FMDatabase *appDb =[FMDatabase databaseWithPath:fileName];
    IanLog(@"fileName==%@",fileName);
    
    if (![appDb open]) {
        NSLog(@"opne 失败");
    }else if ([appDb open])
    {
        IanLog(@"打开成功");
        self.db =appDb;
    }
    
}
-(void)closeDataBase
{
    [self.db close];
}

@end

