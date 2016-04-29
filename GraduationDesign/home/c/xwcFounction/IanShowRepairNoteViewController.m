//
//  IanShowRepairNoteViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanShowRepairNoteViewController.h"
#import "FMDatabase.h"
#import "appMarco.h"
#import "IanRepairNotesTableViewCell.h"

@interface IanShowRepairNoteViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) FMDatabase * DB;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) FMResultSet * set;
@property (nonatomic,strong) NSMutableArray * MArray;


@end

@implementation IanShowRepairNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame =IanMainScreen.bounds;
    
    [self.view setBackgroundColor:ianRGBColor(231, 231, 231)];
    self.title =@"所有维修记录";
    
    self.DB = [self openDataBase];
    

    _set =[[FMResultSet alloc] init];
    _set =[self.DB executeQuery:@"select * from repairNote"];
    
    
    _MArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *data =[[NSMutableDictionary alloc] init];
    while ([_set next]) {
        [data setValue:[_set stringForColumn:@"projectName"]  forKey:@"name"];
        [data setValue:[_set stringForColumn:@"time"]  forKey:@"time"];
        [data setValue:[_set stringForColumn:@"site"]  forKey:@"site"];
        [data setValue:[_set stringForColumn:@"money"]  forKey:@"money"];
        [_MArray addObject:data];
    }
    
    
    
    [self setSubView];
    
    
    
    // 初始化一个返回按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
//    [button setBackgroundColor:ianRandomColor];
    // 为返回按钮设置图片样式
    [button setImage:[UIImage imageNamed:@"chevron-left.png"] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];


    // 设置返回按钮触发的事件
    [button addTarget:self action:@selector(backBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // 初始化一个BarButtonItem，并将其设置为返回的按钮的样式
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 将BarButtonItem添加到LeftBarButtonItem上
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    

}


-(void)backBarButtonPressed:(UIButton *)btn
{
     [self.navigationController popViewControllerAnimated:YES];
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


#pragma -mark setView 创建子控件
-(void)setSubView
{
    _tableView =[[UITableView alloc] initWithFrame:self.view.bounds];
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
    NSLog(@"%ld",(long)_MArray.count);
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
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, 27)];
    [view setBackgroundColor:ianRGBColor(17, 120, 255)];
    
    
    UIView  *topLine =[[UIView alloc] initWithFrame:CGRectMake(0, 0, IanMainScreen.bounds.size.width, 1)];
    [topLine setBackgroundColor:[UIColor blackColor]];
    [view addSubview:topLine];
    
    
    UILabel *labelName =[[UILabel alloc] initWithFrame:CGRectMake(0, 1, 0.25*self.view.width, 25)];
    [labelName setTextAlignment:NSTextAlignmentCenter];
    labelName.text =@"项目名称";
    [labelName setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:labelName];
    
    
    UIView *line1 =[[UIView alloc] initWithFrame:CGRectMake(0.25*self.view.width,1, 1, 25)];
    [view addSubview:line1];
    [line1 setBackgroundColor:[UIColor blackColor]];
    
    
    
    
    UILabel *labelTime =[[UILabel alloc] initWithFrame:CGRectMake(0.25*self.view.width+1, 1, 0.25*self.view.width-1, 25)];
    [labelTime setTextAlignment:NSTextAlignmentCenter];
    labelTime.text =@"时间";
    [labelTime setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:labelTime];
    
    UIView *line2 =[[UIView alloc] initWithFrame:CGRectMake(0.5*self.view.width,1, 1, 25)];
    [view addSubview:line2];
    [line2 setBackgroundColor:[UIColor blackColor]];
 
    
    
    UILabel *labelSite =[[UILabel alloc] initWithFrame:CGRectMake(0.5*self.view.width+1, 1, 0.25*self.view.width-1, 25)];
    [labelSite setTextAlignment:NSTextAlignmentCenter];
    [labelSite setFont:[UIFont systemFontOfSize:15]];
    labelSite.text =@"地点";
    [view addSubview:labelSite];
    
    
    UIView *line3 =[[UIView alloc] initWithFrame:CGRectMake(0.75*self.view.width,1, 1, 25)];
    [view addSubview:line3];
    [line3 setBackgroundColor:[UIColor blackColor]];
    
    
    
    UILabel *labelMoney =[[UILabel alloc] initWithFrame:CGRectMake(0.75*self.view.width+1, 1, 0.25*self.view.width-1, 25)];
    [labelMoney setTextAlignment:NSTextAlignmentCenter];
    [labelMoney setFont:[UIFont systemFontOfSize:15]];
    labelMoney.text =@"费用(元)";
    [view addSubview:labelMoney];
    
    
    UIView  *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(0, 25, IanMainScreen.bounds.size.width, 1)];
    [bottomLine setBackgroundColor:[UIColor blackColor]];
    [view addSubview:bottomLine];
    

    return view;
}

 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    IanRepairNotesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[IanRepairNotesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        IanLog(@"%@",@"dddd");
        IanLog(@"%@",_MArray[indexPath.row][@"name"]);
        
        NSDictionary *dict =(NSDictionary *)_MArray[indexPath.row];
        [cell setCellWithData:dict];
    }
    return cell;
}


 



@end
