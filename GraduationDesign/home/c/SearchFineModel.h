//
//  SearchFineModel.h
//  GraduationDesign
//
//  Created by shupengstar on 16/4/4.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SearchFineModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *officer;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, assign) NSInteger car_id;

@property (nonatomic, copy) NSString *occur_date;

@property (nonatomic, copy) NSString *occur_area;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, assign) NSInteger fen;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger province_id;

@end