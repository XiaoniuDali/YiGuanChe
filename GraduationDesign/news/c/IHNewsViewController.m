//
//  IHNewsViewController.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/11.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//
#import "appMarco.h"
#import "IHNewsViewController.h"

@interface IHNewsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation IHNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setSubviews];

}

-(void)setSubviews
{
    UITableView *tableView =[[UITableView alloc] init];
    [tableView setFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.height-48)];
    tableView.delegate =self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];
    self.tableView =tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.text =@"这里使用tableview 需要想想怎么设置cell的现实样式";

    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

 

@end
