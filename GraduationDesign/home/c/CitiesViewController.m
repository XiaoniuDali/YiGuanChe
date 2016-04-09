//
//  CitiesViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/4.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "CitiesViewController.h"
#import "SearchFineViewController.h"

@interface CitiesViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ProvinceModel.citys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cities";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.ProvinceModel.citys[indexPath.row].city_name;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cityName = self.ProvinceModel.citys[indexPath.row].city_name;
    NSInteger cityId = self.ProvinceModel.citys[indexPath.row].city_id;
    NSString *carHead = self.ProvinceModel.citys[indexPath.row].car_head;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectCity" object:self userInfo:@{@"city" : cityName,@"cityId" : @(cityId),@"carHead" : carHead}];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[SearchFineViewController class]]) {
            
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

@end
