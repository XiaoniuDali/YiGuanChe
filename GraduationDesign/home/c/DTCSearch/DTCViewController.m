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
@end

@implementation DTCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self loadData];
    [self initCode];
    // Do any additional setup after loading the view.
}
- (void)initCode{
    
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
//    secret e7f39890989044df8a49c4b753347575
//    appid 17910
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    long long int timestamp = (long long int)time;
    
    NSDictionary *dic = @{
                          @"code" :@"P0108",
                          @"showapi_appid" :@"15779",//@"17911",
                          @"showapi_timestamp" :[NSString stringWithFormat:@"%lld",timestamp],
                          @"showapi_sign" :@"0723fdd1d15391183b50f80b20df91ab"//@"037b2e2c851849dda5eb06e98962a636",
                          };
    
    [[NetworkManager shareMgr] app_search_DTC:dic completeHandle:^(NSDictionary *response) {
        NSLog(@"response:%@",response);
        self.dtcMudic = response[@"showapi_res_body"][@"result"][@"body"];
    }];
    //https://route.showapi.com/854-1?code=P0108&showapi_appid=15779&showapi_timestamp=20160416005432&showapi_sign=
    //
    //0723fdd1d15391183b50f80b20df91ab
    //{
    //    "showapi_res_code": 0,
    //    "showapi_res_error": "",
    //    "showapi_res_body": {
    //        "error_code": "0",
    //        "reason": "查询成功",
    //        "result": {
    //            "body": {
    //                "aftermath": "怠速或者减速不稳，点火困难",
    //                "description": "歧管绝对压力（传感器）/大气压力（传感器）电路高",
    //                "remind": "传感器信号电路短路到正极，传感器故障，或电子控制模块故障，立即维修",
    //                "type": "发动机系统"
    //            }
    //        }
    //    }
    //}
    

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
