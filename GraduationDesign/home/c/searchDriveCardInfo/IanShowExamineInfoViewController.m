//
//  IanShowExamineInfoViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/5/3.
//  Copyright © 2016年 YJH. All rights reserved.
//


/*
 4、从2012年5.1国际劳动节开始，各类大型客车、中型客车、大型货车(A1,A2,B1,B2)等驾驶证人或校车工作人员的驾驶证年审由原来的两年一审，改为一年一审。初次领证日期在驾驶证正证上有，提交体检表车管所不收任何费用。如果说是其它证，只要遵守交规，每个记分周期（一般是从你初次领驾驶证的日期算起12个月内）交通违法记分都不满12分（只要不满12分，下一个记分周期自动归零）, （但是要按时换证，到期前90天内都可以换，过期1年之后将会被注销） 现在换证手续简单。带上你的身份证，驾驶证，一寸白底彩色照片4张，体检表到当地车管所办理就可以了，北京收费是体检10元换证10元。
 
 ﻿
 
 4.1、驾照年审所需资料：提供驾驶证副本原件、身份证、机动车驾驶员身体条件证明
 
 1、持有准驾车型为A、B、N、P驾驶证的驾驶员，准驾车型为C并从事营业性运输的驾驶员，以及年龄超过60周岁的驾驶员，每年年审一次。
 
 2、持有其他准驾车型驾驶证的，每两年年审一次。
 3、年审期限以驾驶证《副证》年审有效期为准，逾期未审的驾驶员要接受100元的处罚。
 
 */

#import "IanShowExamineInfoViewController.h"
#import "appMarco.h"
#import "FMDatabase.h"

@interface IanShowExamineInfoViewController ()
@property (nonatomic,strong) UITextView *noteTextView;
@property (nonatomic,strong) UIWebView * driveCardProgramWebView;
@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,strong) FMResultSet * set;

@property (nonatomic,strong) NSString * signSite;
@property (nonatomic,strong) NSString * signTime;
@property (nonatomic,strong) NSString * carType;
@property (nonatomic,strong) NSString * validTime;
@property (nonatomic,strong) NSString * practiceTime;
@property (nonatomic,strong) NSString * driveCardId;



@end

@implementation IanShowExamineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =IanMainScreen.bounds;
    
    
    self.title =@"驾照年审提醒";
    [self.view setBackgroundColor:ianRGBColor(231, 231,231)];
    
    [self openDatabase];
    
    
    [self setSubviews];
    
 
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self closeDataBase];
    
    _noteTextView =nil;

    _set =nil;
    
    _signSite =nil;
    _signTime =nil;
    _carType =nil;
    _validTime =nil;
    _practiceTime=nil;
    _driveCardId=nil;
    
    
    
}

-(void)setSubviews
{
    UITextView * noteTextview =[[UITextView alloc] init];
    noteTextview.frame =CGRectMake(0, 0, self.view.width, 200);
    _noteTextView =noteTextview;

//    [_noteTextView setBackgroundColor:ianRGBColor(231, 231,231)];
    
    [_noteTextView setBackgroundColor:[UIColor whiteColor]];
    [_noteTextView setTextAlignment:NSTextAlignmentLeft];
    _noteTextView.editable =NO;
    [self.view addSubview:_noteTextView];
    
    _noteTextView.userInteractionEnabled =YES;
    [_noteTextView setFont:[UIFont fontWithName:@"宋体" size:10]];
    
    [self.view addSubview:_noteTextView];
    

    self.driveCardProgramWebView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 200, self.view.width, self.view.height-200)];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"jiaZhaoNianShen" ofType:@"html"];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [self.driveCardProgramWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    UIScrollView *temScrollView = [self.driveCardProgramWebView.subviews objectAtIndex:0];
 
    temScrollView.bounces=NO;
    
    [self.view addSubview:self.driveCardProgramWebView];
    
    
    
    
    
    
    
    [self setData];
}

-(void)setData
{
   
    
    FMResultSet *  set = [self.db executeQuery:@"SELECT signSite,signTime,carType,validTime,practiceTime,driveCardId from driveCardInfo"];
    while ([set next]) {
 
    _signSite =[set stringForColumn:@"signSite"];
    _signTime =[set stringForColumn:@"signTime"];
    _carType =[set stringForColumn:@"carType"];
    _validTime =[set stringForColumn:@"validTime"];
    _practiceTime =[set stringForColumn:@"practiceTime"];
    _driveCardId =[set stringForColumn:@"driveCardId"];
    
        
     }
 
    
    _noteTextView.text =[self signTimeAnalysis];
 
    
}



