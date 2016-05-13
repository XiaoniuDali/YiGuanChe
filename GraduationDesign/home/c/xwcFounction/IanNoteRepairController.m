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

@property(nonatomic,weak) UIWebView * webView;
@property(nonatomic,weak) UIButton *addBtn;
@property(nonatomic,weak) UIButton *alterDataBtn;
@property(nonatomic,weak) UIButton *showDataBtn;
@property(nonatomic,weak) UITextView *noticeLbl;
@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,weak) UILabel * labelAllMoney;
@property (nonatomic,weak) UILabel * labelAllLast;
@property (nonatomic,weak) UILabel * labelLastName;

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
    return moneySum;
}

-(NSString *)getAllLastRepair
{
    NSString *lastRepair= @"";
    FMResultSet *set =[self.db executeQuery:@"select max(time) from repairNote"];
    while ([set next]) {
        lastRepair = [set stringForColumn:@"max(time)"];
    }
    if (!lastRepair) {
        lastRepair =@"没有记录";
    }
    return lastRepair;
}
 

-(void)setSubview
{
    //-------------------uiwebview----------------------------
    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, IanMainScreen.bounds.size.width,380)];
    _webView = webview;
    _webView.backgroundColor = [UIColor redColor];
    UIScrollView *temScrollView = [_webView.subviews objectAtIndex:0];
    temScrollView.scrollEnabled =NO;

    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"echarts" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    //    添加一条记录的按钮
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5-40, self.view.height-60, 80,42)];
    _addBtn =addBtn;


    [_addBtn setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
 
    
    [self.view addSubview:_addBtn];
    [_addBtn addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    展示所有的数据
    UIButton *showDataBtn= [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5-140, self.view.height-60, 80,42)];
    _showDataBtn = showDataBtn;
 
    [_showDataBtn setBackgroundImage:[UIImage imageNamed:@"show.png"] forState:UIControlStateNormal];
//    [_showDataBtn setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:_showDataBtn];
    [_showDataBtn addTarget:self action:@selector(showData) forControlEvents:UIControlEventTouchUpInside];
    //    修改数据
    UIButton * alterDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width*0.5+60, self.view.height-60, 80,42)];
    _alterDataBtn =alterDataBtn;
    
 
    [_alterDataBtn setBackgroundImage:[UIImage imageNamed:@"alert.png"] forState:UIControlStateNormal];
//    [_alterDataBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_alterDataBtn];
    [_alterDataBtn addTarget:self action:@selector(alterData) forControlEvents:UIControlEventTouchUpInside];
    
 
     UILabel * labelAllMoney =[[UILabel alloc] init];
    _labelAllMoney =labelAllMoney;
    
    [_labelAllMoney setFrame:CGRectMake((self.view.bounds.size.width - 170)*0.5, self.webView.height+30, 170, 25)];
    
//    从数据库获取所有的数据
    _labelAllMoney.font = [UIFont systemFontOfSize:12];
    _labelAllMoney.textAlignment =NSTextAlignmentCenter;
    [_labelAllMoney setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelAllMoney];
    
    
    UILabel * labelAllLast =[[UILabel alloc] init];
    _labelAllLast =labelAllLast;
    [_labelAllLast setFrame:CGRectMake(10, self.webView.height+5, 170, 25)];
    
    //    从数据库获取所有的数据
//    _labelAllLast.text =[NSString stringWithFormat:@"最近维修时间：%@",[self getAllLastRepair]];
    _labelAllLast.font = [UIFont systemFontOfSize:12];
    _labelAllLast.textAlignment =NSTextAlignmentCenter;
    [_labelAllLast setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelAllLast];
    
    
    
    UILabel *labelLastName =[[UILabel alloc] init];
    _labelLastName =labelLastName;
    [_labelLastName setFrame:CGRectMake(185, self.webView.height+5, 180, 30)];
    
    //    从数据库获取所有的数据
//    _labelLastName.text =[NSString stringWithFormat:@"最近保养项目：%@",[self getLastRepairName]];
    _labelLastName.font = [UIFont systemFontOfSize:12];
    _labelLastName.textAlignment =NSTextAlignmentCenter;
    [_labelLastName setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelLastName];
 
    
    
    UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repairTips"]];
    [imageView setFrame:CGRectMake(90, self.webView.height+55, 181, 26)];

 
    [self.view addSubview:imageView];
    

    
    UITextView * noticeLbl = [[UITextView alloc] initWithFrame:CGRectMake(5, imageView.frame.origin.y+26, self.view.width-10,125)];
    _noticeLbl =noticeLbl;
    
    [_noticeLbl setBackgroundColor:[UIColor whiteColor]];
    [_noticeLbl setTextAlignment:NSTextAlignmentLeft];
    _noticeLbl.editable =NO;
    [self.view addSubview:_noticeLbl];
    
    _noticeLbl.userInteractionEnabled =YES;
    [_noticeLbl setFont:[UIFont fontWithName:@"宋体" size:10]];

}


