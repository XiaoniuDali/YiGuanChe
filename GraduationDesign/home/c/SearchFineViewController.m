//
//  SearchFineViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/3.
//  Copyright © 2016年 YJH. All rights reserved.
//  http://www.cheshouye.com/api_json.html#a2
/**
 *  违章请求接口
 *
 *  @param 请求接口      http://www.cheshouye.com/api/weizhang/query_task?
 *  @param 参数 car_info  sign  timestamp  app_id
 *  @param appid 1584
 *  @param appkey a9b775f170e69a6fca9753445c02dd2e
 *  @param example 车牌号:粤YM5610,车型:北京现代牌,发动机号:G4GA-5B257630,车架号:LBEPCCAK45X116238,
 *  @return
 */
#import "SearchFineViewController.h"
#import "NetworkManager.h"
#import "SearchFineModel.h"
#import "ProvincesViewController.h"
#import "CityNameViewController.h"
#import "SearchResultViewController.h"
#import "SearchCityModel.h"
#import <MJExtension.h>
#import "MBProgressHUD.h"
@interface SearchFineViewController ()<CityNameViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchPlaceBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UITextField *carTxF;
@property (weak, nonatomic) IBOutlet UITextField *carNumTxF;
@property (weak, nonatomic) IBOutlet UITextField *engineNumTxf;
@property (nonatomic, strong) NSMutableArray *handleMutableArray;
@property (nonatomic, strong) NSMutableArray *cityModelMutableArray;
@property (nonatomic, assign) NSInteger cityId;
@end

