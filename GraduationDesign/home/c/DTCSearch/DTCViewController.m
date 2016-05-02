//
//  DTCViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "DTCViewController.h"
#import "DTCTableViewCell.h"
#import "NetworkManager.h"
@interface DTCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *dtcTableView;
@property (nonatomic, strong)NSMutableDictionary *dtcMudic;
@property (nonatomic, strong)NSString *dtcString;
@end

@implementation DTCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.title = @"DTC查询";
    [IHAcountTool setExtraCellLineHidden:self.dtcTableView];
    [self initCode];
}
- (void)initCode{
    __weak typeof(self)weakSelf = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入DTC错误编号" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.dtcString = alertController.textFields.lastObject.text;
        if (weakSelf.dtcString.length == 0) {
            [IHAcountTool showDelyHUD:@"未输入DTC" andView:self.view];
            return ;
        }
        //        @"P0108"
        [IHAcountTool showHUD:@"" andView:self.view];
        //        [weakSelf loadData]; // 注销方法，用的时候可以点开
        
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSLog(@"adf");
        textField.placeholder = @"输入DTC";
        
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)initTableView{
    self.dtcTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.dtcTableView.delegate = self;
    self.dtcTableView.dataSource = self;
    [self.view addSubview:self.dtcTableView];
    
    self.dtcTableView.estimatedRowHeight = 123.0;
    self.dtcTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.dtcMudic = [NSMutableDictionary dictionary];
}

- (void)loadData{
    //{"result":{"body":{"description":"歧管绝对压力（传感器）/大气压力（传感器）电路高","dtcleavel":null,"aftermath":"怠速或者减速不稳，点火困难","type":"发动机系统","remind":"传感器信号电路短路到正极，传感器故障，或电子控制模块故障，立即维修"}},"reason":"查询成功","error_code":"0"}
    NSDictionary *dic = @{
                          @"key" : @"0e12d4c090977e2261d2a776df227bcd",
                          @"code" :self.dtcString //@"P0108"
                          };
    [[NetworkManager shareMgr] app_search_DTC:dic completeHandle:^(NSDictionary *respose) {
        
        NSLog(@"%@",respose);
        
        if ([respose[@"error_code"] isEqualToString:@"0"]) {
            
            self.dtcMudic = respose[@"result"][@"body"];
            
            [IHAcountTool hideHUD];
        } else {
            
            [IHAcountTool showDelyHUD:@"输入DTC有误" andView:self.view];
        }
        
        [self.dtcTableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DTCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DTCTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DTCTableViewCell" owner:self options:nil]lastObject];
    }
    [cell setViewForDic:self.dtcMudic];
    
    return cell;
}

@end
