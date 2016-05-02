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
#import "IanAlertANoteViewController.h"

@interface IanAlterNoteViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) FMDatabase * DB;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) FMResultSet * set;
@property (nonatomic,strong) NSMutableArray * MArray;
@property (nonatomic,assign) NSString * ID;


@end

@implementation IanAlterNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =IanMainScreen.bounds;
    
    [self.view setBackgroundColor:ianRGBColor(231, 231, 231)];
    self.title =@"维修记录";
    
    self.DB = [self openDataBase];
    [self getMArrayData];
    
    
//    _set =[[FMResultSet alloc] init];
  

    [self setSubView];
    
}

-(void)getMArrayData
{
    _set =[self.DB executeQuery:@"select * from repairNote"];
    _MArray = [[NSMutableArray alloc] init];
    
    while ([_set next]) {
        NSMutableDictionary *data =[[NSMutableDictionary alloc] init];
        [data removeAllObjects];
        [data setValue:[_set stringForColumn:@"projectName"]  forKey:@"name"];
        [data setValue:[_set stringForColumn:@"time"]  forKey:@"time"];
        [data setValue:[_set stringForColumn:@"action"] forKey:@"action"];
        [data setValue:[_set stringForColumn:@"id"] forKey:@"ID"];
        [_MArray addObject:data];
        data =nil;
    }
    
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
    return _MArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, 25)];
    [view setBackgroundColor:ianRGBColor(17, 120, 255)];
    
    
    UILabel *labelName =[[UILabel alloc] initWithFrame:CGRectMake(0.1*self.view.width, 0, 0.25*self.view.width, 25)];
    [labelName setTextAlignment:NSTextAlignmentCenter];
    labelName.text =@"项目名称";
    [labelName setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:labelName];
    
    
    
    UILabel *labelTime =[[UILabel alloc] initWithFrame:CGRectMake(0.65*self.view.width, 0, 0.25*self.view.width, 25)];
    [labelTime setTextAlignment:NSTextAlignmentCenter];
    labelTime.text =@"时间";
    [labelTime setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:labelTime];
    
    
    UIView *line1 =[[UIView alloc] initWithFrame:CGRectMake(0.5*self.view.width,1, 1, 25)];
    [view addSubview:line1];
    [line1 setBackgroundColor:[UIColor blackColor]];
    
    
    UIView  *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(0, 25, IanMainScreen.bounds.size.width, 1)];
    [bottomLine setBackgroundColor:[UIColor blackColor]];
    [view addSubview:bottomLine];
    
    UIView  *topLine =[[UIView alloc] initWithFrame:CGRectMake(0, 0, IanMainScreen.bounds.size.width, 1)];
    [topLine setBackgroundColor:[UIColor blackColor]];
    [view addSubview:topLine];
  
 
    
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    IanAlterNoteTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[IanAlterNoteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
  
    NSDictionary *dict =(NSDictionary *)_MArray[indexPath.row];
    [cell setCellWithData:dict];
 
    return cell;
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    NSString * ID =_MArray[indexPath.row][@"ID"];
  
    self.ID = ID;
    
    
    UIAlertController *alertController = [UIAlertController new];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 调用删除的方法
        [self deleteData];
    }];
    UIAlertAction *change = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //调用修改方法
        [self changeData];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
 
    
    [alertController addAction:delete];
    [alertController addAction:change];
    [alertController addAction:cancel];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
 
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
  
}

-(void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}



- (void)deleteData
{
    [self.DB executeUpdate:@"delete from repairNote where id = ?",self.ID];
    [self getMArrayData];
    [self.tableView reloadData];
}
- (void)changeData
{
    IanAlertANoteViewController *alertANoteViewC =[[IanAlertANoteViewController alloc] init];
    alertANoteViewC.ID = self.ID;
    [self.navigationController pushViewController:alertANoteViewC animated:YES];
    
}





@end
