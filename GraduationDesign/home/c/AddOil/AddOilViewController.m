//
//  AddOilViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/5/12.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "AddOilViewController.h"
#import <FMDatabase.h>
#import <CoreLocation/CoreLocation.h>
#import "NetworkManager.h"
#import "AddOilModel.h"
@interface AddOilViewController ()<UISearchBarDelegate,CLLocationManagerDelegate>
{
    MapViewController *_mapViewController;
    NSString *_locationCityName;
    NSMutableArray * _AddOilModelMutableArray;
}
@end

@implementation AddOilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMapView];
    
    _locationCityName = [_mapViewController returnTheCityName];
    
    _AddOilModelMutableArray = [NSMutableArray array];
    
    // 防止乱点，先关闭
//    [self loadData];
    
    [self showAnnotions];

}


- (void)initMapView{
    _mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    _mapViewController.delegate = self;
    
    [self.view addSubview:_mapViewController.view];
    
    [_mapViewController.view setFrame:self.view.bounds];
    
}

- (void)loadData{
    NSDictionary *dic = @{
                          @"city":_locationCityName?_locationCityName:@"江门",
                          @"key":@"ba8b0fb915424e408cc84b3c4a5f4a32",
                          @"page":@"1"
                          };
    [[NetworkManager shareMgr] app_Search_AddOil:dic completeHandle:^(NSDictionary *response) {
        
        _AddOilModelMutableArray = [AddOilModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"data"]];
        
        for (AddOilModel *model in _AddOilModelMutableArray) {
            
            [_mapViewController putAddress:nil andCityName:model.address];
        }
        
        
    }];
}
- (void)showAnnotions{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
