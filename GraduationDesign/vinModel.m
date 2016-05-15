//
//  vinModel.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/2.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "vinModel.h"

//@implementation vinModel
//
//@end
@implementation vinModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.displacement forKey:@"displacement"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.carLong forKey:@"carLong"];
    [aCoder encodeObject:self.carHigh forKey:@"carHigh"];
    [aCoder encodeObject:self.carWidth forKey:@"carWidth"];
    [aCoder encodeObject:self.brand forKey:@"brand"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.engineProducers forKey:@"engineProducers"];
    [aCoder encodeObject:self.productionDate forKey:@"productionDate"];
    [aCoder encodeObject:self.engineType forKey:@"engineType"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.displacement = [aDecoder decodeObjectForKey:@"displacement"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.carLong = [aDecoder decodeObjectForKey:@"carLong"];
        self.carHigh = [aDecoder decodeObjectForKey:@"carHigh"];
        self.carWidth = [aDecoder decodeObjectForKey:@"carWidth"];
        self.brand = [aDecoder decodeObjectForKey:@"brand"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.engineProducers = [aDecoder decodeObjectForKey:@"engineProducers"];
        self.productionDate = [aDecoder decodeObjectForKey:@"productionDate"];
        self.engineType = [aDecoder decodeObjectForKey:@"engineType"];
    }
    return self;
}
@end
