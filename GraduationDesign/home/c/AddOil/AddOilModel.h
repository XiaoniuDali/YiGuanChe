//
//  AddOilModel.h
//  GraduationDesign
//
//  Created by shupengstar on 16/5/12.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Price;
@interface AddOilModel : NSObject

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, copy) NSString *exhaust;

@property (nonatomic, assign) NSInteger lon;

@property (nonatomic, copy) NSString *brandname;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *fwlsmc;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger lat;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) Price *price;

@property (nonatomic, copy) NSString *areaname;

@property (nonatomic, copy) NSString *gastprice;

@property (nonatomic, copy) NSString *name;

@end
@interface Price : NSObject

@property (nonatomic, copy) NSString *E93;

@property (nonatomic, copy) NSString *E90;

@property (nonatomic, copy) NSString *E97;

@property (nonatomic, copy) NSString *E0;

@end

