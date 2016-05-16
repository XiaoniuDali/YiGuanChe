//
//  ViewController.m
//  CustomMKAnnotationView
//
//  Created by Jian-Ye on 12-11-22.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "CarAgencyViewController.h"
#import <FMDatabase.h>
#import <CoreLocation/CoreLocation.h>
@interface CarAgencyViewController ()<UISearchBarDelegate,CLLocationManagerDelegate>
{
    MapViewController *_mapViewController;
    NSString *_locationCityName;
}
@property (nonatomic, strong) FMDatabase *dataBaseHandle;
//@property (nonatomic, strong) NSMutableArray *locationMuArray;

@end

@implementation CarAgencyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.locationMuArray = [NSMutableArray array];
    
    [self initMapView];

}


- (void)initMapView{
    _mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    _mapViewController.delegate = self;
    [self.view addSubview:_mapViewController.view];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 72, self.view.bounds.size.width-100, 44)];
    
    searchBar.placeholder = @"输入汽车的品牌";
    
    searchBar.delegate = self;
    
    [self.view addSubview:searchBar];
    
    [_mapViewController.view setFrame:self.view.bounds];
    
}
#pragma mark --- searchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    _locationCityName = [_mapViewController returnTheCityName];
    
    self.dataBaseHandle =[self createDatabase];
    // 打开数据库
    [self.dataBaseHandle open];
    
    BOOL result =[ self.dataBaseHandle executeUpdate:@"create table if not exists carAgency (id integer primary key autoincrement,carName text,carBrand text,phoneNum integer,addressDetail text)"];
    
    if (result) {
        NSLog(@"创建表成功");
    }else
    {
        NSLog(@"创建表失败");
    }

//    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM carAngency WHERE addressDetail GLOB '%@*' AND carBrand GLOB '%@'",_locationCityName,searchBar.text];
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM carAgency WHERE addressDetail GLOB '%@*' AND carBrand GLOB '%@'",@"广州",searchBar.text]; // 奔驰
    
    FMResultSet *resultSet = [self.dataBaseHandle executeQuery:sql];
    
    while ([resultSet next]){

        NSDictionary *locationDic=[NSDictionary dictionaryWithObjectsAndKeys:
                                   [resultSet stringForColumn:@"carName"],@"carName",
                                   [resultSet stringForColumn:@"carBrand"],@"carBrand",
                                   [resultSet stringForColumn:@"phoneNum"],@"phoneNum",
                                   [resultSet stringForColumn:@"addressDetail"],@"addressDetail",nil];
        
        [_mapViewController putAddress:locationDic andCityName:nil];
    }
    // 关闭数据库
    [self.dataBaseHandle close];
}

// 数据库路径
- (NSString *)databasePath{
    NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath =[doc stringByAppendingPathComponent:@"appDb.sqlite"];
    
    NSLog(@"保存路径：%@",filePath);
    
    return filePath;
}
// 创建数据库
-(FMDatabase *)createDatabase
{
    FMDatabase *appDb =[FMDatabase databaseWithPath:[self databasePath]];
    
    return appDb;
}
//- (void)viewWillAppear:(BOOL)animated{
//    [self.dataBaseHandle close];
//}
- (void)customMKMapViewDidSelectedWithInfo:(id)info
{
    NSLog(@"%@",info);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
