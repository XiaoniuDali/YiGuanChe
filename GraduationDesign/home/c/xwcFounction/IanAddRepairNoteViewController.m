//
//  IanAddRepairNoteViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/5.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanAddRepairNoteViewController.h"
#import "appMarco.h"
#import "FMDatabase.h"


@interface IanAddRepairNoteViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,strong) NSArray * repairNames;
@property (nonatomic,strong) NSArray * repairActions;
@property (nonatomic,strong) UITextField * moneyTf;
@property (nonatomic,strong) UITextField * siteTf;
@property (nonatomic,strong) NSMutableDictionary * repairNotesDict;
@property (nonatomic,assign) NSString * date;
@property (nonatomic,assign) NSString * repairName;


@end

@implementation IanAddRepairNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.frame =IanMainScreen.bounds;
    [self.view setBackgroundColor:ianRGBColor(231, 231, 231)];
    self.title =@"增加维修记录";
    
    
    _repairNames =[NSArray arrayWithObjects:@"发动机机油",@"机油滤清器",@"空气滤清器",@"燃油滤清器",@"火花塞",@"空调滤清器",@"前刹车片",@"后刹车片",@"前雨刷套装",@"防冻冷却液",@"空调制冷剂",@"蓄电池",@"轮胎",@"正时皮带",@"皮带",@"离合器总泵液",@"制动液",@"转向器",@"变速器",@"刹车油",@"手动变速箱油",@"自动变速箱油",nil];
     _repairActions= [[NSArray alloc] initWithObjects:@"更换", @"检查",nil];
    
    [self setSubviews];

    self.db =[self openDataBase];
    
    BOOL result =[ self.db executeUpdate:@"create table if not exists repairNote (id integer primary key autoincrement,time text,site text,money text,projectName text,action text)"];
    
    if (result) {
        IanLog(@"创建表成功");
    }else
    {
        IanLog(@"创建表失败");
    }
    _repairNotesDict =[NSMutableDictionary  dictionaryWithObjectsAndKeys:@"0",@"time",@"0",@"site",@"0",@"name",@"0",@"money",@"0",@"action", nil];
 
 
}



-(void)backBarButtonPressed:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:self];
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
    [label setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:label];
    
 
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(150,55,200, 80)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
//    pickerView setBackgroundColor:[UIColor ]
    
    
    [self.view addSubview:pickerView];
    
    
    UILabel *dateLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 115, 50)];
    dateLabel.text =@"2、保养日期：";
    [dateLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:dateLabel];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(115,145,300,100)];
    datePicker.datePickerMode = UIDatePickerModeDate;
//    [datePicker setBackgroundColor:[UIColor grayColor]];
    
    NSDate* minDate = [[NSDate alloc] initWithTimeIntervalSince1970:0];
    NSDate* maxDate = [[NSDate alloc] init];
    
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    [ datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    
    [ self.view addSubview:datePicker];
    
    UILabel *siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300,125,50)];
    siteLabel.text =@"3、保养地点：";
    [siteLabel setFont:[UIFont systemFontOfSize:13]];
    
    [self.view addSubview:siteLabel];
    
    _siteTf =[[UITextField alloc] initWithFrame:CGRectMake(135,310,200,30)];
    [_siteTf setTextAlignment:NSTextAlignmentCenter];
    _siteTf.backgroundColor =[UIColor clearColor];
    [_siteTf setFont:[UIFont systemFontOfSize:12]];

    [self.view addSubview:_siteTf];
    
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(135,335, 200, 1)];
    [line setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:line];
    
    
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 400,125,50)];
    moneyLabel.text =@"4、保养费用：";
    [moneyLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:moneyLabel];
    
    _moneyTf =[[UITextField alloc] initWithFrame:CGRectMake(135,410,200,30)];
    _moneyTf.backgroundColor =[UIColor clearColor];
    [_moneyTf setFont:[UIFont systemFontOfSize:12]];
    [_moneyTf setTextAlignment:NSTextAlignmentCenter];
   
    _moneyTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_moneyTf];
    
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(135,435, 200, 1)];
    [line1 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:line1];

    
    
    UIButton *addBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.view.width *0.5 -100, self.view.height -120 ,200,30)];
    addBtn.backgroundColor =[UIColor greenColor];
    [addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRepair) forControlEvents:UIControlEventTouchUpInside];
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
    
 
}

#pragma -mark 增加一条数据
-(void)addRepair
{
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
    if ([_repairNotesDict[@"action"] isEqual:@"0"]) {
        [_repairNotesDict setValue:@"更换" forKey:@"action"];
    }
    
    if ([_moneyTf.text isEqual:@""]) {
        [_repairNotesDict setValue:@"0" forKey:@"site"];
    }else{
        [_repairNotesDict setValue:_moneyTf.text forKey:@"money"];
    }
    [_repairNotesDict setValue:_siteTf.text forKey:@"site"];
    
    [self insertARepairNoteWithDict:_repairNotesDict];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    IanLog(@"增加一条记录");
}

//增加一天保养维修记录
-(void)insertARepairNoteWithDict:(NSDictionary *) dict
{
    [self.db executeUpdate:@"insert into repairNote (site,projectName,money,time,action) values(?,?,?,?,?);",dict[@"site"],dict[@"name"],dict[@"money"],dict[@"time"],dict[@"action"]];
}



#pragma -mark uipickerview的代理方法


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2; //显示两列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return 2;
    }
    else
    {
        //否则显示2个标签
        return _repairNames.count;
    }
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==1)
    {
    NSString *repairName =(NSString *)_repairNames[row];
    NSString *a =(NSString *)[NSString stringWithFormat:@"选中了%@",repairName];
    [_repairNotesDict setValue:repairName forKey:@"name"];
        IanLog(@"%@",a);
    }
    if (component==0) {
        
        NSString *repairAction =(NSString *)_repairActions[row];
        NSString *a =(NSString *)[NSString stringWithFormat:@"选中了%@",repairAction];
        [_repairNotesDict setValue:repairAction forKey:@"action"];
        
        
        IanLog(@"%@",a);
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component==0)
    {
        //设置第一列的宽度
        return 50;
    }
    else
    {
        return 120;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (component == 0) {
        
        
       
 
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 25)] ;
        
        [myView setTextAlignment:NSTextAlignmentCenter];
        
        myView.text =_repairActions[row];
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }else {
        
        
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 120, 25)];
        
        myView.text = _repairNames[row];;//[pickerPlaceArray objectAtIndex:row];
        
        [myView setTextAlignment:NSTextAlignmentCenter];
        
        myView.font = [UIFont systemFontOfSize:12];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    
    return myView;
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    return 30.0;
    
}


@end
