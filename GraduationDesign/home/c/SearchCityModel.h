//
//  SearchCityModel.h
//  GraduationDesign
//
//  Created by shupengstar on 16/4/5.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Citys;
@interface SearchCityModel : NSObject

@property (nonatomic, copy) NSString *province_name;

@property (nonatomic, strong) NSArray<Citys *> *citys;

@property (nonatomic, assign) NSInteger province_id;

@property (nonatomic, copy) NSString *province_short_name;

@end
@interface Citys : NSObject

@property (nonatomic, copy) NSString *car_head;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, assign) NSInteger registno;

@property (nonatomic, assign) NSInteger classno;

@property (nonatomic, assign) NSInteger engineno;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, assign) NSInteger vcode;

@end