@implementation SearchFineViewController
- (NSMutableArray *)handleMutableArray{
    if (!_handleMutableArray) {
        _handleMutableArray = [NSMutableArray array];
    }
    return _handleMutableArray;
}
- (NSMutableArray *)cityModelMutableArray{
    if (!_cityModelMutableArray) {
        _cityModelMutableArray = [NSMutableArray array];
    }
    return _cityModelMutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewLayer];
    [self getCityID];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:) name:@"didSelectCity" object:nil];
}
#pragma mark --- city通知
- (void)changeCity :(NSNotification *)notification{
    
    self.searchPlaceBtn.titleLabel.text = notification.userInfo[@"city"];
    
    self.cityId = [notification.userInfo[@"cityId"] integerValue];
    
    NSString *carHead = notification.userInfo[@"carHead"];
    
    NSString *firstHead = [carHead substringToIndex:1];
    
    [self.cityBtn setTitle:firstHead forState:UIControlStateNormal];    
    
}
#pragma mark --- 圆角设置
- (void)setViewLayer{
    self.backgroundView.layer.cornerRadius = 5.0;
    self.backgroundView.layer.masksToBounds = YES;
    self.searchBtn.layer.cornerRadius = 5.0;
    self.searchBtn.layer.masksToBounds = YES;
    self.cityBtn.layer.cornerRadius = 5.0;
    self.cityBtn.layer.masksToBounds = YES;
    self.cityBtn.enabled = NO;
}
#pragma mark --- cityID
- (void)getCityID{
    
    [IHAcountTool showHUD:@"" andView:self.view];
    
    [[NetworkManager shareMgr] app_get_all_config:nil CompleteHandle:^(NSDictionary *response) {
        if (response[@"configs"] != nil) {
            
            self.cityModelMutableArray = [SearchCityModel mj_objectArrayWithKeyValuesArray:response[@"configs"]];
            
            [IHAcountTool hideHUD];
        } else {
            
            self.cityModelMutableArray = nil;
            
            [IHAcountTool showDelyHUD:@"数据加载失败" andView:self.view];
        }
    }];
}
#pragma mark --- 请求数据
//registno证书编号
- (IBAction)beginSearch:(id)sender {
    
    if (self.cityBtn.titleLabel.text.length == 0) {
        [IHAcountTool showDelyHUD:@"选择城市" andView:self.view];
        return;//选择城市
    }
    if (self.carTxF.text.length == 0) {
        [IHAcountTool showDelyHUD:@"输入车牌号" andView:self.view];
        return;//输入车牌号
    }
    if (self.carNumTxF.text.length == 0) {
        [IHAcountTool showDelyHUD:@"输入车架号" andView:self.view];
        return;//输入车架号
    }
    if (self.engineNumTxf.text.length == 0) {
        [IHAcountTool showDelyHUD:@"发动机号" andView:self.view];
        return;// 发动机号
    }
    
//     carInfo
    NSString *strCarInfo = [NSString stringWithFormat:@"{hphm=%@%@&classno=%@&engineno=%@&registno=&city_id=%ld&car_type=%@}",self.cityBtn.titleLabel.text,self.carTxF.text,self.carNumTxF.text,self.engineNumTxf.text,self.cityId,@"02"];
    
    // 测试
//    NSString *strCarInfo = @"{hphm=渝A75B38&classno=A77439&engineno=5799&registno=&city_id=27&car_type=02}";

    // 时间戳
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    long long int timestamp = (long long int)time;
    // md5加密
    NSString *app_id = @"1584";
    NSString *app_key = @"a9b775f170e69a6fca9753445c02dd2e";
    NSString *strSign = [NSString stringWithFormat:@"%@%@%lld%@",app_id,strCarInfo,timestamp,app_key];
    NSString *md5ForSign = [IHAcountTool md5HexDigest:strSign];

    NSMutableDictionary *fineMuDic = [NSMutableDictionary dictionary];
    [fineMuDic setObject:strCarInfo forKey:@"car_info"];
    [fineMuDic setObject:md5ForSign forKey:@"sign"];
    [fineMuDic setObject:@(timestamp) forKey:@"timestamp"];
    [fineMuDic setObject:app_id forKey:@"app_id"];

    [IHAcountTool showHUD:@"" andView:self.view];
    
    [[NetworkManager shareMgr] app_search_fine:fineMuDic CompleteHandle:^(NSDictionary *response) {
        NSLog(@"信息为%@",response);
        NSString *status = [NSString stringWithFormat:@"%@",response[@"status"]];
        if ([status isEqualToString:@"2000"]) {
            // 弹出正常信息
            [IHAcountTool showDelyHUD:@"恭喜你咩有不良信息" andView:self.view];
        }
        else if ([status isEqualToString:@"2001"]) {
            
            self.handleMutableArray = [SearchFineModel mj_objectArrayWithKeyValuesArray:response[@"historys"]];
            
            SearchResultViewController *searchFineVC = [SearchResultViewController new];
            
            searchFineVC.resultArray = self.handleMutableArray;
            
            [IHAcountTool hideHUD];
            
            [self.navigationController pushViewController:searchFineVC animated:YES];
        }
        else {
            // 输入信息错误
            [IHAcountTool showDelyHUD:@"车辆信息有误" andView:self.view];
        }
    }];
}

#pragma mark --- 选择省份
- (IBAction)findCity:(id)sender {
    if (self.cityModelMutableArray.count == 0) {
        
        [IHAcountTool showDelyHUD:@"请检查网络" andView:self.view];
        
        return;
    }
    ProvincesViewController *provincesVC = [ProvincesViewController new];
    
    provincesVC.provincesArray = self.cityModelMutableArray;
    
    [self.navigationController pushViewController:provincesVC animated:YES];
}
#pragma mark --- 选择省份短名称
- (IBAction)cityNum:(id)sender {
    
    //直接用通知带回，不执行下面的代码了。
    return;
    
//    if (self.cityModelMutableArray.count == 0) {
//        
//        [IHAcountTool showDelyHUD:@"请检查网络" andView:self.view];
//        
//        return;
//    }
//    CityNameViewController *cityName = [CityNameViewController new];
//    
//    cityName.provinceArray = self.cityModelMutableArray;
//    
//    cityName.delegate = self;
//    
//    [self.navigationController pushViewController:cityName animated:YES];
}
#pragma mark --- CityNameViewControllerDelegate
- (void)getCityShortName : (CityNameViewController *)sender : (NSString *)shortName{
    
    self.cityBtn.titleLabel.text = shortName;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didSelectCity" object:nil];
}
@end
