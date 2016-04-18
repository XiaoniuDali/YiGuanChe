//
//  IanShowRepairNoteViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanAlterNoteViewController.h"
#import "FMDatabase.h"
#import "appMarco.h"
#import "IanAlterNoteTableViewCell.h"

@interface IanAlterNoteViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) FMDatabase * DB;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) FMResultSet * set;
@property (nonatomic,strong) NSMutableArray * MArray;


@end

@implementation IanAlterNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame =IanMainScreen.bounds;
    
    [self.view setBackgroundColor:ianRGBColor(231, 231, 231)];
    self.title =@"增加维修记录";
    
    self.DB = [self openDataBase];
    
    
    _set =[[FMResultSet alloc] init];
    _set =[self.DB executeQuery:@"select * from repairNote"];
    
    
    _MArray = [[NSMutableArray alloc] init];
    
    while ([_set next]) {
         NSMutableDictionary *data =[[NSMutableDictionary alloc] init];
        [data removeAllObjects];
        [data setValue:[_set stringForColumn:@"projectName"]  forKey:@"name"];
        [data setValue:[_set stringForColumn:@"time"]  forKey:@"time"];
        [data setValue:[_set stringForColumn:@"id"] forKey:@"ID"];
        [_MArray addObject:data];
         data =nil;
    }
    
    
    
    
    [self setSubView];
    
}



-(void)viewDidDisappear:(BOOL)animated
{
    [self.DB close];
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


#pragma -mark setView 创建子空间
-(void)setSubView
{
    _tableView =[[UITableView alloc] initWithFrame:self.view.bounds];      //CGRectMake(0, 0, self.view.width, 25*_MArray.count) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
}


#pragma -mark uitableview的代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog([NSString stringWithFormat:@"%ld",(long)_MArray.count]);
    return _MArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, 25)];
    
    
    UILabel *labelName =[[UILabel alloc] initWithFrame:CGRectMake(0.1*self.view.width, 0, 0.25*self.view.width, 25)];
    [labelName setTextAlignment:NSTextAlignmentCenter];
    labelName.text =@"项目名称";
    [view addSubview:labelName];
    
    
    
    UILabel *labelTime =[[UILabel alloc] initWithFrame:CGRectMake(0.65*self.view.width, 0, 0.25*self.view.width, 25)];
    [labelTime setTextAlignment:NSTextAlignmentCenter];
    labelTime.text =@"时间";
    [view addSubview:labelTime];
    
    
    
    
//    
//    UILabel *labelSite =[[UILabel alloc] initWithFrame:CGRectMake(0.5*self.view.width, 0, 0.25*self.view.width, 25)];
//    [labelSite setTextAlignment:NSTextAlignmentCenter];
//    labelSite.text =@"地点";
//    [view addSubview:labelSite];
//    
//    
//    
//    UILabel *labelMoney =[[UILabel alloc] initWithFrame:CGRectMake(0.75*self.view.width, 0, 0.25*self.view.width, 25)];
//    [labelMoney setTextAlignment:NSTextAlignmentCenter];
//    labelMoney.text =@"费用";
//    [view addSubview:labelMoney];
    
    
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    IanAlterNoteTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[IanAlterNoteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    IanLog(@"%@",_MArray[indexPath.row][@"name"]);
    
    NSDictionary *dict =(NSDictionary *)_MArray[indexPath.row];
    [cell setCellWithData:dict];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IanLog(@"%ld",(long)indexPath.row);
    NSString * ID =_MArray[indexPath.row][@"ID"];
    
    IanLog(@"id===%@",ID);
//    FMResultSet * set =[self.DB executeQuery:@"select * from repairNote where id = ?;",ID];
    
//    [set next];
//    IanLog(@"projectName====%@",[set stringForColumn:@"projectName"]);
//    self.DB executeQuery: withArgumentsInArray:<#(NSArray *)#>
}




@end
