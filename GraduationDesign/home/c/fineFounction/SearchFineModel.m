//
//  SearchFineModel.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/4.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "SearchFineModel.h"

@implementation SearchFineModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.id forKey:@"id"];

    [aCoder encodeInteger:self.money forKey:@"money"];
    [aCoder encodeInteger:self.car_id forKey:@"car_id"];
    [aCoder encodeObject:self.occur_date forKey:@"occur_date"];
    [aCoder encodeObject:self.occur_area forKey:@"occur_area"];
    [aCoder encodeInteger:self.city_id forKey:@"city_id"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.city_name forKey:@"city_name"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeInteger:self.fen forKey:@"fen"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeInteger:self.province_id forKey:@"province_id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.id = [aDecoder decodeIntegerForKey:@"id"];
 
        self.money = [aDecoder decodeIntegerForKey:@"money"];
        self.car_id = [aDecoder decodeIntegerForKey:@"car_id"];
        self.occur_date = [aDecoder decodeObjectForKey:@"occur_date"];
        self.occur_area = [aDecoder decodeObjectForKey:@"occur_area"];
        self.city_id = [aDecoder decodeIntegerForKey:@"city_id"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.city_name = [aDecoder decodeObjectForKey:@"city_name"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.fen = [aDecoder decodeIntegerForKey:@"fen"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.province_id = [aDecoder decodeIntegerForKey:@"province_id"];
    }
    return self;
}


@end
