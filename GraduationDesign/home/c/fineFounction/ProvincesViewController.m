//
//  ProvincesViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/4.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "ProvincesViewController.h"
#import "CitiesViewController.h"
#import "SearchCityModel.h"
@interface ProvincesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *provincesTableView;
@end

@implementation ProvincesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

#pragma mark --- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.provincesArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifierId = @"provinces";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierId];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    SearchCityModel *provinceModel = self.provincesArray[indexPath.row];
    
    cell.textLabel.text = provinceModel.province_name;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CitiesViewController *cities = [CitiesViewController new];
    
    SearchCityModel *provinceModel = self.provincesArray[indexPath.row];
    
    cities.ProvinceModel = provinceModel;
    
    [self.navigationController pushViewController:cities animated:YES];
}
@end
