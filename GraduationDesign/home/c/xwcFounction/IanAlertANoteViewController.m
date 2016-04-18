//
//  IanAddRepairNoteViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/5.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanAlertANoteViewController.h"
#import "appMarco.h"
#import "FMDatabase.h"


@interface IanAlertANoteViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,strong) NSArray * repairNames;
@property (nonatomic,strong) UITextField * moneyTf;
@property (nonatomic,strong) UITextField * siteTf;
@property (nonatomic,strong) NSMutableDictionary * repairNotesDict;
@property (nonatomic,assign) NSString * date;
@property (nonatomic,assign) NSString * repairName;


@end

@implementation IanAlertANoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame =IanMainScreen.bounds;
    [self.view setBackgroundColor:ianRGBColor(231, 231, 231)];
    self.title =@"增加维修记录";
    
    [self setSubviews];
    
    self.db =[self openDataBase];
    
    BOOL result =[ self.db executeUpdate:@"create table if not exists repairNote (id integer primary key autoincrement,time text,site text,money text,projectName text)"];
    
    if (result) {
        IanLog(@"创建表成功");
    }else
    {
        IanLog(@"创建表失败");
    }
    _repairNotesDict =[NSMutableDictionary  dictionaryWithObjectsAndKeys:@"0",@"time",@"0",@"site",@"0",@"name",@"0",@"money", nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.db close];
}


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


-(void)setSubviews
{
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 125, 50)];
    label.text =@"1、保养项目：";
    [self.view addSubview:label];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(150,85,150, 80)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [self.view addSubview:pickerView];
    
    
    UILabel *dateLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 115, 50)];
    dateLabel.text =@"2、保养日期：";
    [self.view addSubview:dateLabel];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(115,175,300,100)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDate* minDate = [[NSDate alloc] initWithTimeIntervalSince1970:0];//initWithString:@"1900-01-01 00:00:00 -0500"];
    NSDate* maxDate = [[NSDate alloc] init]; //:@"2099-01-01 00:00:00 -0500"];
    
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    [ datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [ self.view addSubview:datePicker];
    
    UILabel *siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300,125,50)];
    siteLabel.text =@"3、保养地点：";
    [self.view addSubview:siteLabel];
    
    _siteTf =[[UITextField alloc] initWithFrame:CGRectMake(135,300,200,50)];
    _siteTf.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_siteTf];
    
    
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 400,125,50)];
    moneyLabel.text =@"4、保养费用：";
    [self.view addSubview:moneyLabel];
    
    _moneyTf =[[UITextField alloc] initWithFrame:CGRectMake(135,400,200,50)];
    _moneyTf.backgroundColor =[UIColor whiteColor];
    _moneyTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_moneyTf];
    
    
    
    UIButton *addBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.view.width *0.5 -25, self.view.height -70 ,50,30)];
    addBtn.backgroundColor =[UIColor redColor];
    [addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRepair) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    
    UIButton *delBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.view.width *0.5 -25, self.view.height -70 ,50,30)];
    delBtn.backgroundColor =[UIColor redColor];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delRepair) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    
    
}



-(void)dateChanged:(UIDatePicker *)picker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:picker.date];
    [_repairNotesDict setValue:currentDateStr forKey:@"time"];
    
    IanLog([NSString stringWithFormat:@"%@",currentDateStr]);
}


#pragma -mark 删除了一条数据
-(void)delRepair
{
    
    IanLog(@"阿斯顿发生的发");
    
}


#pragma -mark 增加一条数据
-(void)addRepair
{
    NSString *money =_moneyTf.text;
    
    
    if (_moneyTf.text == nil )   money =@"0";
    if ([_repairNotesDict[@"time"] isEqual: @"0"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr  = [dateFormatter stringFromDate:[[NSDate alloc] init]];
        
        [_repairNotesDict setValue:currentDateStr forKey:@"time"];
    }
    
    if ([_repairNotesDict[@"name"]  isEqual: @"0"]) {
        
        [_repairNotesDict setValue:@"发动机机油" forKey:@"name"];
    }
    
    
    
    [_repairNotesDict setValue:_siteTf.text forKey:@"site"];
    [_repairNotesDict setValue:money forKey:@"money"];
    
    
    
    [self insertARepairNoteWithDict:_repairNotesDict];
    
    IanLog(@"增加一条记录");
}

//增加一天保养维修记录
-(void)insertARepairNoteWithDict:(NSDictionary *) dict
{
    [self.db executeUpdate:@"insert into repairNote (site,projectName,money,time) values(?,?,?,?);",dict[@"site"],dict[@"name"],dict[@"money"],dict[@"time"]];
}



#pragma -mark uipickerview的代理方法
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //    NSString *a = [NSString stringWithFormat:@"row===%ld",(long)row];
    _repairNames =[NSArray arrayWithObjects:@"发动机机油",@"机油滤清器",@"空气滤清器",@"燃油滤清器",@"火花塞",@"空调滤清器",@"前刹车片",@"后刹车片",@"前雨刷套装",@"防冻冷却液",@"空调制冷剂",@"蓄电池",@"轮胎",nil];
    
    //    IanLog(_repairNames[0]);
    return _repairNames[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *repairName =(NSString *)_repairNames[row];
    NSString *a =(NSString *)[NSString stringWithFormat:@"选中了%@",repairName];
    [_repairNotesDict setValue:repairName forKey:@"name"];
    
    IanLog(a);
}





@end