/**
从数据库中获取所有的维修记录  加以分析  并且返回保养维修提示
 */
-(NSString *)getRepairTips
{
    NSString * repairTips =@"暂无维修提示";
   if(![[self getTips] isEqualToString:@""])
   {
    return [self getTips];
   }else{
    return repairTips;
   }
}



// 获得所有需要检查的 提示
-(NSString *)getTips
{
    NSString * tips =@"";
    NSString * tip =@"";
    int index=1;
//    获得所有维修过的项目名称
 
    FMResultSet *set = [self.db executeQuery:@"SELECT * FROM repairNote a , (SELECT projectName, MAX(time) AS OperateTime FROM repairNote GROUP BY projectName ) b WHERE a.projectName = b.projectName AND a. time = b.OperateTime"];
    
    while ([set next]) {
        tip=[self getTipWithProjectName:[set stringForColumn:@"projectName"] lastTime:[set stringForColumn:@"time"] action:[set stringForColumn:@"action"]];
        if (![tip isEqual:@""]) {
            tips =[tips stringByAppendingString:[NSString stringWithFormat:@"%d、%@\n",index,tip] ];
            index +=1;
        }

    }
    
    
    
    return tips;
}
-(NSString *)getTipWithProjectName:(NSString *)projectName lastTime:(NSString *)lastTime action:(NSString *)action
{
    NSString *tip =@"";
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd"];
    NSDate *dateTime = [formatter dateFromString:lastTime];
    long interval = [[[NSDate alloc] init] timeIntervalSinceDate:dateTime] * 1000;
 
    IanLog(@"interval==%ld",interval);
    if ((interval >= 31536000000)&([action isEqual:@"检查"])) {
        tip = [NSString stringWithFormat:@"您在%@进行了%@的检查,距今已有12个月，根据汽车零部件维修保养周期，您应该立即检查%@是否能确保汽车能安全行驶。",lastTime,projectName,projectName];

    }else if((interval >= 31536000000)&([action isEqual:@"更换"])){
        tip = [NSString stringWithFormat:@"您在%@进行了%@的检查,距今已有12个月，根据汽车零部件维修保养周期，您应该立即更换%@，这样才能确保您的汽车能安全行驶。",lastTime,projectName,projectName];
    }
    return tip;
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

-(void)viewDidAppear:(BOOL)animated
{
    self.db = [self openDataBase];

    _labelAllLast.text =[NSString stringWithFormat:@"最近维修时间：%@",[self getAllLastRepair]];
    _labelLastName.text =[NSString stringWithFormat:@"最近保养项目：%@",[self getLastRepairName]];
    _labelAllMoney.text =[NSString stringWithFormat:@"保养费用累计：%.2f元",[self getAllMoneyFromDb]];
    _noticeLbl.text = [self getRepairTips];
   
    
    [_webView reload];
//    [self viewWillAppear:animated];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
 
    NSString *xDataValue =[self getXDataValue];

    NSString *yDataVaue =[self getYDataValue];
    NSString *setValueData =[NSString stringWithFormat:@"setData(%@,%@)",xDataValue,yDataVaue];
  
    //传值Y轴数据
    [_webView stringByEvaluatingJavaScriptFromString:setValueData];
 
}

/**
 获取所有的维修保养时间  并且转换成字符串
 */
-(NSString *)getXDataValue
{
    NSMutableArray *arr =[[NSMutableArray alloc] init];
    FMResultSet *result = [self.db executeQuery:@"select time from repairNote order by time"];
    while ([result next]) {
        [arr addObject:[result stringForColumn:@"time"]];
    }
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:arr options:kNilOptions error:nil];
    NSString *str = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    return str;
}


/**
 获取所有维修记录的money 并且转换成字符串
 */
-(NSString *)getYDataValue
{
    NSMutableArray *arr =[[NSMutableArray alloc] init];
    FMResultSet *result = [self.db executeQuery:@"select money from repairNote"];
    while ([result next]) {
        [arr addObject:[result stringForColumn:@"money"]];
    }
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:arr options:kNilOptions error:nil];
    NSString *str = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
  
    return str;
}

-(NSString*)getLastRepairName
{
    NSString *lastRepairName= @"";
    NSString *lastRepairAction=@"";
    FMResultSet *set =[self.db executeQuery:@"select max(projectName),max(action) from repairNote where time = (select max(time) from repairNote)"];
    while ([set next]) {
        lastRepairName = [set stringForColumn:@"max(projectName)"];
        lastRepairAction =[set stringForColumn:@"max(action)"];
    }
    
    NSString *repair =[lastRepairAction stringByAppendingString:lastRepairName];
    if (!repair) {
        repair =@"没有记录";
    }
    return repair;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.db close];
}



@end
