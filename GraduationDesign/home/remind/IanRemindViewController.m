//
//  IanRemindViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/5/15.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanRemindViewController.h"
#import "appMarco.h"
#import "FMDatabase.h"

@interface IanRemindViewController ()
@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,strong) FMResultSet * set;

@property (nonatomic,strong) UITextView * repairTipsTextView;

@property (nonatomic,strong) UITextView * jiaoZhaoTipsTextView;


@property (nonatomic,strong) UITextView * otherTipsTextView;



@property (nonatomic,strong) NSString * signSite;
@property (nonatomic,strong) NSString * signTime;
@property (nonatomic,strong) NSString * carType;
@property (nonatomic,strong) NSString * validTime;
@property (nonatomic,strong) NSString * practiceTime;
@property (nonatomic,strong) NSString * driveCardId;



@end

@implementation IanRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =IanMainScreen.bounds;
    self.title =@"驾照年审提醒";
    [self.view setBackgroundColor:ianRGBColor(255, 255,255)];
    [self openDatabase];
    [self setSubviews];
    
    _signSite =nil;
    _signTime =nil;
    _carType =nil;
    _validTime =nil;
    _practiceTime=nil;
    _driveCardId=nil;
    
}

-(void)setSubviews
{
    UILabel *repairTips =[[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 30)];
    repairTips.text =@"维修提醒";
    [repairTips setBackgroundColor:ianRGBColor(254, 204, 64)];
    [repairTips setTextColor:ianRGBColor(211, 84, 32)];
    repairTips.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:repairTips];
    
    
    self.repairTipsTextView =[[UITextView alloc]initWithFrame:CGRectMake(0, 90, self.view.width, (self.view.height-150)*0.33)];
    [self.repairTipsTextView setBackgroundColor:ianRGBColor(231, 231,231)];
    self.repairTipsTextView.text =[self getRepairTips];
    
    
    UILabel *jiazhaoTips =[[UILabel alloc] initWithFrame:CGRectMake(0,90+(self.view.height-150)*0.33, self.view.width, 30)];
    jiazhaoTips.text =@"驾照年审提醒";
    [jiazhaoTips setBackgroundColor:ianRGBColor(255, 84, 32)];
//    [jiazhaoTips setTextColor:ianRGBColor(211, 84, 32)];
    jiazhaoTips.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:jiazhaoTips];
    [self.view addSubview:self.repairTipsTextView];
    
    
    
    self.jiaoZhaoTipsTextView =[[UITextView alloc]initWithFrame:CGRectMake(0, 120+(self.view.height-150)*0.33, self.view.width, (self.view.height-150)*0.33)];
    [self.jiaoZhaoTipsTextView setBackgroundColor:ianRGBColor(231, 231,231)];
    [self.view addSubview:self.jiaoZhaoTipsTextView];
    
 

    //设置驾照提示
    [self setData];
 
    
    
    
    
//    ／／／／／／其他提示
    UILabel *otherTips =[[UILabel alloc] initWithFrame:CGRectMake(0,120+(self.view.height-150)*0.66, self.view.width, 30)];
    otherTips.text =@"其他提醒";
    [otherTips setBackgroundColor:ianRGBColor(255, 84, 32)];
    //    [jiazhaoTips setTextColor:ianRGBColor(211, 84, 32)];
    otherTips.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:otherTips];
    
    
    
    self.otherTipsTextView =[[UITextView alloc]initWithFrame:CGRectMake(0, 150+(self.view.height-150)*0.66, self.view.width, (self.view.height-150)*0.33+10)];
    [self.otherTipsTextView setBackgroundColor:ianRGBColor(231, 231,231)];
    self.otherTipsTextView.text =@"这里显示其他提示";
    [self.view addSubview:self.otherTipsTextView];
    
    [self orderFineInfo];
    
}










-(NSString *)orderFineInfo
{
    FMResultSet * set = [self.db executeQuery:@"select * from FineInfo"];
    while ([set next]) {
        NSString *car_id =[set stringForColumn:@"car_id"];
        NSString *city_id =[set stringForColumn:@"city_id"];
        NSString *code =[set stringForColumn:@"code"];
        NSString *fen =[set stringForColumn:@"fen"];
        NSString *info =[set stringForColumn:@"info"];
        NSString *money =[set stringForColumn:@"money"];
        NSString *occur_area =[set stringForColumn:@"occur_area"];
        NSString *occur_date =[set stringForColumn:@"occur_date"];
        NSString *province_id =[set stringForColumn:@"province_id"];
        
        //获得所有新的
     
        self.otherTipsTextView.text = [NSString stringWithFormat:@"您于%@在%@发生了违规现象：“%@”,需要罚款%@元,扣%@分，请及时处理",[occur_date substringWithRange:NSMakeRange(0, 16)],occur_area,info,money,fen];
    }
    return @"dd";
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
    
    if (!set) {
        self.jiaoZhaoTipsTextView.text=@"暂无驾照年审提示消息";
    }else
    {
    self.jiaoZhaoTipsTextView.text =[self signTimeAnalysis];
    }
    
    
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
            return @"您的驾驶证已经过了年审的截止日期，请带好100元，赶快去处理";
        }
        
        NSString *str =[NSString stringWithFormat:@"1、您的驾驶证的准驾驶车型为%@,所以您需要每年进行一次驾驶证审查，本年驾驶证审查截止时间为%@。请在截止时间前90天之内可以到本地车管所进行驾证审查。距离截止日期还有%d天。3、需要注意，驾照年审徐亚欧提供驾驶证副本原件、身份证、机动车驾驶员身体条件证明。",_carType,checkDateStr,day];
        
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
            
            NSString *str =[NSString stringWithFormat:@"1、您的驾驶证的准驾驶车型为%@,所以您需要每六年进行一次换证手续。\n2、您的驾驶证有效期为%@至%@。所以请在有效期达到前90天内进行换证，距离换证截止日期还有%@，逾期将处以100元罚款，逾期一年您的驾驶证将被吊销。\n3、进行换证手续需要提供您的驾驶证副本原件、身份证、机动车驾驶员身体条件证明。",_carType,_signTime,_validTime,yearDay];
            
            return str;
        }
        
        NSString *str =[NSString stringWithFormat:@"1、您的驾驶证的准驾驶车型为%@,所以您需要每六年进行一次换证手续。\n2、您的驾驶证有效期为%@至%@。所以请在有效期达到前90天内进行换证，距离换证截止日期还有%d，逾期将处以100元罚款，逾期一年您的驾驶证将被吊销。\n3、进行换证手续需要提供您的驾驶证副本原件、身份证、机动车驾驶员身体条件证明。",_carType,_signTime,_validTime,day];
        
        return str;
        
    }
    return @"暂无任何提醒消息";
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

-(void)viewDidDisappear:(BOOL)animated
{
    //关闭成功
    [self closeDataBase];
}

@end
