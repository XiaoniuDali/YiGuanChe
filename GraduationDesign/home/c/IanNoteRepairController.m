//
//  IanNoteRepairController.m
//  IHGP
//
//  Created by 谢伟成 on 16/3/30.
//  Copyright © 2016年 谢伟成. All rights reserved.
//

#import "IanNoteRepairController.h"
#import "appMarco.h"
#import "IanAddRepairNoteViewController.h"

@interface IanNoteRepairController ()<UIWebViewDelegate>

@property(nonatomic,strong) UIWebView * webView;
@property(nonatomic,strong) UIButton *addBtn;
@property(nonatomic,strong) UIButton *alterDataBtn;
@property(nonatomic,strong) UIButton *showDataBtn;
@property(nonatomic,strong) UILabel *noticeLbl;




@end

@implementation IanNoteRepairController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =IanMainScreen.bounds;
    self.title =@"维修记录统计";
    [self.view setBackgroundColor:ianRGBColor(231, 231,231)];
    
    
    //设置子控件
    [self setSubview];
    
    
}

-(void)setSubview
{
    //-------------------uiwebview----------------------------
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,450)];
    _webView.backgroundColor = [UIColor redColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"echarts" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"htmlStringhtmlString%@",htmlString);
    
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    //    添加一条记录的按钮
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5-25, self.view.height-70, 50,50)];
    [_addBtn setBackgroundColor:ianRGBColor(255, 255, 255)];
    [_addBtn setTitle:@"增加" forState:UIControlStateNormal];
    
    [self.view addSubview:_addBtn];
    [_addBtn addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    展示数据
    _showDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5-90, self.view.height-60, 50,30)];
    [_showDataBtn setBackgroundColor:ianRGBColor(255, 255, 255)];
    [_showDataBtn setTitle:@"展示" forState:UIControlStateNormal];
    
    [self.view addSubview:_showDataBtn];
    [_showDataBtn addTarget:self action:@selector(showData) forControlEvents:UIControlEventTouchUpInside];
    
    //    修改数据
    _alterDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5+40, self.view.height-60, 50,30)];
    [_alterDataBtn setBackgroundColor:ianRGBColor(255, 255, 255)];
    [_alterDataBtn setTitle:@"修改" forState:UIControlStateNormal];
    
    [self.view addSubview:_alterDataBtn];
    [_alterDataBtn addTarget:self action:@selector(alterData) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label =[[UILabel alloc] init];
    [label setFrame:CGRectMake(self.view.width *0.5 - 50, self.webView.height+10, 100, 25)];
    label.text = @"维修提示";
    label.textAlignment =NSTextAlignmentCenter;
    [label setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:label];
    
    _noticeLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+27, self.view.width,95)];
    
    [_noticeLbl setBackgroundColor:[UIColor blueColor]];
    _noticeLbl.text =@"根据维修保养记录的数据，显示一些提示消息";
    _noticeLbl.userInteractionEnabled =NO;
    [_noticeLbl setFont:[UIFont fontWithName:@"宋体" size:15]];
    
    
    [self.view addSubview:_noticeLbl];

    
    
    
    
    
}

//添加维修记录
-(void)addNote
{
    IanLog(@"添加一条记录");
    self.hidesBottomBarWhenPushed=YES;
    IanAddRepairNoteViewController *addVC =[[IanAddRepairNoteViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}
//展示所有的维修记录
-(void)showData
{
    IanLog(@"showData");
}
//修改之前的维修记录
-(void)alterData
{
    IanLog(@"alterData");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    NSString *xDataValue =@"[\"衬衫\",\"羊毛衫\",\"雪纺衫\",\"裤子\",\"高跟鞋\",\"袜子\"]";
    NSString *yDataVaue =@"[5, 20, 36, 10, 10, 20]";
    NSString *setValueData =[NSString stringWithFormat:@"setData(%@,%@)",xDataValue,yDataVaue];
    
    
    //传值Y轴数据
    [_webView stringByEvaluatingJavaScriptFromString:setValueData];
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad======webViewDidStartLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
