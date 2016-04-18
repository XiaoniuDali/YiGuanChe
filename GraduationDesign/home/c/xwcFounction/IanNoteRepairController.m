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
#import "IanShowRepairNoteViewController.h"
#import "IanAlterNoteViewController.h"
#import "FMDatabase.h"

@interface IanNoteRepairController ()<UIWebViewDelegate>

@property(nonatomic,strong) UIWebView * webView;
@property(nonatomic,strong) UIButton *addBtn;
@property(nonatomic,strong) UIButton *alterDataBtn;
@property(nonatomic,strong) UIButton *showDataBtn;
@property(nonatomic,strong) UITextView *noticeLbl;
@property (nonatomic,strong) FMDatabase * db;

@end

@implementation IanNoteRepairController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =IanMainScreen.bounds;
    self.title =@"维修记录统计";
    [self.view setBackgroundColor:ianRGBColor(231, 231,231)];
    
    self.db = [self openDataBase];
    
    
    
    //设置子控件
    [self setSubview];
}


#pragma -mark 打开数据库
-(FMDatabase *)openDataBase
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
    }
    return appDb;
}

-(float)getAllMoneyFromDb
{
    float moneySum =0;
    FMResultSet *set =[self.db executeQuery:@"SELECT money FROM repairNote"];
    while ([set next]) {
        NSString *moneyStr = [set stringForColumn:@"money"];
        float moneyFloat = [moneyStr floatValue];
        moneySum +=moneyFloat;
        
    }
    IanLog(@"moneySum===%f",moneySum);
    return moneySum;
    
}

-(NSString *)getAllLastRepair
{
    NSString *lastRepair= @"";
    FMResultSet *set =[self.db executeQuery:@"select max(time) from repairNote"];
    while ([set next]) {
        lastRepair = [set stringForColumn:@"max(time)"];
    }
    return lastRepair;
}



-(void)setSubview
{
    //-------------------uiwebview----------------------------
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,380)];
    _webView.backgroundColor = [UIColor redColor];
    UIScrollView *temScrollView = [_webView.subviews objectAtIndex:0];
    temScrollView.scrollEnabled =NO;

    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"echarts" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"htmlStringhtmlString%@",htmlString);
    
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    //    添加一条记录的按钮
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5-25, self.view.height-70, 50,50)];
    [_addBtn setBackgroundColor:ianRGBColor(255, 255, 255)];
//    [_addBtn setTitle:@"增加" forState:UIControlStateNormal];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"addRepairNote.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:_addBtn];
    [_addBtn addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    展示所有的数据
    _showDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5-90, self.view.height-60, 50,30)];
    [_showDataBtn setBackgroundColor:ianRGBColor(255, 255, 255)];
//    [_showDataBtn setTitle:@"展示" forState:UIControlStateNormal];
    [_showDataBtn setBackgroundImage:[UIImage imageNamed:@"showData.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:_showDataBtn];
    [_showDataBtn addTarget:self action:@selector(showData) forControlEvents:UIControlEventTouchUpInside];
    //    修改数据
    _alterDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5+40, self.view.height-60, 50,30)];
    [_alterDataBtn setBackgroundColor:ianRGBColor(255, 255, 255)];
    [_alterDataBtn setTitle:@"修改" forState:UIControlStateNormal];
    [self.view addSubview:_alterDataBtn];
    [_alterDataBtn addTarget:self action:@selector(alterData) forControlEvents:UIControlEventTouchUpInside];
    
 
    UILabel *labelAllMoney =[[UILabel alloc] init];
    [labelAllMoney setFrame:CGRectMake(25, self.webView.height+15, 100, 30)];
    
//    从数据库获取所有的数据
    labelAllMoney.text =[NSString stringWithFormat:@"费用累计：%f",[self getAllMoneyFromDb]];
    labelAllMoney.font = [UIFont systemFontOfSize:12];
    labelAllMoney.textAlignment =NSTextAlignmentCenter;
    [labelAllMoney setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:labelAllMoney];
    
    
    
    UILabel *labelAllLast =[[UILabel alloc] init];
    [labelAllLast setFrame:CGRectMake(150, self.webView.height+15, 180, 30)];
    
    //    从数据库获取所有的数据
    labelAllLast.text =[NSString stringWithFormat:@"上次维修时间：%@",[self getAllLastRepair]];
    labelAllLast.font = [UIFont systemFontOfSize:12];
    labelAllLast.textAlignment =NSTextAlignmentCenter;
    [labelAllLast setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:labelAllLast];
    
    
    
    UILabel *label =[[UILabel alloc] init];
    [label setFrame:CGRectMake(self.view.width *0.5 - 50, self.webView.height+70, 100, 30)];
    label.text = @"维修提示";
    label.textAlignment =NSTextAlignmentCenter;
    [label setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:label];
    

    
    _noticeLbl = [[UITextView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+27, self.view.width,95)];
    
    
    [_noticeLbl setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_noticeLbl];
    _noticeLbl.text =@"根据维修保养记录的数据，根据维修保养记录的数据根据维修保养记录的数据根据维根据维修保养记录的数据根据维修保养记录的数据根据维根据维修保养记录的数据根据维修保养记录的数据根据维根据维修保养记录的数据根据维修保养记录的数据根据维根据维修保养记录的数据根据维修保养记录的数据根据维根据维修保养记录的数据根据维修保养记录的数据根据维修保养记录的数据根据维修保养记录的数据根据维修保养记录的数据显示一些asdfasdfasdfasdfasdfasdfasdfasdfaskdhdfjkashlkdjfajjkkjasd提示消息";
    _noticeLbl.userInteractionEnabled =NO;
    [_noticeLbl setFont:[UIFont fontWithName:@"宋体" size:10]];

    
    
    
    
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
    IanShowRepairNoteViewController * showDataViewC =[[IanShowRepairNoteViewController alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:showDataViewC animated:YES];
    
    IanLog(@"showData");

}
//修改之前的维修记录
-(void)alterData
{
    IanAlterNoteViewController * alterDataViewC =[[IanAlterNoteViewController alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:alterDataViewC animated:YES];
    IanLog(@"showData");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    NSString *xDataValue =@"[\"2012-02-14\",\"2012-02-14\",\"2012-02-14\",\"2013-02-10\",\"2014-01-05\",\"2015-01-05\",\"2016-01-08\",\"2016-02-08\"]";
    NSString *yDataVaue =@"[500, 500, 500, 200, 360, 100, 210, 220]";
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