-(NSString *)signTimeAnalysis
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    //有效期
    NSDate *valiDate=[formatter dateFromString:_validTime];
  
    // 从  领取驾驶证的时间中  获取那个月之前需要进行年
    NSDate *signDate=[formatter dateFromString:_signTime];
    
  
    // 获取今天的时间
    NSDate * nowDate =[[NSDate alloc] init];
    
  
    //如果过期  就返回  已经过期，在一年内  去年审
    if ([valiDate compare:nowDate]== NSOrderedAscending) {  //有效期时间比今天的时间要  早  说明已经过期
        IanLog(@"您的驾驶证已经过期");
        
        return @"您的驾驶证已经过期，请在有效期过后一年之内到车管所进行年审，否者将吊销您的驾证！";
    }
    
    
    //没有过期  就进行 准车型判断
    if ([_carType isEqual:@"A1"] || [_carType isEqual:@"A2"] || [_carType isEqual:@"B1"] ||[_carType isEqual:@"B2"] || [_carType isEqual:@"N"] || [_carType isEqual:@"P"]) {
    
        
        NSString *dateStr =[NSString stringWithFormat:@"%@",signDate];
        NSString *subStr =[dateStr substringFromIndex:5];
        
        
        NSString *nowDateStr = [NSString stringWithFormat:@"%@",nowDate];
        NSString *subNowDateStr =[nowDateStr substringToIndex:5];
        NSString *checkDateStr =[[NSString stringWithFormat:@"%@%@",subNowDateStr,subStr] substringToIndex:10];
        NSDate *checkDate =[formatter dateFromString:checkDateStr];
        long seconds =[nowDate timeIntervalSinceDate:checkDate];
        
        int day = (int)seconds / 86400;
        day =day *(-1)+1;
        
        
        if (seconds >=0) {   
            return @"已经过了年审的截止日期，请带好100元，赶快去处理";
        }
  
        NSString *str =[NSString stringWithFormat:@"您的驾驶证的准驾驶车型为%@,所以您需要每年进行一次驾驶证审查，本年驾驶证审查截止时间为%@。请在截止时间前90天之内可以到本地车管所进行驾证审查。距离截止日期还有%d天，需要注意，驾照年审徐亚欧提供驾驶证副本原件、身份证、机动车驾驶员身体条件证明",_carType,checkDateStr,day];
 
        return str;
    }else{
        // 其他准驾车型   需要六年一次换证
        //1、 您的驾驶证的准驾驶车型为C1,所以您需要每六年进行一次驾驶证换证，
        
        if([valiDate compare:nowDate]==NSOrderedAscending){ return @"已过有效期"; }
        
        long seconds = [nowDate timeIntervalSinceDate:valiDate];
        
        if (seconds > 0) {
            return @"过了换证时间";
        }
        
        int day =((int)seconds / 86400)*-1+1;
        
        if (day>365) {
            int year = day / 365;
            int daya = day % 365;
            
            NSString *yearDay = [NSString stringWithFormat:@"%d年零%d天",year,daya];
            
            NSString *str =[NSString stringWithFormat:@"您的驾驶证的准驾驶车型为%@,所以您需要每六年进行一次换证手续。您的驾驶证有效期为%@至%@。所以请在有效期达到前90天内进行换证，距离换证截止日期还有%@，逾期将处以100元罚款，逾期一年您的驾驶证将被吊销，进行换证手续需要提供您的驾驶证副本原件、身份证、机动车驾驶员身体条件证明",_carType,_signTime,_validTime,yearDay];
            
            return str;
        }
        
        NSString *str =[NSString stringWithFormat:@"您的驾驶证的准驾驶车型为%@,所以您需要每六年进行一次换证手续。您的驾驶证有效期为%@至%@。所以请在有效期达到前90天内进行换证，距离换证截止日期还有%d，逾期将处以100元罚款，逾期一年您的驾驶证将被吊销，进行换证手续需要提供您的驾驶证副本原件、身份证、机动车驾驶员身体条件证明",_carType,_signTime,_validTime,day];
        
        return str;
    
    }
    return @"暂无任何提醒消息";
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

 

@end
